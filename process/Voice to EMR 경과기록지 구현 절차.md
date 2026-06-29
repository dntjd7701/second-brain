# Voice to EMR 경과기록지 구현 절차

## 목표

이 문서는 Voice to EMR 경과기록지 1차 PoC를 어떤 순서로 구현할지 정리한다. 초기 목표는 먼저 경과기록지 화면 안에서 음성 기반 초안 입력 흐름이 자연스럽게 동작하는지 검증하는 것이었다. 이후 Web Speech API의 STT 품질 한계가 확인되어, 테스트용 음성에 한해 OpenAI STT/SOAP provider를 붙여 흐름을 보강한다.

1차 구현은 품질 검증보다 설득/시연에 가깝다. 사용자가 보는 흐름은 실제 기능처럼 부드러워야 한다. 녹음 중 상태, 변환 중 로딩, SOAP 초안 확인, 기존 경과기록 저장 흐름을 통한 저장까지 하나의 자연스러운 과정으로 보여야 한다.

연결되는 의사결정 배경은 [[Voice to EMR 경과기록지 1차 PoC 의사결정]]에 정리한다. 기존 경과기록지 조회/신규작성 기준은 [[경과기록지_조회와_신규작성_분리_기준]]을 따른다.

## 1차 프로세스

1차 프로세스는 다음으로 고정한다.

```text
MEDA0010 메인 Voice Note 버튼
-> 우측 하단 플로팅 플레이어 표시
-> MediaRecorder 녹음, 파형/타이머/live 상태 표시
-> 일시정지/재개는 실제 MediaRecorder pause/resume으로 처리
-> 정지 시 플레이어에서 처리 로딩
-> MediaRecorder audio blob 생성
-> AI STT 최종 전사
-> AI SOAP 초안 자동 생성
-> Voice Note 결과 다이얼로그에는 SOAP 초안만 우선 표시
-> 사용자가 SOAP 초안 검토/수정
-> 저장 버튼으로 기존 ProgressNote 저장 흐름 실행
```

중요한 점은 저장 책임이다. 화면에서는 `저장` 버튼을 제공하지만, AI가 DB를 직접 저장하는 구조가 아니다. Voice Note는 SOAP HTML을 기존 ProgressNote draft 생성 흐름에 전달하고, 실제 저장은 기존 `ProgressNote.handleSave`와 `RecordSheetService.insert`를 재사용한다.

여기서 녹음 중 UI는 텍스트 미리보기가 아니라 상태 피드백이다. 사용자는 파형, timer, live 표시로 "현재 녹음이 되고 있다"는 피드백을 받는다. 경과기록 초안의 기준이 되는 전사 결과는 녹음 종료 후 audio blob을 AI STT provider에 전달해 생성한 결과다.

## 화면 흐름

`Voice Note` 진입점은 MEDA0010 메인 버튼 영역에 둔다. 경과기록 사이드바 안쪽 버튼으로만 두면 사용자는 경과기록 패널을 먼저 열어야 하고, 녹음 중 다른 화면을 보거나 조작하기 어렵다. Voice Note는 진료 중 언제든 시작할 수 있어야 하므로 메인 버튼으로 이동한다.

녹음 UI는 중앙 모달이 아니라 우측 하단 플로팅 플레이어 방식이다. 이 구조는 사용자가 환자 정보, 처방, 기존 경과기록 등 다른 화면을 보면서 녹음할 수 있게 한다.

```text
Voice Note 버튼 클릭
-> 우측 하단 플레이어 열림
-> 마이크 권한 요청
-> 녹음 시작
-> 파형과 녹음 시간 표시
-> 필요 시 실제 녹음 일시정지/재개
-> 정지
-> 플레이어에서 STT/SOAP 처리 로딩
-> Voice Note 결과 다이얼로그 열림
-> 기본 화면은 SOAP 초안만 표시
-> 전문 보기를 누르면 전사 전문과 화자 구분을 지연 조회
-> 저장
-> 기존 경과기록 저장 흐름 실행
```

## UI 상태 전환

1차 PoC의 설득력은 상태 전환에서 나온다. 버튼을 눌렀는데 텍스트가 갑자기 생기는 방식이면 기능이 가벼워 보인다. 사용자는 녹음, 처리, 적용 과정을 자연스럽게 따라가야 한다.

권장 상태는 다음과 같다.

```text
idle
-> recording
-> paused
-> transcribing
-> normalizing
-> applying
-> completed
```

상태별 UI 기준은 다음과 같다.

- `idle`: MEDA0010 메인 버튼에 Voice Note gradient 버튼을 표시한다.
- `recording`: 메인 버튼은 빨간 pulse 상태로 바뀌고, 플로팅 플레이어에는 파형과 시간이 표시된다.
- `paused`: MediaRecorder를 실제 pause 상태로 두고, 플레이어에는 재개/정지 버튼을 표시한다.
- `transcribing`: 녹음 종료 후 플레이어에서 처리 로딩을 보여준다.
- `normalizing`: SOAP 기준으로 정리 중인 상태를 표시한다.
- `applying`: 저장 버튼 클릭 후 기존 ProgressNote 저장 흐름 실행 중임을 나타낸다.
- `completed`: 저장 성공 메시지를 보여주고 Voice Note를 닫는다.

`recording` 상태는 색상과 아이콘 변화가 있어야 한다. 시연에서는 메인 Voice Note 버튼 자체가 빨간 pulse 상태가 되어야 한다. 사용자가 다른 화면을 보고 있어도 현재 녹음 중임을 놓치지 않게 하기 위함이다.

다이얼로그에는 최소한 다음 상태가 필요하다.

- 대기
- 녹음 중
- 전사 완료
- SOAP 변환 완료
- 적용 완료
- 오류

## 2026-06-05 Voice Note UX 재정의

최신 구현 기준은 "전문 우선"이 아니라 "SOAP 초안 우선"이다.

이렇게 바꾼 이유는 다음과 같다.

- 사용자가 매번 STT 전문을 볼 필요는 없다.
- 사용자의 목적은 전사 검수가 아니라 경과기록 작성 보조다.
- 녹음은 다른 화면을 보면서 진행되어야 하므로 우측 하단 플레이어가 적합하다.
- SOAP 초안이 생성되면 사용자가 바로 저장할 수 있어야 사용성이 높다.

따라서 결과 다이얼로그는 기본적으로 SOAP 초안만 보여준다. 전사 전문과 화자 구분은 `전문 보기` 버튼을 눌렀을 때만 표시한다.

```text
기본 결과 화면:
SOAP 초안
닫기 / 재녹음 / 저장

전문 보기 클릭 후:
좌측 전문 + 화자 라벨
우측 SOAP 초안
닫기 / 재녹음 / 저장
```

전문 보기를 지연 처리하는 이유는 비용과 지연을 줄이고, 화면을 경과기록 초안 중심으로 유지하기 위해서다. 화자 역할 분류는 STT 결과의 speaker segment를 기반으로 후처리하며, 사용자가 요청한 경우에만 호출한다.

오류는 화면에서 숨기지 않는다. 마이크 권한 거부, 브라우저 미지원, 전사 실패, 빈 전사 결과는 사용자에게 명확히 알려야 한다.

## FE 구성

1차에서는 FE 중심으로 구현한다.

```text
VoiceEmrDialog
MediaRecorderAiSttProvider
OpenAI STT plain endpoint
SpeakerRoleClassifier 지연 호출
LlmSoapNormalizer
SoapHtmlRenderer
ProgressNote.handleSaveVoiceEmrNote(noteHtml)
```

역할은 다음처럼 나눈다.

- `MEDA0010`: 메인 Voice Note 버튼, 녹음 상태 버튼 스타일, Voice Note 저장 handler 담당
- `VoiceEmrDialog`: 플로팅 녹음 플레이어, SOAP 우선 결과 다이얼로그, 전문 보기 지연 조회, 재녹음/저장 담당
- `MediaRecorderAiSttProvider`: 음성 파일을 백엔드 STT plain gateway로 전달
- `OpenAI STT plain endpoint`: 녹음 blob을 전사하고 SOAP 생성에 필요한 transcript를 반환
- `SpeakerRoleClassifier`: `전문 보기` 클릭 시 speaker segment를 의사/간호사/환자/화자 미정으로 후처리
- `LlmSoapNormalizer`: transcript를 백엔드 SOAP normalizer로 전달
- `SoapHtmlRenderer`: SOAP JSON을 경과기록 HTML로 변환
- `handleSaveVoiceEmrNote`: 생성된 noteHtml을 새 경과기록 draft sheet로 추가한 뒤 기존 저장 흐름 실행

브라우저 STT provider는 현재 기준선에서 제거한다. 녹음 중 텍스트 미리보기는 불안정하고 최종 전사와 혼선을 만들 수 있으므로, 녹음 중에는 파형/타이머만 보여준다. 브라우저가 MediaRecorder를 지원하지 않거나 마이크 권한이 거부되면 오류 메시지를 보여주고 수동 전사 입력 흐름으로 fallback한다.

## SOAP 정리 정책

초기 구상에서는 SOAP 변환을 mock/rule 기반으로 처리할 수 있다고 보았다. 그러나 키워드 판단 형식의 `MockSoapNormalizer`는 실제 SOAP 분류처럼 보이지만 정확한 의료 판단이 아니므로, OpenAI SOAP provider를 붙인 뒤에는 제거하는 편이 맞다.

현재 기준은 다음과 같다.

```text
SOAP 정리 성공
-> LLM이 subjective/objective/assessment/plan JSON 반환
-> FE의 SoapHtmlRenderer가 경과기록 HTML 생성

SOAP 정리 실패
-> 키워드 mock SOAP을 만들지 않음
-> transcript를 수정 가능 상태로 유지
-> 사용자가 원문 그대로 경과기록 draft에 입력 가능
```

이 방식의 목적은 시연 중 실패를 숨기는 것이 아니라, SOAP 품질 문제와 경과기록 입력 흐름을 분리하는 것이다. STT 또는 SOAP 품질이 낮아도 사용자는 전사 내용을 직접 수정하거나 원문 draft를 입력할 수 있다.

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
2026-06-05 이후 Voice Note 결과 화면에는 별도 `저장` 버튼을 둔다. 다만 이 버튼은 저장 API를 직접 호출하지 않고 기존 ProgressNote 저장 흐름을 재사용한다.

```text
Voice Note 저장 버튼
-> ProgressNoteWrapper.handleSaveVoiceEmrNote(noteHtml)
-> ProgressNote.handleSaveVoiceEmrNote(noteHtml)
-> RecordSheetService.addSheet(defaultContentHtml)
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
  MediaRecorderAiSttProvider
  OpenAiSttProvider
  AzureSttProvider
  InternalSttProvider

SoapNormalizer
  LlmSoapNormalizer
  SoapHtmlRenderer
```

1차에서는 `MediaRecorderAiSttProvider`, OpenAI STT, speaker role classifier, `LlmSoapNormalizer`, `SoapHtmlRenderer`를 사용한다.

2차 품질 검증에서 STT 품질이 문제로 확인되면 `OpenAiSttProvider`, `AzureSttProvider`, `InternalSttProvider` 중 운영 기준에 맞는 provider로 교체한다.

SOAP 정리 품질이 문제로 확인되면 `LlmSoapNormalizer`를 붙인다. 이때도 LLM은 HTML을 직접 만들지 않고 SOAP JSON까지만 만든다. HTML 생성은 우리 코드에서 담당한다.

## 검증 항목

1차 검증은 다음 항목만 본다.

- 녹음기 버튼이 `기록지 추가` 영역과 같은 작성 맥락에 배치되는가
- 녹음 중 상태가 버튼, 문구, 시간 표시 등으로 분명하게 보이는가
- 녹음 종료 후 전사/정리/적용 로딩이 순서대로 자연스럽게 이어지는가
- 브라우저에서 마이크 권한 요청이 정상 동작하는가
- 녹음/전사 시작과 중지가 사용자에게 명확한가
- 녹음 중 파형과 녹음 시간이 자연스럽게 표시되는가
- 녹음 종료 후 최종 전사 텍스트가 다이얼로그에 표시되는가
- SOAP 정리 성공 시 SOAP HTML 미리보기가 표시되는가
- SOAP 정리 실패 시 키워드 mock이 아니라 원문 입력 fallback이 유지되는가
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
MEDA0010/MEDA0010.js
MEDA0010/MEDA0010.scss
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

이 구현은 AI 기능을 붙이지 않았던 최초 기준이다. 다만 provider 이름을 `WebSpeechSttProvider`, normalizer 이름을 `MockSoapNormalizer`로 남겨 이후 `OpenAiSttProvider`, `AzureSttProvider`, `InternalSttProvider`, `LlmSoapNormalizer`로 교체할 수 있게 했다.

이후 OpenAI STT/SOAP provider를 붙인 뒤에는 키워드 판단 방식의 `MockSoapNormalizer`를 제거했다. 현재 시연 흐름은 SOAP 정리 성공 시 LLM JSON을 HTML로 렌더링하고, 실패 시 transcript 원문을 수정 가능 상태로 유지한 뒤 원문 그대로 경과기록 draft에 입력할 수 있게 한다.

2026-06-05 기준 최신 구현은 다음처럼 바뀌었다.

```text
MEDA0010 메인 Voice Note 버튼
-> VoiceEmrDialog 플로팅 플레이어
-> MediaRecorderAiSttProvider
-> POST /medical/recordSheet/voice-to-emr/stt/plain
-> STT-only transcript 반환
-> POST /medical/recordSheet/voice-to-emr/soap
-> SOAP HTML 생성
-> Voice Note 결과 다이얼로그에는 SOAP 초안만 우선 표시
-> 저장
-> ProgressNote.handleSaveVoiceEmrNote(noteHtml)
-> 기존 경과기록 저장 흐름

전문 보기 선택 시:
plain STT result
-> POST /medical/recordSheet/voice-to-emr/speaker-role
-> 화자 역할 보정
-> 전문 영역 확장 표시
```

메인 Voice Note 버튼은 이전 경과기록 내부 버튼의 gradient/shimmer 디자인을 유지한다. 녹음 중에는 빨간 gradient와 pulse shadow로 바뀌어 사용자가 다른 화면을 보고 있어도 녹음 상태를 인지할 수 있게 한다.

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

medical 백엔드에는 다음 진입점을 둔다.

```text
RecordSheetController
-> POST /recordSheet/voice-to-emr/stt
-> IRecordSheetService.transcribeVoiceToEmr(file, language, context)
-> RecordSheetService.transcribeVoiceToEmrProvider(...)
```

이때 외부에서 호출되는 실제 경로는 medical prefix를 포함한 `/medical/recordSheet/voice-to-emr/stt`가 된다. 서비스는 음성 파일 누락을 먼저 검증하고, provider가 설정되지 않은 상태에서는 `Voice to EMR AI STT provider가 설정되지 않았습니다. OpenAI/Azure/Internal STT 연결 후 사용하세요.`라는 명확한 오류를 반환한다.

이 오류는 기능 실패가 아니라 현재 단계의 경계 표시다. 즉, FE가 `MediaRecorder`로 음성 파일을 만들고 medical 백엔드까지 전달하는 통로는 확인하되, 실제 STT 품질 검증은 OpenAI/Azure/Internal STT 중 하나를 붙이는 다음 단계에서 수행한다.

### OpenAI API key 제공 방식

PoC에서 OpenAI STT를 테스트하더라도 API key는 FE, 소스코드, Vault 문서에 남기지 않는다. medical 백엔드에는 다음 파일을 optional import로 둔다.

```text
config/application.yml
-> optional:file:./config/voice-to-emr.local.yml
```

샘플 설정은 `config/voice-to-emr.example.yml`에 두고, 실제 key는 git에서 제외되는 `config/voice-to-emr.local.yml`에만 입력한다.

```yaml
voice-to-emr:
  stt:
    provider: openai
    openai:
      api-key: <local-openai-api-key>
      base-url: https://api.openai.com
      model: gpt-4o-mini-transcribe
```

이 방식은 `export OPENAI_API_KEY=...` 방식보다 사용자가 이해하기 쉽고, local PoC 환경을 재현하기 쉽다. 단, 실제 환자 음성이나 개인정보가 포함된 녹취를 외부 provider로 전송하지 않는다는 테스트 전제를 지켜야 한다.

### OpenAI 직접 호출 PoC 구현

2026-06-03 기준 OpenAI STT 직접 호출을 PoC 목적으로 붙인다. 사용 전제는 명확하다.

```text
실제 환자 음성/개인정보는 사용하지 않는다.
테스트용 음성만 OpenAI로 전송한다.
```

구현 흐름은 다음과 같다.

```text
FE AI STT 모드
-> MediaRecorder 음성 파일 생성
-> POST /medical/recordSheet/voice-to-emr/stt
-> RecordSheetService.transcribeVoiceToEmrProvider(...)
-> provider=openai 확인
-> OpenAiVoiceToEmrSttClient
-> POST https://api.openai.com/v1/audio/transcriptions
-> 응답 text를 transcript로 반환
```

`OpenAiVoiceToEmrSttClient`는 multipart 요청을 만들고, OpenAI 응답의 `text` 값을 `VoiceToEmrSttResponseDto.transcript`로 변환한다. 로그에는 API key, 음성 원문, transcript 원문을 남기지 않는다. 실패 로그는 HTTP 상태, 모델명, 파일 크기 정도만 남긴다.

OpenAI 호출에는 `context`를 전달하지 않는다. FE가 전달하는 context에는 화면/환자/진료 맥락이 섞일 수 있으므로, 직접 호출 PoC에서는 음성 파일과 언어값만 외부 provider에 보낸다.

STT 정확도가 낮을 때는 OpenAI transcription의 `prompt` 파라미터에 일반 EMR 힌트를 제공한다. 이 prompt는 환자별 context가 아니라 다음과 같은 도메인 힌트만 포함한다.

```text
한국어 의사와 환자의 외래 진료 대화
경과기록지와 SOAP 작성을 위한 전사
주관적 증상, 객관적 소견, 평가, 계획
기침, 가래, 발열, 인후통, 호흡곤란, 혈압, 맥박, 체온, 산소포화도, 검사, 처방, 재진, 추적 관찰
```

이 방식은 STT가 “이 음성이 어떤 도메인의 대화인지”를 알게 해 의학 용어와 경과기록 표현을 더 잘 선택하도록 돕는다. 단, 환자별 개인정보나 실제 진료 맥락을 prompt에 넣지 않는다.

무음 또는 짧은 잡음이 OpenAI STT로 전송되면, EMR 도메인 prompt 때문에 그럴듯한 의학 문장으로 추측 전사될 수 있다. 예를 들어 아무 말도 하지 않았는데 `Abdomen 단순촬영에서 obstruction 소견 보입니다.`처럼 실제 발화가 아닌 결과가 생성될 수 있다. 이 방식은 의료 기록 보조 기능에서는 위험하므로 다음 안전장치를 둔다.

```text
FE
-> AI STT 녹음 시간이 최소 기준보다 짧으면 provider 호출 전에 차단
-> 무음/짧은 잡음 파일을 OpenAI로 보내지 않음

BE
-> OpenAI transcription prompt에 추측 금지 문구를 항상 추가
-> 커스텀 prompt를 사용하더라도 "들리지 않는 말, 검사명, 진단명, 소견을 임의 생성하지 말라"는 안전 문구 유지
```

이 안전장치는 STT 품질 개선이 아니라 위험한 false positive를 줄이기 위한 장치다. 운영 전환 단계에서는 녹음 길이뿐 아니라 실제 음성 레벨을 검사하는 VAD 또는 오디오 레벨 기반 음성 감지까지 추가해야 한다.

### OpenAI SOAP 분류 PoC 구현

STT가 transcript를 반환한 뒤, 기존 `MockSoapNormalizer` 대신 백엔드 LLM SOAP normalizer를 먼저 호출한다.

```text
transcript
-> POST /medical/recordSheet/voice-to-emr/soap
-> RecordSheetService.normalizeVoiceToEmrSoap(...)
-> provider=openai 확인
-> OpenAiVoiceToEmrSoapClient
-> POST https://api.openai.com/v1/responses
-> structured outputs JSON
-> subjective/objective/assessment/plan 반환
-> FE에서 noteHtml 생성
```

LLM은 경과기록 HTML을 직접 만들지 않는다. LLM은 SOAP JSON만 반환하고, HTML 생성은 FE의 `toHtml` 로직이 담당한다. 이 경계를 유지해야 나중에 SOAP 문구 품질만 조정하고, 경과기록 editor 삽입 구조는 그대로 유지할 수 있다.

OpenAI SOAP 호출은 `voice-to-emr.soap.provider`가 없으면 `voice-to-emr.stt.provider` 값을 따른다. 따라서 local PoC에서는 `stt.provider=openai`만 있어도 SOAP 분류가 OpenAI로 동작한다. SOAP 모델은 기본값 `gpt-4o-mini`를 사용한다.

FE에서는 LLM SOAP 분류가 실패해도 mock 분류로 fallback하지 않는다. 키워드 기반 SOAP은 정확한 의료 판단처럼 오해될 수 있으므로, 실패 시에는 SOAP 미리보기를 비우고 transcript 수정/원문 입력 흐름으로 되돌린다. 시연 중 외부 API 오류가 발생해도 경과기록 draft 입력 자체는 끊기지 않지만, SOAP 정리가 성공한 것처럼 보이게 만들지는 않는다.

이번 단계에서 검증하지 않는 것은 다음이다.

- 의료 문장 요약 품질
- 의학 용어 STT 정확도
- 화자 구분
- 처방/상병 후보 추출
- 운영 보안 정책
- 유료 API 비용 산정

## 2026-06-05 브라우저 STT 미리보기 검토와 제거 결정

Realtime 전환을 검토한 뒤, 한때 1차 기준선을 "브라우저 STT 미리보기 + 파일 업로드형 STT"로 정리했다. 이유는 1차 PoC에 필요한 것이 진짜 AI realtime 전사가 아니라, 녹음 중 사용자에게 충분한 피드백을 주는 화면 흐름이라고 보았기 때문이다.

당시 검토안은 다음과 같았다.

```text
녹음 시작
-> MediaRecorder로 실제 음성 녹음 시작
-> Web Speech API로 실시간 미리보기 텍스트 표시
-> 녹음 종료
-> MediaRecorder audio blob 확정
-> POST /medical/recordSheet/voice-to-emr/stt
-> OpenAI STT가 녹음본 기준 최종 transcript 반환
-> 최종 transcript를 전사 내용 textarea에 반영
-> 사용자가 오인식 문구 수정
-> SOAP 정리 또는 원문 적용
-> 경과기록 draft sheet 추가
```

이 구조에서 브라우저 STT는 UX provider이고, AI STT는 최종 데이터 provider다. 두 결과를 섞지 않는다는 원칙은 맞았다. 그러나 실제 테스트 결과, 브라우저 STT 미리보기 자체가 사용자 신뢰를 떨어뜨릴 수 있다는 문제가 확인되었다.

제거 이유는 다음이다.

- `no-speech`, `onend`가 빈번하게 발생해 녹음 중 미리보기가 중간에 끊긴다.
- AirPods 등 입력 장치가 OS에는 정상 인식되어도 Web Speech API에서는 발화 감지가 실패할 수 있다.
- 짧은 발화와 한국어 의료 표현에서 텍스트가 흔들리며, 최종 전사와 다른 내용이 화면에 먼저 노출된다.
- 미리보기 텍스트가 부정확하면 사용자는 최종 전사 결과까지 의심하게 된다.
- 브라우저/OS/네트워크/권한 상태에 따라 재현성이 달라 운영 확장 기준으로 설명하기 어렵다.

따라서 최종 기준선은 다음으로 변경한다.

```text
녹음 시작
-> MediaRecorder로 실제 음성 녹음 시작
-> 파형, 녹음 시간, live 상태로 녹음 중임을 표시
-> 녹음 종료
-> MediaRecorder audio blob 확정
-> POST /medical/recordSheet/voice-to-emr/stt
-> OpenAI STT가 녹음본 기준 최종 transcript와 speaker segment 반환
-> speaker role classifier가 의사/간호사/환자/보호자/화자 미정으로 후처리
-> 최종 transcript를 전사 내용 textarea에 반영
-> 사용자가 오인식 문구 수정
-> SOAP 정리 또는 원문 적용
-> 경과기록 draft sheet 추가
```

브라우저 STT 미리보기는 제거한다. 녹음 중에는 텍스트 대신 파형/타이머를 보여준다. 최종 전사에는 녹음본 기준 AI STT 결과만 사용한다.

UI에서는 이 차이를 다음 문구로 드러낸다.

```text
녹음 중:
녹음 중, 00:00:00, 파형

녹음 종료 후:
녹음본 기준 최종 전사 생성 중

전사 편집 영역:
최종 전사 결과
```

이 기준선을 선택한 이유는 다음과 같다.

- 녹음 중 UI 반응성은 텍스트가 아니라 파형/타이머로도 충분히 표현할 수 있다.
- 브라우저 STT에 의존하지 않으므로 의료기록 후보의 품질 기준을 하나로 유지할 수 있다.
- blob STT는 REST 기반이므로 현재 medical 백엔드 구조와 잘 맞는다.
- Realtime WebSocket proxy, VAD, 세션 유지, 모델별 payload 차이를 1차 범위에서 제외할 수 있다.
- 나중에 진짜 realtime 품질이 필요해지면 별도 브랜치에서 `gpt-realtime-whisper`로 확장하면 된다.

비용 기준도 1차 기준선을 뒷받침한다. 2026-06-05 OpenAI 공식 가격표 기준으로 STT 비용은 다음과 같이 차이 난다.

```text
gpt-4o-mini-transcribe: 약 $0.003/min
gpt-4o-transcribe: 약 $0.006/min
gpt-realtime-whisper: 약 $0.017/min
```

즉 `gpt-realtime-whisper`는 `gpt-4o-mini-transcribe` 대비 약 5.7배 비싸다. 5분 진료 1,000건 기준으로 단순 계산하면 blob mini 전사는 약 $15, realtime whisper는 약 $85 수준이다. 이 차이는 1차 PoC에서 무시하기 어렵다.

따라서 현재 구현 기준은 다음 문장으로 정리한다.

> 녹음 중에는 파형/타이머로 살아 있는 사용자 경험을 만들고, 실제 전사와 경과기록 초안 생성은 녹음 blob 기반 AI STT 결과를 기준으로 한다.

참고 자료:

- [OpenAI API Pricing](https://developers.openai.com/api/docs/pricing)
- [gpt-realtime-whisper model](https://developers.openai.com/api/docs/models/gpt-realtime-whisper)
- [gpt-realtime model](https://developers.openai.com/api/docs/models/gpt-realtime)

## 2026-06-04 Realtime STT UI 전환 검토 메모

Web Speech API와 파일 업로드형 STT 모두 시연은 가능하지만, 사용자가 보기에는 "녹음 종료 후 결과가 생기는 기능"에 가깝다. 경과기록 Voice to EMR을 설득/시연하려면 녹음 중에 대화가 실제로 전사되고 있다는 장면이 더 중요하다고 보았다. 그래서 2026-06-04 구현에서는 기존 흐름을 Realtime STT 중심 UI로 재구성하는 안을 검토했다.

다만 2026-06-05 재검토 결과, 이 Realtime 구조는 1차 기준선이 아니라 2차 확장 후보로 둔다. 1차에서는 위의 "파형/타이머 + blob 최종 전사" 방식을 사용한다.

변경된 화면 구조는 다음이다.

```text
VoiceEmrDialog 1080 x 720
-> 상단: icon 녹음 버튼, 00:00:00 timer, WebSocket 상태, STT 상태
-> 좌측: 실시간 대화 bubble timeline
-> 우측: SOAP 초안 preview/edit
```

Realtime 프로세스는 다음으로 고정한다.

```text
녹음 시작
-> FE RealtimeAiSttProvider
-> 마이크 입력을 24kHz mono PCM chunk로 변환
-> WebSocket /medical/recordSheet/voice-to-emr/realtime
-> medical backend OpenAI Realtime WebSocket proxy
-> input_audio_buffer.append
-> transcription.delta/completed 수신
-> 발화 bubble 누적/확정
-> 화자 자동 추정
-> 사용자 화자/전사 텍스트 보정
-> SOAP 정리 버튼
-> 경과기록 draft 적용
```

중요한 의사결정은 SOAP을 realtime 중 자동 생성하지 않는 것이다. 실시간 중에는 STT와 화자 표시만 한다. SOAP은 사용자가 확정 발화와 화자 label을 확인한 뒤 `SOAP 정리`를 클릭할 때만 실행한다. 이는 잘못 전사된 문장이 곧바로 경과기록 초안으로 요약되는 위험을 줄이기 위한 구조다.

화자는 다음 내부 값으로만 관리한다.

```text
doctor   -> 의사
nurse    -> 간호사
patient  -> 환자
guardian -> 보호자
unknown  -> 화자 미정
```

화자 자동 추정은 prompt 기반으로 시도하지만, 확정값이 아니다. UI에서 사용자가 select로 수정한 label을 SOAP 생성 시 우선 사용한다. 전사 텍스트도 확정 bubble에서 수정 가능하게 둔다.

백엔드에는 다음 경계를 둔다.

```text
Realtime STT
-> /recordSheet/voice-to-emr/realtime
-> VoiceToEmrRealtimeWebSocketHandler
-> OpenAI Realtime WebSocket

Speaker classify
-> /recordSheet/voice-to-emr/speaker
-> OpenAiVoiceToEmrSpeakerClient
-> Responses API structured output

SOAP normalize
-> /recordSheet/voice-to-emr/soap
-> OpenAiVoiceToEmrSoapClient
-> Responses API structured output
```

prompt는 Java 문자열에 묶어두지 않고 resource md 파일로 분리한다.

```text
resources/config/voice-to-emr-realtime-stt.md
resources/config/voice-to-emr-speaker-classifier.md
resources/config/voice-to-emr-soap-normalizer.md
```

원래 계획은 `voice-to-emr/prompts/*.md`였지만, 현재 작업 환경에서는 새 resource 하위 디렉터리 생성 권한이 막혀 있었다. 따라서 기존 `resources/config` 디렉터리 아래에 md 파일을 두고, `VoiceToEmrPromptLoader`가 해당 resource를 읽도록 조정했다. 위치는 다르지만 "prompt를 파일로 분리해 언제든 교체한다"는 의도는 유지된다.

이 단계의 핵심 메시지는 다음이다.

```text
Realtime 전환의 목적은 AI 판단 자동화가 아니라, STT가 이루어지는 과정을 사용자에게 보여주고
사용자가 발화/화자를 검토한 뒤 SOAP 초안을 적용하게 만드는 것이다.
```

## 다음 단계

1차 PoC가 성공하면 다음 순서로 확장한다.

```text
1. 테스트용 진료 대화 샘플로 blob STT 품질과 화자 구분 품질 확인
2. STT provider를 OpenAI/Azure/Internal 중 어떤 운영 기준으로 가져갈지 판단
3. LLM SOAP normalizer의 정확도와 실패 fallback 기준 검증
4. 보안 정책에 맞는 외부 전송, 로그, 보관, masking 기준 결정
5. Realtime STT는 실제 요구가 확정되면 별도 phase로 분리
6. 처방/상병 후보 추천은 별도 phase로 분리
```

이 순서를 지키면 AI 도입 자체가 목적이 되지 않는다. 먼저 업무 흐름을 검증하고, 부족한 품질 지점만 교체한다.

## 2026-06-12 OneAI provider 전환 단계

OpenAI 직접 호출 PoC 이후 운영 기준에서는 OneAI를 STT/LLM gateway로 사용할 가능성이 생겼다. 분석 결과 1차 전환은 FE를 바꾸지 않고 medical BE의 provider adapter에서 OneAI API를 호출하는 방식이 가장 작다.

정리한 기준은 [[OneAI Voice Note Provider 전환 분석]]에 둔다. 핵심 결정은 다음과 같다.

```text
1차 STT: OneAI Voice Object 기반 STT
1차 SOAP: OneAI oai001A04 동기 LLM 호출
품질 gate: medical BE에서 관리
FE 계약: voiceUid/mqttTopic 기반 MQTT 상태 수신
보정: MQTT timeout 시 status API 1회 조회
후속: audio seek, rawResult 재가공, job 복구는 별도 phase
```

2026-06-29 기준으로 FE 완료 감지는 기존 2초 polling에서 MQTT 상태 수신으로 바뀌었다. SOAP 초안은 먼저 노출하고, 전문 및 화자 구분은 SOAP 이후 백그라운드 또는 전문보기 시점에 처리한다. 이 변경의 상세 배경과 결과는 [[Voice Note 성능 개선 - MQTT 상태 수신과 SOAP 우선 노출]]에 정리한다.

사용자 로컬 테스트 기준으로 완료 시간은 약 44초에서 약 30초로 줄었다. GCS batch 기반 Voice Object 흐름의 rawResult 보존, audio seek, 서버 재시작 후 복구는 실제 요구가 확정될 때 재검토한다.
