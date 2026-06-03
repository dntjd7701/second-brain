# Voice to EMR 경과기록지 구현 절차

## 목표

이 문서는 Voice to EMR 경과기록지 1차 PoC를 어떤 순서로 구현할지 정리한다. 목표는 OpenAI나 Azure 같은 유료 AI 연동이 아니다. 먼저 경과기록지 화면 안에서 음성 기반 초안 입력 흐름이 자연스럽게 동작하는지 검증한다.

1차 구현은 품질 검증보다 설득/시연에 가깝다. 따라서 SOAP 자동 분류 엔진은 mock/rule 기반이어도 되지만, 사용자가 보는 흐름은 실제 기능처럼 부드러워야 한다. 녹음 중 상태, 변환 중 로딩, 결과 적용, 경과기록 draft 등록까지 하나의 자연스러운 과정으로 보여야 한다.

연결되는 의사결정 배경은 [[Voice to EMR 경과기록지 1차 PoC 의사결정]]에 정리한다. 기존 경과기록지 조회/신규작성 기준은 [[경과기록지_조회와_신규작성_분리_기준]]을 따른다.

## 1차 프로세스

1차 프로세스는 다음으로 고정한다.

```text
녹음 버튼
-> Web Speech API 전사
-> SOAP mock/rule 정리
-> 경과기록 draft 삽입
-> 사용자 검토/수정
-> 기존 저장 버튼으로 저장
```

중요한 점은 저장 주체다. Voice to EMR은 경과기록 내용을 확정 저장하지 않는다. 초안을 draft에 입력할 뿐이다. 사용자가 내용을 확인하고 기존 저장 버튼을 눌러야 실제 경과기록 저장 프로세스가 수행된다.

## 화면 흐름

경과기록지 사이드바 안에 `Voice to EMR` 진입점을 둔다. 버튼 위치는 경과기록 컴포넌트의 `기록지 추가`가 있는 영역을 기준으로 한다. 사용자가 수동으로 기록지를 추가하는 행동과 음성으로 초안을 생성하는 행동을 같은 작성 맥락으로 이해하게 만들기 위해서다.

권장 UX는 다이얼로그 방식이다.

```text
Voice to EMR 버튼 클릭
-> 녹음/전사 다이얼로그 열림
-> 마이크 권한 요청
-> 녹음 시작
-> 전사 텍스트 누적 표시
-> 녹음 종료
-> SOAP 초안 생성
-> 미리보기
-> 적용
-> 경과기록 draft에 삽입
```

## UI 상태 전환

1차 PoC의 설득력은 상태 전환에서 나온다. 버튼을 눌렀는데 텍스트가 갑자기 생기는 방식이면 기능이 가벼워 보인다. 사용자는 녹음, 처리, 적용 과정을 자연스럽게 따라가야 한다.

권장 상태는 다음과 같다.

```text
idle
-> recording
-> transcribing
-> normalizing
-> applying
-> completed
```

상태별 UI 기준은 다음과 같다.

- `idle`: `기록지 추가` 영역 근처에 녹음기 버튼을 표시한다.
- `recording`: 버튼을 활성 상태로 바꾸고, "녹음 중" 문구와 진행 시간을 보여준다.
- `transcribing`: 녹음 종료 후 "대화 내용을 텍스트로 변환 중" 로딩을 보여준다.
- `normalizing`: "SOAP 기준으로 정리 중" 로딩을 보여준다.
- `applying`: "경과기록지에 입력 중" 로딩을 보여준다.
- `completed`: draft에 반영된 뒤 완료 메시지를 보여주고 사용자가 바로 수정할 수 있게 한다.

가능하면 `recording` 상태는 색상과 아이콘 변화가 있어야 한다. 시연에서는 녹음 중임이 한눈에 보여야 하며, 녹음 중 버튼을 다시 누르면 종료된다는 동작도 명확해야 한다.

다이얼로그에는 최소한 다음 상태가 필요하다.

- 대기
- 녹음 중
- 전사 완료
- SOAP 변환 완료
- 적용 완료
- 오류

오류는 화면에서 숨기지 않는다. 마이크 권한 거부, 브라우저 미지원, 전사 실패, 빈 전사 결과는 사용자에게 명확히 알려야 한다.

## FE 구성

1차에서는 FE 중심으로 구현한다.

```text
VoiceEmrDialog
WebSpeechSttProvider
MockSoapNormalizer
ProgressNote.applyVoiceEmrNote(noteHtml)
```

역할은 다음처럼 나눈다.

- `VoiceEmrDialog`: 녹음/전사 UI와 미리보기 담당
- `WebSpeechSttProvider`: Web Speech API 래핑
- `MockSoapNormalizer`: 전사 텍스트를 SOAP 구조로 변환
- `applyVoiceEmrNote`: 생성된 noteHtml을 현재 경과기록 draft에 삽입

`WebSpeechSttProvider`는 브라우저 API 차이를 감싼다.

```text
window.SpeechRecognition
window.webkitSpeechRecognition
```

둘 다 없으면 미지원 메시지를 보여주고, 수동 전사 입력 textarea로 fallback할 수 있게 한다.

## SOAP mock/rule 정리

1차 SOAP 변환은 정확한 의료 판단이 아니라 흐름 검증용이다. 따라서 복잡한 판단을 하지 않는다.

기본 규칙은 다음으로 둔다.

```text
S: 전사 텍스트 전체 또는 환자 호소 중심 문장
O: 객관 소견이 명시된 문장만 추출, 없으면 빈 값
A: 진단/의심/평가 표현이 있으면 추출, 없으면 빈 값
P: 검사/처방/추적/계획 표현이 있으면 추출, 없으면 빈 값
```

초기 구현은 더 단순해도 된다.

```text
S: 전사 텍스트 전체
O:
A:
P:
```

이 방식의 목적은 SOAP 품질 검증이 아니라 경과기록지 입력 흐름 검증이다. 실제 SOAP 품질은 `LlmSoapNormalizer`를 붙이는 단계에서 검증한다.

## 경과기록 draft 삽입

생성 결과는 다음 두 형태를 가진다.

```json
{
  "transcript": "전사 텍스트",
  "soap": {
    "subjective": "",
    "objective": "",
    "assessment": "",
    "plan": ""
  },
  "noteHtml": "<p><strong>S</strong> : ...</p>"
}
```

화면에 실제 삽입하는 값은 `noteHtml`이다. 원문 전사와 SOAP JSON은 미리보기와 디버깅용이다.

`noteHtml`은 단순 태그만 사용한다.

```html
<p><strong>S</strong> : ...</p>
<p><strong>O</strong> : ...</p>
<p><strong>A</strong> : ...</p>
<p><strong>P</strong> : ...</p>
```

1차 구현은 기존 draft를 덮어쓰지 않고 새 경과기록 draft sheet를 추가한다. 시연에서는 사용자가 기존 작성 내용을 잃는 장면이 가장 위험하므로, 먼저 "음성으로 생성된 초안이 별도 sheet로 생성된다"는 흐름을 보여준다.

현재 draft의 SOAP 영역 교체나 커서 위치 삽입은 나중에 검토한다.

## 저장 흐름

저장은 변경하지 않는다.

Voice to EMR 적용 후 경과기록 draft가 dirty 상태가 되면, 사용자는 기존 저장 버튼을 누른다. 그러면 기존 경과기록 저장 프로세스가 수행된다.

```text
draft HTML
-> RecordSheetService.insert()
-> dirty data 생성
-> /medical/recordSheet/0ho01001
-> 기존 경과기록 저장/문서 생성/전자인증 흐름
```

이 구조를 유지해야 하는 이유는 책임 경계 때문이다. Voice to EMR은 작성 보조이고, 경과기록 저장의 업무 규칙은 기존 경과기록 서비스가 담당한다.

## Provider 교체 지점

1차부터 provider 경계를 이름으로 남긴다. 처음 구현은 mock이어도 나중에 교체할 수 있어야 한다.

```text
SttProvider
  WebSpeechSttProvider
  OpenAiSttProvider
  AzureSttProvider
  InternalSttProvider

SoapNormalizer
  MockSoapNormalizer
  LlmSoapNormalizer
```

1차에서는 `WebSpeechSttProvider`와 `MockSoapNormalizer`만 구현한다.

2차 품질 검증에서 STT 품질이 문제로 확인되면 `OpenAiSttProvider`, `AzureSttProvider`, `InternalSttProvider` 중 하나를 붙인다.

SOAP 정리 품질이 문제로 확인되면 `LlmSoapNormalizer`를 붙인다. 이때도 LLM은 HTML을 직접 만들지 않고 SOAP JSON까지만 만든다. HTML 생성은 우리 코드에서 담당한다.

## 검증 항목

1차 검증은 다음 항목만 본다.

- 녹음기 버튼이 `기록지 추가` 영역과 같은 작성 맥락에 배치되는가
- 녹음 중 상태가 버튼, 문구, 시간 표시 등으로 분명하게 보이는가
- 녹음 종료 후 전사/정리/적용 로딩이 순서대로 자연스럽게 이어지는가
- 브라우저에서 마이크 권한 요청이 정상 동작하는가
- 녹음/전사 시작과 중지가 사용자에게 명확한가
- 전사 텍스트가 다이얼로그에 누적되는가
- SOAP mock 결과가 미리보기로 표시되는가
- 적용 시 새 경과기록 draft sheet에 HTML이 들어가는가
- 기존 저장 버튼으로 저장/재조회가 가능한가
- 브라우저 미지원 또는 권한 거부 시 fallback이 있는가

## 2026-06-03 1차 구현 메모

실제 1차 구현은 다음 파일에 배치했다.

```text
ProgressNote/ProgressNoteWrapper.js
ProgressNote/components/ProgressNote.js
ProgressNote/components/VoiceEmrDialog.js
ProgressNote/components/VoiceEmrPocService.js
ProgressNote/components/ProgressNote.scss
```

구현 흐름은 다음과 같다.

```text
기록지 추가 영역의 음성기록 버튼
-> VoiceEmrDialog 열기
-> WebSpeechSttProvider로 전사
-> MockSoapNormalizer로 SOAP 초안 생성
-> ProgressNote.handleApplyVoiceEmrNote(noteHtml)
-> RecordSheetService.addSheet(defaultContentHtml)
-> 사용자가 기존 저장 버튼으로 저장
```

이 구현은 AI 기능을 붙이지 않는다. 다만 provider 이름을 `WebSpeechSttProvider`, normalizer 이름을 `MockSoapNormalizer`로 남겨 이후 `OpenAiSttProvider`, `AzureSttProvider`, `InternalSttProvider`, `LlmSoapNormalizer`로 교체할 수 있게 했다.

## 2026-06-03 AI STT provider 추가 메모

Web Speech API에서 AirPods 입력은 잡히지만 `no-speech`가 반복되는 문제가 확인되었다. 이 경우 SOAP 이전 단계인 STT 품질이 병목이므로, 기존 Web Speech 흐름은 유지하면서 AI STT provider를 병렬로 추가한다.

추가 구조는 다음과 같다.

```text
브라우저 STT
-> WebSpeechSttProvider
-> 브라우저 Web Speech API가 바로 transcript 반환

AI STT
-> MediaRecorderAiSttProvider
-> MediaRecorder로 audio/webm 또는 audio/mp4 생성
-> FormData(file, language, context)
-> 백엔드 STT gateway
-> transcript 반환
```

FE endpoint는 다음 백엔드 gateway를 전제로 둔다.

```text
POST /medical/recordSheet/voice-to-emr/stt
Content-Type: multipart/form-data
file: voice-to-emr.webm 또는 voice-to-emr.m4a
language: ko-KR
context: JSON
```

백엔드는 OpenAI, Azure, 내부 STT 중 어느 provider를 쓰든 FE 계약을 `transcript` 반환으로 맞춘다. FE가 OpenAI/Azure API key를 들고 외부 STT를 직접 호출하지 않는다.

이번 단계에서 검증하지 않는 것은 다음이다.

- 의료 문장 요약 품질
- 의학 용어 STT 정확도
- 화자 구분
- 처방/상병 후보 추출
- 운영 보안 정책
- 유료 API 비용 산정

## 다음 단계

1차 PoC가 성공하면 다음 순서로 확장한다.

```text
1. 실제 진료 대화 샘플로 Web Speech API 한계 확인
2. STT provider 교체 필요성 판단
3. LLM SOAP normalizer 도입 여부 판단
4. 보안 정책에 맞는 OpenAI/Azure/Internal provider 결정
5. 처방/상병 후보 추천은 별도 phase로 분리
```

이 순서를 지키면 AI 도입 자체가 목적이 되지 않는다. 먼저 업무 흐름을 검증하고, 부족한 품질 지점만 교체한다.
