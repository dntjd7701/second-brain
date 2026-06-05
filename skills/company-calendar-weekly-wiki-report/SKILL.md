---
name: company-calendar-weekly-wiki-report
description: Use when the user wants to pull this week's work events from Google Calendar as synced into macOS Calendar, specifically the local Calendar database entries under the calendar title 회사, and write them into the Duzon Confluence weekly daily-report page under the correct date and author column.
---

# Company Calendar Weekly Wiki Report

## Purpose

Write the user's Google Calendar work events into the Duzon Confluence daily-report wiki for the current work week.

Default target:

- Source: Google Calendar events synced into macOS Calendar's local cache
- Week range: Monday 00:00 through next Monday 00:00 for the invocation date
- Event filter: local Calendar database calendars where `Calendar.title = '회사'`
- Wiki page: `356399270`
- Report section: `일일보고`
- Author column: `강우성`

## Required Tools

- Prefer the local Calendar SQLite cache at `~/Library/Calendars/Calendar.sqlitedb`.
- Use `scripts/week_company_events_sqlite.py` to export this week's `회사` events as TSV.
- macOS `osascript` can be used only as a fallback. In Codex desktop sandbox sessions, Calendar.app may not be discoverable even when the user can see it in macOS.
- Use `wiki_get_page(page_id="356399270", raw=true)` before editing.
- Use `wiki_update_page` only after reviewing the generated update.
- Re-fetch the wiki page after saving and verify the changed date cells.

## First Setup

1. Query the local Calendar database's `Calendar` table.
2. Confirm that one or more rows have `title = '회사'`.
3. Treat those rows as the source calendars for work-report events.
4. Do not infer work items from calendar color alone; the observed reliable key is the calendar title `회사`.
5. If no `회사` calendar exists in the database, stop and ask the user to sync Calendar or provide a Google Calendar API source.

Observed local schema:

- Calendar DB: `~/Library/Calendars/Calendar.sqlitedb`
- Calendar table: `Calendar(ROWID, title, color, symbolic_color_name, external_id, self_identity_email, ...)`
- Event table: `CalendarItem(summary, description, start_date, end_date, all_day, calendar_id, external_id, unique_identifier, ...)`
- Calendar dates use Apple absolute time seconds since `2001-01-01 00:00:00 UTC`.

## Invocation Workflow

1. Determine the target week.
   - If the user does not provide a date, use today's date.
   - Use Monday-to-Friday rows from the week, but query through next Monday so weekend events can be seen in preview if needed.
2. Read events with `scripts/week_company_events_sqlite.py`.
   - Default calendar title: `회사`.
   - Deduplicate repeated synced rows by start date, end date, title, and external identifier.
   - Keep only Monday-Friday unless the user asks to include weekend events.
3. Convert event rows into date-keyed Confluence cell HTML with `scripts/build_week_report_items.py`.
4. Fetch the raw Confluence page.
5. Patch only the `일일보고` table and only the `강우성` column using `scripts/update_daily_report_cell.py`.
6. Preview the changed dates and cell HTML before saving.
7. Save with `wiki_update_page`.
8. Re-fetch and verify:
   - Each target date exists.
   - Only `강우성` cells were changed.
   - Existing table structure and other authors' columns remain intact.

## Formatting Rules

- Match date labels already present in the wiki, for example `2026.06.05 (금)`.
- Put grouped work headings as paragraphs:

```html
<p>(Amaranth H 진료)</p>
<ol><li>경과기록 개선</li></ol>
```

- If event titles start with a parenthesized group, keep that as the group:
  - `(Amaranth H 진료) 경과기록 개선` becomes group `(Amaranth H 진료)`, item `경과기록 개선`.
- If the title has no parenthesized group, write it as a normal ordered-list item.
- Keep event descriptions out of the wiki by default unless the user asks to include them.
- Preserve existing Confluence storage markup around the table.

## Safety Rules

- Do not create missing date rows automatically unless the user explicitly asks.
- Do not overwrite another author column.
- Do not update the page if the target author header is missing.
- Do not update the page if a date row is missing; show the missing date labels instead.
- If generated content is empty for a date, leave that date unchanged unless the user asks to clear it.
- Treat Confluence raw storage as fragile: use exact section/table replacement and re-fetch after saving.

## Common Commands

List local Calendar database calendars:

```bash
python3 scripts/week_company_events_sqlite.py --list-calendars
```

Read this week's `회사` events:

```bash
python3 scripts/week_company_events_sqlite.py --start 2026-06-01 --end 2026-06-08 --calendar-title "회사" --output /tmp/week-events.tsv
```

Fallback: read this week's events from a confirmed Calendar.app calendar if AppleScript is available:

```bash
osascript -l JavaScript scripts/week_events.jxa 2026-06-01 2026-06-08 "회사"
```

Build date-keyed HTML:

```bash
python3 scripts/build_week_report_items.py --events /tmp/week-events.tsv --output /tmp/week-report-items.json
```

Patch raw Confluence storage:

```bash
python3 scripts/update_daily_report_cell.py --raw /tmp/wiki-raw.html --items /tmp/week-report-items.json --author "강우성" --output /tmp/wiki-updated.html
```
