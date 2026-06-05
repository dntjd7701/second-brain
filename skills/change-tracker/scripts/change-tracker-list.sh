#!/bin/bash
# change-tracker DB 조회 스크립트
# 사용법: bash change-tracker-list.sh [명령] [옵션]

DB="/Users/woosung/.codex/change-tracking/change-tracker.db"

if [ ! -f "$DB" ]; then
  echo "DB 파일이 없습니다: $DB"
  echo "init-db.sh를 먼저 실행하세요."
  exit 1
fi

usage() {
  echo "사용법: bash $0 [명령]"
  echo ""
  echo "명령:"
  echo "  recent [N]       최근 변경 이력 (기본 20건)"
  echo "  stats            프로젝트별 AI/수동 통계"
  echo "  commits [N]      최근 커밋 목록 (기본 10건)"
  echo "  file [패턴]      특정 파일의 변경 이력 (LIKE 검색)"
  echo "  project [이름]   특정 프로젝트 변경 이력"
  echo "  today            오늘 변경 이력"
  echo "  ai               AI 변경만 조회"
  echo "  manual           수동 변경만 조회"
  echo ""
  echo "예시:"
  echo "  bash $0 recent"
  echo "  bash $0 recent 50"
  echo "  bash $0 file PatientList"
  echo "  bash $0 project hospital-common"
  echo "  bash $0 stats"
}

cmd_recent() {
  local limit=${1:-20}
  echo "=== 최근 변경 이력 (${limit}건) ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.commit_date as 날짜, c.project as 프로젝트, ch.file as 파일, ch.change_type as 분류, ch.lines_added as 추가, ch.lines_removed as 삭제
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     ORDER BY c.commit_date DESC LIMIT $limit;"
}

cmd_stats() {
  echo "=== 프로젝트별 AI/수동 통계 ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.project as 프로젝트, ch.change_type as 분류, COUNT(*) as 파일수, SUM(ch.lines_added) as 추가, SUM(ch.lines_removed) as 삭제
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     GROUP BY c.project, ch.change_type
     ORDER BY c.project, ch.change_type;"
}

cmd_commits() {
  local limit=${1:-10}
  echo "=== 최근 커밋 목록 (${limit}건) ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT substr(commit_hash, 1, 8) as 해시, commit_date as 날짜, project as 프로젝트, tool as 도구, task as 태스크
     FROM commits ORDER BY commit_date DESC LIMIT $limit;"
}

cmd_file() {
  local pattern="$1"
  if [ -z "$pattern" ]; then
    echo "파일 패턴을 지정하세요. 예: bash $0 file PatientList"
    exit 1
  fi
  echo "=== 파일 이력: *${pattern}* ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.commit_date as 날짜, c.project as 프로젝트, ch.file as 파일, ch.change_type as 분류, ch.line_start as 시작, ch.line_end as 끝
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     WHERE ch.file LIKE '%${pattern}%'
     ORDER BY c.commit_date DESC;"
}

cmd_project() {
  local project="$1"
  if [ -z "$project" ]; then
    echo "프로젝트명을 지정하세요. 예: bash $0 project hospital-common"
    exit 1
  fi
  echo "=== 프로젝트 이력: *${project}* ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.commit_date as 날짜, substr(c.commit_hash, 1, 8) as 해시, ch.file as 파일, ch.change_type as 분류, ch.lines_added as 추가, ch.lines_removed as 삭제
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     WHERE c.project LIKE '%${project}%'
     ORDER BY c.commit_date DESC;"
}

cmd_today() {
  local today=$(date +%Y-%m-%d)
  echo "=== 오늘(${today}) 변경 이력 ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.commit_date as 날짜, c.project as 프로젝트, ch.file as 파일, ch.change_type as 분류, ch.lines_added as 추가, ch.lines_removed as 삭제
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     WHERE c.commit_date LIKE '${today}%'
     ORDER BY c.commit_date DESC;"
}

cmd_ai() {
  echo "=== AI 변경 이력 ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.commit_date as 날짜, c.project as 프로젝트, ch.file as 파일, ch.lines_added as 추가, ch.lines_removed as 삭제, c.task as 태스크
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     WHERE ch.change_type = 'ai'
     ORDER BY c.commit_date DESC;"
}

cmd_manual() {
  echo "=== 수동 변경 이력 ==="
  echo ""
  sqlite3 -header -column "$DB" \
    "SELECT c.commit_date as 날짜, c.project as 프로젝트, ch.file as 파일, ch.lines_added as 추가, ch.lines_removed as 삭제
     FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash
     WHERE ch.change_type = 'manual'
     ORDER BY c.commit_date DESC;"
}

case "${1:-help}" in
  recent)  cmd_recent "$2" ;;
  stats)   cmd_stats ;;
  commits) cmd_commits "$2" ;;
  file)    cmd_file "$2" ;;
  project) cmd_project "$2" ;;
  today)   cmd_today ;;
  ai)      cmd_ai ;;
  manual)  cmd_manual ;;
  help|*)  usage ;;
esac
