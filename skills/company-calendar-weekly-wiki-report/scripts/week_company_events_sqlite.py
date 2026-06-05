#!/usr/bin/env python3
import argparse
import csv
import os
import sqlite3
import sys
from datetime import datetime

APPLE_EPOCH_UNIX = 978307200
DEFAULT_DB = "~/Library/Calendars/Calendar.sqlitedb"


def apple_seconds(local_datetime):
    return local_datetime.astimezone().timestamp() - APPLE_EPOCH_UNIX


def from_apple_seconds(value):
    return datetime.fromtimestamp(float(value) + APPLE_EPOCH_UNIX).astimezone()


def parse_date(value):
    return datetime.strptime(value, "%Y-%m-%d").astimezone()


def clean(value):
    return " ".join(str(value or "").replace("\t", " ").replace("\r", " ").replace("\n", " ").split())


def connect(db_path):
    expanded = os.path.expanduser(db_path)
    uri = f"file:{expanded}?mode=ro"
    return sqlite3.connect(uri, uri=True)


def list_calendars(connection):
    rows = connection.execute(
        """
        SELECT ROWID, title, color, symbolic_color_name, external_id, self_identity_email
        FROM Calendar
        ORDER BY title, ROWID
        """
    ).fetchall()
    writer = csv.writer(sys.stdout, delimiter="\t", lineterminator="\n")
    writer.writerow(["calendar_id", "title", "color", "symbolic_color_name", "external_id", "self_identity_email"])
    writer.writerows(rows)


def fetch_events(connection, start, end, calendar_title):
    query = """
        SELECT
            ci.ROWID,
            ci.summary,
            ci.description,
            ci.start_date,
            ci.end_date,
            ci.all_day,
            c.title,
            ci.external_id,
            ci.unique_identifier
        FROM CalendarItem ci
        JOIN Calendar c ON c.ROWID = ci.calendar_id
        WHERE c.title = ?
          AND ci.start_date >= ?
          AND ci.start_date < ?
        ORDER BY ci.start_date, ci.ROWID
    """
    seen = set()
    for row in connection.execute(query, (calendar_title, apple_seconds(start), apple_seconds(end))):
        (
            rowid,
            summary,
            description,
            start_seconds,
            end_seconds,
            all_day,
            title,
            external_id,
            unique_identifier,
        ) = row
        start_dt = from_apple_seconds(start_seconds)
        end_dt = from_apple_seconds(end_seconds or start_seconds)
        dedupe_key = (
            clean(summary),
            start_dt.strftime("%Y-%m-%d %H:%M"),
            end_dt.strftime("%Y-%m-%d %H:%M"),
            clean(external_id or unique_identifier or rowid),
        )
        if dedupe_key in seen:
            continue
        seen.add(dedupe_key)
        yield {
            "start_date": start_dt.strftime("%Y-%m-%d %H:%M"),
            "end_date": end_dt.strftime("%Y-%m-%d %H:%M"),
            "calendar": title,
            "summary": clean(summary),
            "description": clean(description),
            "all_day": "true" if all_day else "false",
        }


def main():
    parser = argparse.ArgumentParser(description="Export company events from the local macOS Calendar SQLite cache.")
    parser.add_argument("--db", default=DEFAULT_DB, help="Calendar.sqlitedb path")
    parser.add_argument("--list-calendars", action="store_true", help="List local calendar rows and exit")
    parser.add_argument("--start", help="Start date YYYY-MM-DD")
    parser.add_argument("--end", help="End date YYYY-MM-DD")
    parser.add_argument("--calendar-title", default="회사", help="Calendar.title filter")
    parser.add_argument("--output", help="TSV output path; stdout when omitted")
    args = parser.parse_args()

    with connect(args.db) as connection:
        if args.list_calendars:
            list_calendars(connection)
            return
        if not args.start or not args.end:
            parser.error("--start and --end are required unless --list-calendars is used")

        rows = list(fetch_events(connection, parse_date(args.start), parse_date(args.end), args.calendar_title))

    target = open(args.output, "w", newline="", encoding="utf-8") if args.output else sys.stdout
    try:
        writer = csv.DictWriter(
            target,
            fieldnames=["start_date", "end_date", "calendar", "summary", "description", "all_day"],
            delimiter="\t",
            lineterminator="\n",
        )
        writer.writeheader()
        writer.writerows(rows)
    finally:
        if args.output:
            target.close()


if __name__ == "__main__":
    main()
