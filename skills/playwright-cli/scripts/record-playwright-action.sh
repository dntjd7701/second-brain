#!/usr/bin/env bash
set -euo pipefail

if [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  source "${HOME}/.nvm/nvm.sh"
  nvm use v22 >/dev/null
fi

RECORD_DIR="${RECORD_DIR:-/Users/woosung/.codex/skills/playwright-cli/recordings}"
RECORD_URL="${RECORD_URL:-}"
RECORD_NAME="${RECORD_NAME:-}"
TIMESTAMP="$(date '+%Y%m%d-%H%M%S')"

if [[ -z "${RECORD_URL}" ]]; then
  echo "RECORD_URL을 설정해야 합니다." >&2
  exit 1
fi

slugify() {
  local input="$1"
  input="$(printf '%s' "$input" | tr '[:upper:]' '[:lower:]')"
  input="$(printf '%s' "$input" | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
  printf '%s' "$input"
}

mkdir -p "${RECORD_DIR}"

if [[ -n "${RECORD_NAME}" ]]; then
  BASENAME="$(slugify "${RECORD_NAME}")"
  if [[ -z "${BASENAME}" ]]; then
    BASENAME="recorded-action-${TIMESTAMP}"
  fi
else
  BASENAME="pending-${TIMESTAMP}"
fi

OUTPUT_FILE="${RECORD_DIR}/${BASENAME}.spec.js"
STORAGE_FILE="${RECORD_DIR}/${BASENAME}.auth.json"

CMD=(
  npx playwright codegen
  --target=playwright-test
  --browser=chromium
  --channel=chrome
  --ignore-https-errors
  --output "${OUTPUT_FILE}"
  --save-storage "${STORAGE_FILE}"
)

CMD+=("${RECORD_URL}")

echo "Recorder output: ${OUTPUT_FILE}"
echo "Storage state: ${STORAGE_FILE}"
echo "브라우저에서 직접 동작한 뒤 recorder 창을 닫으면 코드가 저장됩니다."

"${CMD[@]}"
