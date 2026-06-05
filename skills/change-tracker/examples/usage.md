# change-tracker 사용 가이드

## 개요

change-tracker는 CLI 도구(Copilot/Codex)가 코드를 수정할 때 변경 내역을 자동으로 추적하고,
git commit 시 AI 변경과 수동 변경을 분류하여 SQLite DB에 저장하고 보고서를 생성하는 스킬이다.

## 설치

### 1회 실행

```bash
bash /Users/woosung/.codex/skills/change-tracker/scripts/install-hooks.sh
```

이 명령이 다음 프로젝트에 git hook을 설치한다:
- amaranth10-medical
- amaranth10-hospital
- amaranth10-hospitalcore
- amaranth10-reception
- klago-ui-hospital-common (독립 git 저장소)
- klago-ui-hospital-micro (독립 git 저장소)
- klago-ui-medical-micro (독립 git 저장소)
- klago-ui-reception-micro (독립 git 저장소)

## 사용 시나리오

### 시나리오 1: Copilot으로 코드 수정 후 커밋

```
1. Copilot에게 지시: "환자 목록에 생년월일 검색 필터 추가해줘"
2. Copilot이 코드 수정 + change-tracking.json에 자동 기록
3. git add + git commit 실행
4. post-commit 훅이 자동으로:
   - change-tracking.json과 커밋된 diff를 대조
   - AI 변경 / 수동 변경 분류
   - SQLite DB에 저장
   - history/ 에 마크다운 보고서 생성
   - change-tracking.json 초기화
```

### 시나리오 2: AI 수정 + 수동 수정 혼합

```
1. Copilot이 PatientList.tsx 수정 → change-tracking.json에 기록됨
2. 사용자가 IDE에서 patient.css를 직접 수정 → 기록 안됨
3. git add . + git commit
4. post-commit 훅이 자동으로:
   - PatientList.tsx → AI 변경 (추적 파일에 있음)
   - patient.css → 수동 변경 (추적 파일에 없음)
   - SQLite DB에 분류 결과 저장
   - history/ 에 마크다운 보고서 생성
```

### 시나리오 3: 커밋 후 AI 변경 문서 확인

```
1. git commit 완료 후 post-commit 훅이 자동으로:
   - ~/.codex/change-tracking/history/commit-2026-04-15-abc1234.md 생성
   - change-tracking.json 초기화

2. 생성된 문서 내용:
   # AI 변경 추출 - abc1234
   | 항목 | 값 |
   |------|-----|
   | 커밋 | abc1234 |
   | 날짜 | 2026-04-15 15:30:00 |
   | 프로젝트 | amaranth10-hospital |
   | 도구 | copilot |
   | 태스크 | 환자 목록 검색 필터 개선 |
   | 지시 | 환자 목록에 생년월일 검색 필터 추가해줘 |

   ## 변경 파일
   ### src/components/PatientList.tsx (modify) L45-62
   **Before:**
   // 기존 코드
   **After:**
   // 변경된 코드
```

### 시나리오 4: 추적 데이터 없이 일반 커밋

```
1. 사용자가 직접 코드 수정 (Copilot/Codex 사용하지 않음)
2. git commit
3. 추적 파일이 비어있으므로 모든 파일이 "manual"로 분류
4. DB에 수동 변경으로 기록됨
```

### 시나리오 5: DB 조회

Copilot/Codex에게 자연어로 질문하면 sqlite3로 DB를 조회한다.

```
사용자: "최근 AI 변경 이력 보여줘"
사용자: "프로젝트별 AI 코드 기여도 통계"
사용자: "이번 달 hospital-common에서 AI가 수정한 파일 목록"
```

직접 조회도 가능:
```bash
# 최근 변경 이력
sqlite3 /Users/woosung/.codex/change-tracking/change-tracker.db \
  "SELECT c.commit_date, c.project, ch.file, ch.change_type FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash ORDER BY c.commit_date DESC LIMIT 20;"

# AI 기여도 통계
sqlite3 /Users/woosung/.codex/change-tracking/change-tracker.db \
  "SELECT c.project, ch.change_type, COUNT(*) as cnt, SUM(ch.lines_added) as added FROM commits c JOIN changes ch ON c.commit_hash = ch.commit_hash GROUP BY c.project, ch.change_type;"
```

## git-commit-instructions.md와의 관계

기존 `.github/git-commit-instructions.md`는 수정하지 않는다.
git hook이 독립적으로 동작하므로 기존 커밋 메시지 포맷에 영향을 주지 않는다.

기존 메시지 형식은 그대로 유지:
```
📌[강우성][feat] [PatientList.tsx] : 환자 목록 검색 기능 개선
```

## Front 프로젝트 구조 참고

klago-ui-micro는 모노레포 구조이지만 하위 프로젝트가 각각 독립된 git 저장소를 가진다.
따라서 klago-ui-micro 상위가 아닌 개별 저장소(hospital-common, hospital-micro, medical-micro, reception-micro)에 직접 hook이 설치되어 있다.

## 추적 파일 수동 초기화

필요 시 수동으로 초기화할 수 있다:

```bash
cat > /Users/woosung/.codex/change-tracking/change-tracking.json << 'EOF'
{
  "session_id": "",
  "started_at": "",
  "tool": "",
  "task": "",
  "instruction": "",
  "changes": []
}
EOF
```

## 문제 해결

### hook이 동작하지 않을 때
```bash
# hook 심볼릭 링크 확인
ls -la .git/hooks/prepare-commit-msg
ls -la .git/hooks/post-commit

# 실행 권한 확인
chmod +x .git/hooks/prepare-commit-msg
chmod +x .git/hooks/post-commit
```

### jq가 설치되어 있지 않을 때
```bash
brew install jq
```
hook은 jq가 없으면 분류를 건너뛰고 일반 커밋으로 진행한다.
