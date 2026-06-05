#!/bin/bash
# init-db.sh
# change-tracker SQLite DB 초기화
#
# 사용법: bash /Users/woosung/.codex/skills/change-tracker/scripts/init-db.sh

DB_PATH="/Users/woosung/.codex/change-tracking/change-tracker.db"

if ! command -v sqlite3 &> /dev/null; then
  echo "[ERROR] sqlite3가 설치되어 있지 않습니다." >&2
  exit 1
fi

mkdir -p "$(dirname "$DB_PATH")"

sqlite3 "$DB_PATH" << 'SQL'
CREATE TABLE IF NOT EXISTS commits (
  commit_hash TEXT PRIMARY KEY,
  commit_date TEXT NOT NULL,
  project TEXT NOT NULL,
  tool TEXT DEFAULT '',
  session_id TEXT DEFAULT '',
  task TEXT DEFAULT '',
  instruction TEXT DEFAULT ''
);

CREATE TABLE IF NOT EXISTS changes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  commit_hash TEXT NOT NULL,
  file TEXT NOT NULL,
  change_type TEXT NOT NULL,
  diff_type TEXT DEFAULT 'modify',
  line_start INTEGER DEFAULT 0,
  line_end INTEGER DEFAULT 0,
  lines_added INTEGER DEFAULT 0,
  lines_removed INTEGER DEFAULT 0,
  FOREIGN KEY (commit_hash) REFERENCES commits(commit_hash)
);

CREATE INDEX IF NOT EXISTS idx_changes_commit ON changes(commit_hash);
CREATE INDEX IF NOT EXISTS idx_changes_file ON changes(file);
CREATE INDEX IF NOT EXISTS idx_changes_type ON changes(change_type);
SQL

echo "✓ DB 초기화 완료: $DB_PATH"
