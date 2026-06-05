#!/usr/bin/env python3
import argparse
import csv
import html
import json
import re
from collections import OrderedDict, defaultdict
from datetime import datetime

WEEKDAYS_KO = ["월", "화", "수", "목", "금", "토", "일"]
GROUP_RE = re.compile(r"^\s*(\([^()]+\))\s*(.+?)\s*$")


def date_label(value):
    day = datetime.strptime(value[:10], "%Y-%m-%d").date()
    return f"{day.year}.{day.month:02d}.{day.day:02d} ({WEEKDAYS_KO[day.weekday()]})"


def split_summary(summary):
    summary = " ".join((summary or "").split())
    match = GROUP_RE.match(summary)
    if match:
        return match.group(1), match.group(2)
    return "", summary


def build_html(items_by_group):
    chunks = []
    for group, items in items_by_group.items():
        clean_items = [item for item in items if item]
        if not clean_items:
            continue
        if group:
            chunks.append(f"<p>{html.escape(group)}</p>")
        chunks.append("<ol>" + "".join(f"<li>{html.escape(item)}</li>" for item in clean_items) + "</ol>")
    return "".join(chunks)


def main():
    parser = argparse.ArgumentParser(description="Build Confluence daily report cell HTML from Calendar.app TSV events.")
    parser.add_argument("--events", required=True, help="TSV file from week_events.applescript")
    parser.add_argument("--output", required=True, help="JSON output path")
    parser.add_argument("--include-weekend", action="store_true", help="Include Saturday and Sunday events")
    args = parser.parse_args()

    grouped = OrderedDict()
    with open(args.events, newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source, delimiter="\t")
        for row in reader:
            start = row.get("start_date", "")
            if not start:
                continue
            day = datetime.strptime(start[:10], "%Y-%m-%d").date()
            if day.weekday() >= 5 and not args.include_weekend:
                continue
            summary = row.get("summary", "").strip()
            if not summary:
                continue
            label = date_label(start)
            group, item = split_summary(summary)
            grouped.setdefault(label, defaultdict(list))[group].append(item)

    result = OrderedDict((label, build_html(items_by_group)) for label, items_by_group in grouped.items())
    with open(args.output, "w", encoding="utf-8") as target:
        json.dump(result, target, ensure_ascii=False, indent=2)
        target.write("\n")

    for label, cell_html in result.items():
        print(f"{label}\t{cell_html}")


if __name__ == "__main__":
    main()
