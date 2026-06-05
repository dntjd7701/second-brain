#!/usr/bin/env bash
set -euo pipefail

if [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  # shellcheck source=/dev/null
  source "${HOME}/.nvm/nvm.sh"
  nvm use v22 >/dev/null
fi

PLAYWRIGHT_CLI="${PLAYWRIGHT_CLI:-$HOME/.nvm/versions/node/v22.17.1/bin/playwright-cli}"
AMARANTH10_BASE_URL="${AMARANTH10_BASE_URL:-http://localhost:3000}"
PLAYWRIGHT_SESSION="${PLAYWRIGHT_SESSION:-mrma0010-yoyang-geubyeo-uiroe}"
WAIT_MS="${WAIT_MS:-5000}"

AMARANTH10_ID="${AMARANTH10_ID:-}"
AMARANTH10_PASSWORD="${AMARANTH10_PASSWORD:-}"

CHIEF_COMPLAINT="${CHIEF_COMPLAINT:-테스트 주호소}"
REFERRAL_OPINION="${REFERRAL_OPINION:-테스트 진료소견}"
PARTNER_NAME="${PARTNER_NAME:-진료협력 담당자}"
PARTNER_TEL="${PARTNER_TEL:-01098765432}"
RCV_YADM_NAME="${RCV_YADM_NAME:-}"

if [[ -z "${AMARANTH10_ID}" || -z "${AMARANTH10_PASSWORD}" ]]; then
  echo "AMARANTH10_ID와 AMARANTH10_PASSWORD를 설정해야 합니다." >&2
  exit 1
fi

if [[ ! -x "${PLAYWRIGHT_CLI}" ]]; then
  echo "playwright-cli 실행 파일을 찾지 못했습니다: ${PLAYWRIGHT_CLI}" >&2
  exit 1
fi

json_string() {
  node -p "JSON.stringify(process.argv[1])" -- "$1"
}

LOGIN_ID_JSON="$(json_string "${AMARANTH10_ID}")"
LOGIN_PASSWORD_JSON="$(json_string "${AMARANTH10_PASSWORD}")"
BASE_URL_JSON="$(json_string "${AMARANTH10_BASE_URL}")"
CHIEF_COMPLAINT_JSON="$(json_string "${CHIEF_COMPLAINT}")"
REFERRAL_OPINION_JSON="$(json_string "${REFERRAL_OPINION}")"
PARTNER_NAME_JSON="$(json_string "${PARTNER_NAME}")"
PARTNER_TEL_JSON="$(json_string "${PARTNER_TEL}")"
RCV_YADM_NAME_JSON="$(json_string "${RCV_YADM_NAME}")"
WAIT_MS_JSON="$(json_string "${WAIT_MS}")"

read -r -d '' PW_CODE <<EOF || true
async page => {
  const loginId = ${LOGIN_ID_JSON};
  const loginPassword = ${LOGIN_PASSWORD_JSON};
  const baseUrl = ${BASE_URL_JSON};
  const chiefComplaint = ${CHIEF_COMPLAINT_JSON};
  const referralOpinion = ${REFERRAL_OPINION_JSON};
  const partnerName = ${PARTNER_NAME_JSON};
  const partnerTel = ${PARTNER_TEL_JSON};
  const requestedHospitalName = ${RCV_YADM_NAME_JSON} || '';
  const waitMs = Number(${WAIT_MS_JSON} || '5000');

  const rowByText = (text) => page.locator('tr').filter({ hasText: text }).first();

  const fillRow = async (label, value) => {
    const row = rowByText(label);
    const field = row.locator('input, textarea').first();
    await field.waitFor({ timeout: 10000 });
    await field.fill('');
    await field.fill(value);
  };

  const ensureChecked = async (label, itemText) => {
    const row = rowByText(label);
    const firstCheckbox = row.locator('input[type="checkbox"]').first();
    if (!(await firstCheckbox.isChecked())) {
      await row.getByText(itemText, { exact: true }).click();
    }
  };

  const ensureHospitalSelected = async () => {
    const row = rowByText('의뢰받을 요양기관 명칭');
    const input = row.locator('input').first();
    const currentValue = (await input.inputValue()).trim();
    if (currentValue) {
      return currentValue;
    }

    await row.locator('button').first().click();

    const dialog = page.locator('[role="dialog"]').filter({ hasText: '요양기관 코드도움' }).first();
    await dialog.waitFor({ timeout: 10000 });

    const searchInput = dialog.locator('input').first();
    if (requestedHospitalName && await searchInput.count()) {
      await searchInput.fill(requestedHospitalName);
      const searchButton = dialog.getByRole('button', { name: /조회|검색/ }).first();
      if (await searchButton.count()) {
        await searchButton.click();
      }
      await page.waitForTimeout(1000);
    }

    const candidates = dialog.locator('tbody tr, [role="row"]').filter({ hasNotText: '요양기관코드' });
    const candidateCount = await candidates.count();
    if (!candidateCount) {
      throw new Error('요양기관 코드도움 팝업에서 선택 가능한 행을 찾지 못했습니다.');
    }

    await candidates.first().dblclick().catch(async () => {
      await candidates.first().click();
      const confirmButton = dialog.getByRole('button', { name: /선택|확인|적용/ }).first();
      if (await confirmButton.count()) {
        await confirmButton.click();
      }
    });

    await page.waitForTimeout(500);
    const selectedValue = (await input.inputValue()).trim();
    if (!selectedValue) {
      throw new Error('요양기관 선택 후에도 값이 비어 있습니다.');
    }
    return selectedValue;
  };

  page.on('dialog', async dialog => {
    await dialog.accept().catch(() => {});
  });

  await page.goto(baseUrl + '/#/MRM/MRMA0010/MRMA0010');

  if (page.url().includes('/#/login')) {
    await page.getByRole('textbox', { name: '아이디를 입력하세요' }).fill(loginId);
    await page.getByRole('button', { name: '다음' }).click();
    await page.getByRole('textbox', { name: '비밀번호를 입력하세요' }).fill(loginPassword);
    await page.getByRole('button', { name: '로그인' }).click();
  }

  await page.waitForURL('**/#/MRM/MRMA0010/MRMA0010', { timeout: 30000 });
  await page.waitForTimeout(waitMs);

  const yoyangFormReady = await page.getByText('의뢰 기본정보', { exact: true }).count();
  if (!yoyangFormReady) {
    throw new Error('요양급여의뢰서 폼이 열려 있지 않습니다. 환자 선택과 요양급여의뢰서 선택을 먼저 해주세요.');
  }

  await ensureChecked('의뢰 사유', '진단의뢰');
  await fillRow('주호소', chiefComplaint);
  await ensureHospitalSelected();
  await fillRow('진료소견', referralOpinion);
  await fillRow('(진료협력센터) 담당자 성명', partnerName);
  await fillRow('(진료협력센터) 담당자 연락처', partnerTel);

  await page.getByRole('button', { name: '전송' }).first().click();
  await page.waitForTimeout(2000);

  const successCount = await page.getByText('전송되었습니다.', { exact: true }).count();
  if (!successCount) {
    throw new Error('전송 버튼은 눌렀지만 성공 문구를 확인하지 못했습니다.');
  }

  return {
    success: true,
    hospitalName: await rowByText('의뢰받을 요양기관 명칭').locator('input').first().inputValue(),
    chiefComplaint,
    referralOpinion,
    partnerName,
    partnerTel,
  };
}
EOF

"${PLAYWRIGHT_CLI}" -s="${PLAYWRIGHT_SESSION}" open --headed "${AMARANTH10_BASE_URL}/#/MRM/MRMA0010/MRMA0010"
"${PLAYWRIGHT_CLI}" -s="${PLAYWRIGHT_SESSION}" run-code "${PW_CODE}"
