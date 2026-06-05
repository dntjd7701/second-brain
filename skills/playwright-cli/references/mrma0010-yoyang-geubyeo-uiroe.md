# MRMA0010 요양급여의뢰서

MRMA0010 화면에서 `요양급여의뢰서` 전송을 자동화할 때 참고하는 프로젝트 전용 문서다.

## 적용 조건
- URL: `http://localhost:3000/#/MRM/MRMA0010/MRMA0010`
- 사용자가 `요양급여의뢰서`, `MRMA0010 전송`, `진료의뢰회송등록 자동화`처럼 요청할 때
- `playwright-cli` 보이는 창(`--headed`)을 기본으로 사용한다.

## 기본 원칙
- 아이디/비밀번호는 파일에 저장하지 않는다.
- 실행 시 `AMARANTH10_ID`, `AMARANTH10_PASSWORD` 환경변수로 전달한다.
- 현재 화면에 `요양급여의뢰서` 폼이 이미 열려 있지 않으면 실패로 처리한다.
- 현재 자동화는 `환자 선택 + 요양급여의뢰서 문서 선택` 이후부터 안정적이다.

## 권장 실행 스크립트
- `scripts/run-mrma0010-yoyang-geubyeo-uiroe.sh`
- 녹화용: `scripts/record-mrma0010-yoyang-geubyeo-uiroe.sh`

필수 환경변수:
- `AMARANTH10_ID`
- `AMARANTH10_PASSWORD`

선택 환경변수:
- `AMARANTH10_BASE_URL` 기본값 `http://localhost:3000`
- `PLAYWRIGHT_SESSION` 기본값 `mrma0010-yoyang-geubyeo-uiroe`
- `CHIEF_COMPLAINT` 기본값 `테스트 주호소`
- `REFERRAL_OPINION` 기본값 `테스트 진료소견`
- `PARTNER_NAME` 기본값 `진료협력 담당자`
- `PARTNER_TEL` 기본값 `01098765432`
- `RCV_YADM_NAME` 요양기관 코드도움 팝업에서 우선 검색할 기관명
- `WAIT_MS` 기본값 `5000`

## 자동화 순서
1. MRMA0010 URL을 `--headed` 브라우저로 연다.
2. 로그인 화면이면 제공된 자격증명으로 로그인한다.
3. 현재 화면에 `의뢰 기본정보`와 `전송` 버튼이 있는지 확인한다.
4. `의뢰 사유`에서 `진단의뢰`를 체크한다.
5. `주호소`, `진료소견`, `(진료협력센터) 담당자 성명`, `(진료협력센터) 담당자 연락처`를 채운다.
6. `의뢰받을 요양기관 명칭`이 비어 있으면 코드도움 팝업을 열고 첫 결과를 선택한다.
7. `전송` 버튼을 누른다.
8. `전송되었습니다.` 문구를 확인한다.

## 현재 한계
- `요양급여의뢰서` 텍스트가 DOM에 안정적으로 노출되지 않아, 문서 선택 단계까지 완전 자동화하지 않았다.
- `playwright-cli` 일부 ref 명령은 세션 리셋이나 `EPERM`이 있어, MRMA0010에서는 `run-code` 기반 DOM 탐색을 우선 사용한다.
- 요양기관 코드도움 팝업 구조가 바뀌면 스크립트의 선택 로직을 수정해야 한다.

## Recorder 사용
- 사용자가 실제 클릭/입력 순서를 그대로 코드로 남기고 싶으면 `scripts/record-mrma0010-yoyang-geubyeo-uiroe.sh`를 실행한다.
- 결과 파일 기본 경로:
  - `recordings/mrma0010-yoyang-geubyeo-uiroe.spec.js`
  - `recordings/mrma0010-auth.json`
- 이미 저장된 storage state가 있으면 자동으로 불러오고, 종료 시 최신 상태로 다시 저장한다.
