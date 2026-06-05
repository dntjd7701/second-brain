---
name: merge-menu-branch-to-develop
description: "Use when: 개발서버 배포 전에 develop 브랜치 반영이 필요할 때, 개발 브랜치 병합을 할 때, 현재 브랜치를 checkout 변경하지 않고 git worktree로 안전하게 병합 자동화가 필요할 때"
---

# Merge Menu Branch to Develop (No Checkout Switch)

## 사용 시점
- 개발서버 배포 전에 메뉴/기능 브랜치를 `develop`에 반영해야 할 때
- 개발 브랜치 병합 작업을 현재 브랜치 유지 상태에서 처리해야 할 때

## 목적
- 현재 작업 브랜치를 유지한 채(`checkout` 전환 없이) 메뉴 브랜치를 `develop`에 병합한다.
- 로컬 워킹트리 빌드 재기동/캐시 리셋을 피한다.

## ⚠️ 충돌 정책 (최우선)
- 충돌이 발생하면 **즉시 중지**한다. (자동 해결 금지)
- 충돌 시 허용 동작은 `merge --abort` + 임시 worktree 정리만 허용한다.
- 충돌 상태에서 `develop`으로의 push/반영은 **절대 금지**한다.
- 충돌 발생 종료 코드는 `exit 2`로 고정한다.

## 입력
- `sourceBranch` (선택): 미지정 시 현재 체크아웃 브랜치를 사용
- `targetBranch` (선택): 기본값 `develop`
- `remote` (선택): 기본값 `origin`

## 실행 커맨드 (한 명령)
- 재사용용 원라인:
   - `SOURCE=$(git branch --show-current); TARGET=develop; REMOTE=origin; CURRENT="$SOURCE"; [[ -n "$(git status --porcelain)" ]] && { echo "[BLOCK] working tree is dirty. commit/stash first"; exit 1; }; [[ "$SOURCE" == "$TARGET" ]] && { echo "[BLOCK] source and target are same: $SOURCE"; exit 1; }; TEMP_DIR=$(mktemp -d "${TMPDIR:-/tmp}/merge-${TARGET}-${SOURCE}-XXXX"); cleanup(){ git -C "$TEMP_DIR" merge --abort >/dev/null 2>&1 || true; git worktree remove "$TEMP_DIR" --force >/dev/null 2>&1 || true; }; trap cleanup EXIT; echo "[START] source=$SOURCE target=$TARGET current=$CURRENT temp=$TEMP_DIR"; git fetch "$REMOTE" "$SOURCE" "$TARGET" && git worktree add --detach "$TEMP_DIR" "$REMOTE/$TARGET" && git -C "$TEMP_DIR" merge --no-ff --no-edit "$REMOTE/$SOURCE" && git -C "$TEMP_DIR" push "$REMOTE" "HEAD:$TARGET" && echo "[DONE] merge success; current remains $CURRENT" || { echo "[FAIL] merge/push failed"; exit 2; }`
   - 위 원라인은 충돌 시 자동 해소를 시도하지 않고, 즉시 실패(`exit 2`) 후 정리만 수행한다.

## 실행 절차
1. 저장소 루트와 현재 브랜치를 확인한다.
2. 현재 워킹 트리에 미커밋 변경이 있으면 중단하고 사용자에게 정리(커밋/스태시) 요청한다.
3. `git fetch <remote> <sourceBranch> <targetBranch>` 실행.
4. 임시 worktree 디렉터리를 만들고, `targetBranch`를 detached HEAD로 붙인다.
   - 예: `git worktree add --detach <tempDir> <remote>/<targetBranch>`
5. 임시 worktree에서 병합을 수행한다.
   - `git merge --no-ff --no-edit <remote>/<sourceBranch>`
6. 성공 시 임시 worktree에서 push 한다.
   - `git push <remote> HEAD:<targetBranch>`
7. 성공 시 임시 worktree를 제거한다.
8. 충돌 발생 시 즉시 충돌 메시지를 출력하고 아래 순서로 롤백한다.
   - `git merge --abort`
   - 임시 worktree 제거
   - 실패 원인과 재시도 안내 출력
9. 기타 오류 발생 시에도 임시 worktree를 제거하고 실패 안내를 출력한다.

## 충돌 시 안내
- 충돌 즉시 병합을 중단하고 롤백한다.
- 필수 동작:
  - "충돌 발생" 메시지 출력
  - `git merge --abort` 실행
  - 임시 worktree 제거
- 사용자는 소스/타겟 브랜치 내용을 정리한 뒤 다시 병합을 실행한다.
- 절대 금지:
   - 충돌 파일 수동 수정 후 강제 병합/푸시
   - 임시 resolve 브랜치 생성 후 develop 직접 반영
   - 사용자 명시 승인 없이 `--strategy-option theirs/ours` 사용
   - 충돌 발생 상태에서 병합 계속 진행 (`continue`) 처리

## 출력 형식
- 시작: source/target/current branch 요약
- 진행: fetch/worktree/merge/push 단계별 성공 여부
- 종료:
  - 성공: "현재 브랜치 유지 + develop 병합 완료"
   - 실패: 실패 단계, 원인, 롤백 완료 여부, 재시도 방법

## 안전 규칙
- 사용자의 현재 브랜치에서 `git checkout`/`git switch`를 실행하지 않는다.
- 로컬 임시 병합 브랜치를 생성하지 않는다.(`--detach` 방식 사용)
- `--force` push 금지.
- 병합 커밋은 `--no-ff` 유지.
- 타겟 브랜치는 기본 `develop`으로 고정, 사용자가 명시할 때만 변경한다.
