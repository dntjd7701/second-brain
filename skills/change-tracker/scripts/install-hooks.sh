#!/bin/bash
# install-hooks.sh
# 대상 프로젝트에 change-tracker git hook을 심볼릭 링크로 설치
#
# 사용법: bash /Users/woosung/.codex/skills/change-tracker/scripts/install-hooks.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOOKS_DIR="$SCRIPT_DIR"

# 대상 프로젝트 목록
# Boot 프로젝트
# Front 프로젝트 (klago-ui-micro 하위 독립 저장소)
PROJECTS=(
  "/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-medical"
  "/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-hospital"
  "/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-hospitalcore"
  "/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-reception"
  "/Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro/common/klago-ui-hospital-common"
  "/Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro/packages/klago-ui-hospital-micro"
  "/Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro/packages/klago-ui-medical-micro"
  "/Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro/packages/klago-ui-reception-micro"
)

# 설치할 hook 목록
HOOK_NAMES=("prepare-commit-msg" "post-commit")

echo "=== change-tracker hook 설치 ==="
echo ""

for project in "${PROJECTS[@]}"; do
  project_name=$(basename "$project")
  git_hooks_dir="$project/.git/hooks"

  if [ ! -d "$project/.git" ]; then
    echo "[SKIP] $project_name - .git 디렉터리 없음"
    continue
  fi

  # hooks 디렉터리 생성 (없을 수 있음)
  mkdir -p "$git_hooks_dir"

  for hook_name in "${HOOK_NAMES[@]}"; do
    target="$git_hooks_dir/$hook_name"
    source="$HOOKS_DIR/$hook_name"

    if [ ! -f "$source" ]; then
      echo "[ERROR] $hook_name 원본 파일이 없습니다: $source"
      continue
    fi

    # 기존 hook이 있으면 백업
    if [ -f "$target" ] && [ ! -L "$target" ]; then
      backup="$target.backup.$(date +%Y%m%d%H%M%S)"
      cp "$target" "$backup"
      echo "[BACKUP] $project_name/$hook_name -> $(basename $backup)"
    fi

    # 기존 심볼릭 링크가 같은 대상을 가리키면 건너뜀
    if [ -L "$target" ]; then
      current_link=$(readlink "$target")
      if [ "$current_link" = "$source" ]; then
        echo "[OK] $project_name/$hook_name - 이미 설치됨"
        continue
      fi
      rm "$target"
    fi

    # 심볼릭 링크 생성
    ln -sf "$source" "$target"
    chmod +x "$target"
    echo "[INSTALL] $project_name/$hook_name -> $source"
  done

  echo ""
done

# 원본 스크립트에 실행 권한 부여
for hook_name in "${HOOK_NAMES[@]}"; do
  chmod +x "$HOOKS_DIR/$hook_name"
done

echo "=== 설치 완료 ==="
echo ""
echo "확인: 각 프로젝트에서 git commit 시 자동으로 change-tracker hook이 실행됩니다."
