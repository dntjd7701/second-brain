#!/usr/bin/env bash
set -euo pipefail

if [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  source "${HOME}/.nvm/nvm.sh"
  nvm use v22 >/dev/null
fi

PLAYWRIGHT_CLI="${PLAYWRIGHT_CLI:-$HOME/.nvm/versions/node/v22.17.1/bin/playwright-cli}"
SPEC_FILE="${1:-}"
PLAYWRIGHT_SESSION="${PLAYWRIGHT_SESSION:-recorded-action}"
MAX_ATTEMPTS="${MAX_ATTEMPTS:-3}"
RETRY_WAIT_SECONDS="${RETRY_WAIT_SECONDS:-2}"
REPLAY_URL="${REPLAY_URL:-}"
AMARANTH10_ID="${AMARANTH10_ID:-}"
AMARANTH10_PASSWORD="${AMARANTH10_PASSWORD:-}"

if [[ -z "${SPEC_FILE}" ]]; then
  echo "사용법: run-recorded-action.sh <spec-file>" >&2
  exit 1
fi

if [[ ! -f "${SPEC_FILE}" ]]; then
  echo "spec 파일을 찾지 못했습니다: ${SPEC_FILE}" >&2
  exit 1
fi

if [[ ! -x "${PLAYWRIGHT_CLI}" ]]; then
  echo "playwright-cli 실행 파일을 찾지 못했습니다: ${PLAYWRIGHT_CLI}" >&2
  exit 1
fi

AUTH_FILE="${SPEC_FILE%.spec.js}.auth.json"
STATE_FILE="${SPEC_FILE%.spec.js}.resume.json"
STATEMENTS_FILE="$(mktemp)"

cleanup() {
  rm -f "${STATEMENTS_FILE}"
}
trap cleanup EXIT

node - "${SPEC_FILE}" "${STATEMENTS_FILE}" <<'NODE'
const fs = require('fs');
const specFile = process.argv[2];
const outputFile = process.argv[3];
const source = fs.readFileSync(specFile, 'utf8');
const match = source.match(/test\s*\([^]*?async\s*\(\{\s*page\s*\}\)\s*=>\s*\{([\s\S]*)\}\s*\);\s*$/);
if (!match) {
  console.error('녹화 spec에서 테스트 본문을 추출하지 못했습니다.');
  process.exit(1);
}

const body = match[1].trim();
const statements = [];
let current = '';
let paren = 0;
let brace = 0;
let bracket = 0;
let inSingle = false;
let inDouble = false;
let inTemplate = false;
let escape = false;

for (let i = 0; i < body.length; i += 1) {
  const ch = body[i];
  const next = body[i + 1];
  current += ch;

  if (escape) {
    escape = false;
    continue;
  }

  if (ch === '\\') {
    escape = true;
    continue;
  }

  if (inSingle) {
    if (ch === '\'') inSingle = false;
    continue;
  }

  if (inDouble) {
    if (ch === '"') inDouble = false;
    continue;
  }

  if (inTemplate) {
    if (ch === '`') {
      inTemplate = false;
      continue;
    }
    continue;
  }

  if (ch === '\'') {
    inSingle = true;
    continue;
  }

  if (ch === '"') {
    inDouble = true;
    continue;
  }

  if (ch === '`') {
    inTemplate = true;
    continue;
  }

  if (ch === '/' && next === '/') {
    while (i + 1 < body.length && body[i + 1] !== '\n') {
      i += 1;
      current += body[i];
    }
    continue;
  }

  if (ch === '/' && next === '*') {
    while (i + 1 < body.length) {
      i += 1;
      current += body[i];
      if (body[i - 1] === '*' && body[i] === '/') break;
    }
    continue;
  }

  if (ch === '(') paren += 1;
  else if (ch === ')') paren -= 1;
  else if (ch === '{') brace += 1;
  else if (ch === '}') brace -= 1;
  else if (ch === '[') bracket += 1;
  else if (ch === ']') bracket -= 1;

  if (ch === ';' && paren === 0 && brace === 0 && bracket === 0) {
    const statement = current.trim();
    if (statement) statements.push(statement);
    current = '';
  }
}

const tail = current.trim();
if (tail) statements.push(tail);

fs.writeFileSync(outputFile, statements.map(s => Buffer.from(s).toString('base64')).join('\n'));
NODE

ensure_session_open() {
  if "${PLAYWRIGHT_CLI}" list 2>/dev/null | grep -q -- "- ${PLAYWRIGHT_SESSION}:"; then
    return 0
  fi

  "${PLAYWRIGHT_CLI}" -s="${PLAYWRIGHT_SESSION}" open --headed about:blank

  if [[ -f "${AUTH_FILE}" ]]; then
    "${PLAYWRIGHT_CLI}" -s="${PLAYWRIGHT_SESSION}" state-load "${AUTH_FILE}"
  fi
}

write_state() {
  local next_index="$1"
  cat > "${STATE_FILE}" <<EOF
{"next_index":${next_index},"session":"${PLAYWRIGHT_SESSION}","spec_file":"${SPEC_FILE}"}
EOF
}

read_state_index() {
  if [[ ! -f "${STATE_FILE}" ]]; then
    printf '0'
    return 0
  fi

  node -e "const fs=require('fs'); try { const s=JSON.parse(fs.readFileSync(process.argv[1], 'utf8')); process.stdout.write(String(s.next_index ?? 0)); } catch { process.stdout.write('0'); }" "${STATE_FILE}"
}

json_stringify() {
  node -e "process.stdout.write(JSON.stringify(process.argv[1]))" "${1:-}"
}

is_login_goto_statement() {
  local statement="$1"
  [[ "${statement}" == *"page.goto("* && "${statement}" == *"#/login"* ]]
}

is_login_form_statement() {
  local statement="$1"
  [[ "${statement}" == *"아이디를"* || "${statement}" == *"비밀번호를 입력하세요"* || "${statement}" == *"name: '로그인'"* || "${statement}" == *'name: "로그인"'* ]]
}

prepare_replay_page() {
  local replay_url_json
  local id_json
  local password_json
  local code

  replay_url_json="$(json_stringify "${REPLAY_URL}")"
  id_json="$(json_stringify "${AMARANTH10_ID}")"
  password_json="$(json_stringify "${AMARANTH10_PASSWORD}")"

  code="$(cat <<EOF
async page => {
  const replayUrl = ${replay_url_json};
  const loginId = ${id_json};
  const loginPassword = ${password_json};
  const isLoginPage = /#\\/login/.test(page.url());

  if (isLoginPage && loginId && loginPassword) {
    const idInput = page.locator('input').nth(0);
    const passwordInput = page.locator('input').nth(1);
    await idInput.waitFor({ state: 'visible', timeout: 5000 });
    await idInput.fill(loginId);
    await passwordInput.fill(loginPassword);
    await page.getByRole('button', { name: /로그인/ }).click();
    await page.waitForTimeout(2000);
  }

  if (replayUrl) {
    await page.goto(replayUrl);
    await page.waitForTimeout(2000);
  }
}
EOF
)"

  run_playwright_code "${code}"
}

run_playwright_code() {
  local code="$1"
  local output
  local status

  set +e
  output="$("${PLAYWRIGHT_CLI}" -s="${PLAYWRIGHT_SESSION}" run-code "${code}" 2>&1)"
  status=$?
  set -e

  if [[ -n "${output}" ]]; then
    printf '%s\n' "${output}"
  fi

  if (( status != 0 )); then
    return "${status}"
  fi

  if grep -q '^### Error' <<< "${output}"; then
    return 1
  fi

  return 0
}

ensure_session_open

attempt=1
while (( attempt <= MAX_ATTEMPTS )); do
  current_index="$(read_state_index)"
  failed=0
  prepared_replay_page=0

  statements=()
  while IFS= read -r line || [[ -n "${line}" ]]; do
    statements+=("${line}")
  done < "${STATEMENTS_FILE}"
  total_count="${#statements[@]}"

  if (( current_index >= total_count )); then
    rm -f "${STATE_FILE}"
    echo "재생 완료"
    exit 0
  fi

  echo "재생 시도 ${attempt}/${MAX_ATTEMPTS} - ${current_index}번 단계부터 재개"

  for (( idx=current_index; idx<total_count; idx++ )); do
    statement="$(node -e "process.stdout.write(Buffer.from(process.argv[1], 'base64').toString())" "${statements[$idx]}")"

    if [[ -n "${REPLAY_URL}" ]] && (( prepared_replay_page == 1 )) && is_login_form_statement "${statement}"; then
      write_state "$((idx + 1))"
      continue
    fi

    code="async page => { ${statement} }"

    if run_playwright_code "${code}"; then
      write_state "$((idx + 1))"

      if [[ -n "${REPLAY_URL}" ]] && (( prepared_replay_page == 0 )) && is_login_goto_statement "${statement}"; then
        if prepare_replay_page; then
          prepared_replay_page=1
        else
          failed=1
          echo "로그인 이후 URL 이동에 실패했습니다."
          break
        fi
      fi
    else
      failed=1
      echo "실패 단계: ${idx}"
      break
    fi
  done

  if (( failed == 0 )); then
    rm -f "${STATE_FILE}"
    echo "재생 완료"
    exit 0
  fi

  echo "${RETRY_WAIT_SECONDS}초 대기 후 재시도"
  sleep "${RETRY_WAIT_SECONDS}"
  attempt="$((attempt + 1))"
done

echo "최대 ${MAX_ATTEMPTS}회 재시도 후에도 재생이 완료되지 않았습니다." >&2
exit 1
