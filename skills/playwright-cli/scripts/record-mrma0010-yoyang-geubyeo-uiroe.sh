#!/usr/bin/env bash
set -euo pipefail

if [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  source "${HOME}/.nvm/nvm.sh"
  nvm use v22 >/dev/null
fi

BASE_URL="${AMARANTH10_BASE_URL:-http://localhost:3000}"
RECORD_DIR="${RECORD_DIR:-/Users/woosung/.codex/skills/playwright-cli/recordings}"
OUTPUT_FILE="${OUTPUT_FILE:-${RECORD_DIR}/mrma0010-yoyang-geubyeo-uiroe.spec.js}"
STORAGE_FILE="${STORAGE_FILE:-${RECORD_DIR}/mrma0010-auth.json}"

mkdir -p "${RECORD_DIR}"

CMD=(
  npx playwright codegen
  --target=playwright-test
  --browser=chromium
  --channel=chrome
  --ignore-https-errors
  --output "${OUTPUT_FILE}"
  --save-storage "${STORAGE_FILE}"
)

if [[ -f "${STORAGE_FILE}" ]]; then
  CMD+=(--load-storage "${STORAGE_FILE}")
fi

CMD+=("${BASE_URL}/#/MRM/MRMA0010/MRMA0010")

echo "Recorder output: ${OUTPUT_FILE}"
echo "Storage state: ${STORAGE_FILE}"
echo "브라우저에서 직접 동작한 뒤 recorder 창을 닫으면 코드가 저장됩니다."

"${CMD[@]}"
