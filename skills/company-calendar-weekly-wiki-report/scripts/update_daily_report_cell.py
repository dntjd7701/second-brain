#!/usr/bin/env python3
import argparse
import html
import json
import re
import sys

DAILY_HEADING_RE = re.compile(r"(<h2>\s*일일보고\s*</h2>\s*)(<table\b.*?</table>)", re.DOTALL)
ROW_RE = re.compile(r"<tr\b[^>]*>.*?</tr>", re.DOTALL)
CELL_RE = re.compile(r"<t[dh]\b[^>]*>.*?</t[dh]>", re.DOTALL)
DATE_RE = re.compile(r"\d{4}\.\d{2}\.\d{2}\s*\([월화수목금토일]\)")


def strip_tags(value):
    text = re.sub(r"<[^>]+>", "", value)
    return html.unescape(text).replace("\xa0", " ").strip()


def cell_tag_parts(cell):
    match = re.match(r"(<t[dh]\b[^>]*>)(.*)(</t[dh]>)", cell, re.DOTALL)
    if not match:
        raise ValueError(f"Invalid table cell: {cell[:80]}")
    return match.group(1), match.group(2), match.group(3)


def replace_cell_content(cell, content):
    open_tag, _old_content, close_tag = cell_tag_parts(cell)
    return f"{open_tag}{content}{close_tag}"


def rebuild_row(row, replacements):
    matches = list(CELL_RE.finditer(row))
    rebuilt = []
    cursor = 0
    for index, match in enumerate(matches):
        rebuilt.append(row[cursor:match.start()])
        rebuilt.append(replacements[index])
        cursor = match.end()
    rebuilt.append(row[cursor:])
    return "".join(rebuilt)


def find_author_index(header_row, author):
    cells = CELL_RE.findall(header_row)
    headers = [strip_tags(cell) for cell in cells]
    for index, header in enumerate(headers):
        if header == author:
            return index
    raise ValueError(f"Author column not found: {author}")


def patch_table(table_html, items, author):
    rows = ROW_RE.findall(table_html)
    if not rows:
        raise ValueError("No rows found in daily report table")

    header_row_index = None
    author_index = None
    for index, row in enumerate(rows):
        if "날짜" in strip_tags(row) and author in strip_tags(row):
            header_row_index = index
            author_index = find_author_index(row, author)
            break

    if header_row_index is None or author_index is None:
        raise ValueError(f"Daily report header row or author column not found: {author}")

    wanted_dates = {date: content for date, content in items.items() if content}
    patched_dates = set()
    patched_rows = {}

    for index, row in enumerate(rows[header_row_index + 1 :], start=header_row_index + 1):
        cells = CELL_RE.findall(row)
        if len(cells) <= author_index:
            continue
        first_cell_text = strip_tags(cells[0])
        date_match = DATE_RE.search(first_cell_text)
        if not date_match:
            continue
        date_label = date_match.group(0)
        if date_label not in wanted_dates:
            continue
        cells[author_index] = replace_cell_content(cells[author_index], wanted_dates[date_label])
        patched_row = rebuild_row(row, cells)
        patched_rows[index] = patched_row
        patched_dates.add(date_label)

    missing = sorted(set(wanted_dates) - patched_dates)
    if missing:
        raise ValueError("Date rows not found: " + ", ".join(missing))

    patched_table = table_html
    for index, original_row in enumerate(rows):
        if index in patched_rows:
            patched_table = patched_table.replace(original_row, patched_rows[index], 1)
    return patched_table, sorted(patched_dates)


def main():
    parser = argparse.ArgumentParser(description="Patch the target author cells in the Confluence 일일보고 table.")
    parser.add_argument("--raw", required=True, help="Raw Confluence storage HTML path")
    parser.add_argument("--items", required=True, help="Date-keyed JSON from build_week_report_items.py")
    parser.add_argument("--author", default="강우성", help="Author column header")
    parser.add_argument("--output", required=True, help="Updated raw storage output path")
    args = parser.parse_args()

    with open(args.raw, encoding="utf-8") as source:
        raw = source.read()
    with open(args.items, encoding="utf-8") as source:
        items = json.load(source)

    match = DAILY_HEADING_RE.search(raw)
    if not match:
        raise ValueError("Could not find the 일일보고 table")

    patched_table, patched_dates = patch_table(match.group(2), items, args.author)
    updated = raw[: match.start(2)] + patched_table + raw[match.end(2) :]

    with open(args.output, "w", encoding="utf-8") as target:
        target.write(updated)

    print("patched_dates=" + ", ".join(patched_dates))
    if raw == updated:
        print("warning=no_changes", file=sys.stderr)


if __name__ == "__main__":
    main()
