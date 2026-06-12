# OneAI Voice Note Provider 전환 분석

## 배경

Voice Note 1차 PoC는 `amaranth10-medical`에서 OpenAI STT와 SOAP LLM을 직접 호출하는 구조로 구현했다. 이 구조는 빠르게 업무 흐름을 검증하기에는 좋지만, 운영 기준에서는 회사 내부 AI gateway인 OneAI를 통해 STT와 LLM을 호출해야 할 가능성이 있다.

이번 분석의 목적은 OneAI를 붙일 수 있는지, 붙인다면 어디까지 기존 Voice Note 계약을 유지할 수 있는지 판단하는 것이다. 핵심 결론은 다음이다.

```text
1차 전환은 FE 변경 없이 medical BE provider adapter에서 OneAI API를 호출한다.
STT는 GCS batch가 아니라 oai001A02 multipart STT부터 시작한다.
품질 gate와 SOAP JSON 검증은 medical이 책임진다.
```

## 현재 Voice Note 구조

현재 Voice Note는 FE가 녹음 blob을 medical BE로 전송하고, BE가 job을 생성한 뒤 worker에서 STT와 SOAP 생성을 처리한다. FE는 jobId로 polling한다.

```text
FE 녹음 Blob
-> medical BE VoiceToEmrJobService job 생성
-> worker thread에서 STT 실행
-> STT 품질 gate
-> SOAP LLM 정리
-> FE polling으로 결과 표시
```

이 구조 덕분에 브라우저와 proxy의 긴 HTTP 대기 timeout은 이미 피하고 있다. 다만 worker 내부에서 외부 STT/LLM 호출을 기다리는 문제는 여전히 provider timeout, thread 점유, 재시도 정책으로 관리해야 한다.

## OneAI STT 선택지

### oai001A02 multipart STT

`oai001A02`는 음성 파일을 multipart `content`로 받아 STT provider에 전달한다. 현재 Voice Note가 브라우저 녹음 blob을 multipart로 보내고 있으므로 1차 전환 후보로 가장 가깝다.

장점은 단순성이다.

- FE 계약을 바꾸지 않아도 된다.
- medical BE에서 OneAI API만 호출하면 된다.
- 10분 이하 녹음이면 기존 job polling과 read timeout 조정으로 먼저 검증할 수 있다.
- GCS, Kafka, operationId 상태 조회를 medical이 직접 알 필요가 없다.

주의할 점도 명확하다.

- 공개 응답은 단순 STT 결과 중심이다.
- OpenAI plain STT처럼 logprob 품질 지표를 기대하면 안 된다.
- speaker segment, timestamp, rawResult는 v1에서 없다고 보고 설계한다.
- 품질 판단은 medical의 `empty`, 최소 길이, 최소 단어 수, 음성 길이 기준으로 대체한다.

### oai011A01 / oai011A04 Voice Object STT

`oai011A01`은 파일 경로 기반으로 OneAI Voice Object를 만들고, Kafka와 GCS, Google Speech-to-Text v2 batchRecognize 흐름을 태운다. `oai011A04`는 완료된 STT 결과를 조회한다.

```text
파일 경로
-> DZAiVoiceObject 생성
-> Kafka ai.stt.v1 이벤트
-> GCS 업로드
-> Google batchRecognize 요청
-> operationId 저장
-> 배치가 PROCESSING 작업 조회
-> operationId done 확인
-> GCS output JSON 파싱
-> transcript/rawResult Elasticsearch 저장
-> oai011A04로 text 조회
```

이 방식은 긴 음성, 재처리, rawResult 보존, 화자 정보 재가공에는 더 탄탄하다. 하지만 Voice Note 1차 전환에는 무겁다.

- 현재 Voice Note는 파일 경로가 아니라 브라우저 blob을 보낸다.
- OneAI Voice Object는 `SessionUtil.getUser()`와 ECM/DB/GCS/Kafka 상태를 전제로 한다.
- 공개 결과가 `uid/status/text` 중심이라 `VoiceToEmrSttResponseDto.speakerSegments`와 `quality`를 바로 채우기 어렵다.
- FE에 OneAI `voiceUid`나 `operationId`를 노출하면 1차 범위가 커진다.

따라서 1차는 `oai001A02`를 사용하고, 아래 조건이 생기면 Voice Object 흐름을 재검토한다.

- 10분 녹음에서 multipart STT timeout이나 성능 문제가 반복된다.
- 화자 timestamp와 audio seek가 제품 요구로 확정된다.
- 서버 재시작 후 STT job 복구가 필요해진다.
- STT rawResult 보존과 재가공이 운영 요구가 된다.

## GCS, Kafka, operationId, Elasticsearch 개념

GCS는 Google Cloud Storage다. OneAI Voice Object 흐름에서는 음성 파일과 Google STT 결과 JSON을 저장하는 외부 객체 저장소 역할을 한다. Google batchRecognize는 파일 bytes를 긴 HTTP 요청에 싣기보다 `gs://...` URI를 입력으로 받고, 결과도 GCS output 경로에 남기는 방식과 잘 맞다.

Kafka는 STT 요청 시작 이벤트를 consumer에게 넘기는 큐다. 여기서 중요한 점은 Kafka가 완료 상태를 계속 들여다보는 구조가 아니라는 것이다. 최초 요청은 Kafka로 전달하고, 이후 진행 추적은 DB에 저장된 Voice Object와 Google operationId polling으로 처리한다.

operationId는 Google batchRecognize가 반환하는 비동기 작업 식별자다. OneAI는 이 값을 `DZAiVoiceObject.operationId`에 저장하고, 배치가 `PROCESSING` 상태 작업을 조회해 Google에 `done=true` 여부를 반복 확인한다.

Elasticsearch는 완료된 STT 결과의 조회와 재가공을 위한 저장소다. GCS output이 정리된 뒤에도 `transcript`와 `rawResult`를 다시 찾을 수 있게 한다. `rawResult`에는 word offset, speaker label 같은 부가 정보가 포함될 수 있어 화자별 스크립트나 audio seek 같은 후속 기능의 재료가 된다.

## OneAI SOAP 후보

SOAP 정리는 OneAI의 `oai001A04` 동기 LLM 호출이 1차 후보에 가깝다. 기존 Voice Note의 OpenAI Responses API 호출은 `json_schema strict`로 `subjective`, `objective`, `assessment`, `plan` 네 필드를 강제했다.

OneAI `oai001A04`는 동기 GPT 호출이 가능하지만 OpenAI Responses API의 `text.format.json_schema strict`와 같은 계약을 그대로 보장한다고 보면 안 된다. 따라서 OneAI SOAP provider를 붙일 때는 medical에서 아래 검증을 맡는다.

- 응답 content에서 JSON 추출
- `subjective`, `objective`, `assessment`, `plan` 필드 존재 확인
- 필드가 없거나 JSON 파싱이 실패하면 SOAP 실패로 처리
- STT transcript는 보존하고 SOAP만 재시도 가능하게 유지

LLM은 경과기록 HTML을 직접 만들지 않는다. LLM은 SOAP JSON만 반환하고, HTML 생성과 경과기록 draft 적용은 기존 FE/ProgressNote 흐름을 유지한다.

## 크레딧 테스트 조건

OneAI의 quota 차단은 `oneAiLimitFlag` 설정에 영향을 받는다.

```text
oneAiLimitFlag=false
-> quota 차단 없이 테스트 가능성이 높음
-> 사용량은 FREE 타입 등으로 기록될 수 있음

oneAiLimitFlag=true
-> Redis의 oneAiPoint, oneAiFreePoint, current point 기준으로 검사
-> 잔여량이 없으면 exhaustion.ai.quota 발생
```

`oai001A02`는 음성 길이와 `WHISPER` credit 기준으로 사전 quota를 확인하고, 성공 후 사용량 통계를 기록한다. `oai001A04` 같은 LLM API는 `@AiCalculate` aspect가 사전 quota check를 수행한다.

따라서 개발 테스트에서는 두 가지를 분리해서 확인해야 한다.

- 차단: `checkQuota()`가 요청을 막는지
- 기록/차감: `createStat()` 이후 사용량이 어떻게 남고, WEHAGO 계열 고객사에서 외부 차감 API가 타는지

## 단계적 구현 계획

### Phase 1. provider interface 정리

medical BE 안에서 STT, SOAP, speaker role provider 경계를 명시한다. 기존 OpenAI 구현은 유지하되, 문자열 분기만 직접 흩어지지 않게 한다.

### Phase 2. OneAI STT

`voice-to-emr.stt.provider=oneai` 설정 시 `oai001A02`를 호출한다. 응답 텍스트를 `VoiceToEmrSttResponseDto`로 변환하고, 품질은 medical 기준으로 판단한다.

### Phase 3. OneAI SOAP

`voice-to-emr.soap.provider=oneai` 설정 시 `oai001A04`를 호출한다. 기존 prompt를 messages로 구성하고, 응답 JSON을 medical에서 검증한다.

### Phase 4. 로그와 단계별 재시도

provider, 단계, 처리 시간, transcript 길이, 실패 원인을 남긴다. STT 성공 후 SOAP가 실패하면 STT를 다시 호출하지 않고 SOAP만 재시도할 수 있게 한다.

### Phase 5. 크레딧 검증

개발 환경의 `oneAiLimitFlag`와 Redis quota 상태를 확인한다. medical에서 OneAI 호출 시 사용자 세션, 쿠키, 인증 헤더가 OneAI quota/통계 경로에 맞게 전달되는지 검증한다.

### Phase 6. audio seek 후속

전문 문장이나 화자 segment를 클릭하면 녹음 플레이어가 해당 시점으로 이동하는 기능이다.

```text
전문 문장 클릭
-> segment.start 시각 확인
-> audio.currentTime 이동
-> 해당 발화 재생
```

이 기능은 `speakerSegments.start/end` 또는 word offset이 필요하다. `oai001A02` 1차 STT만으로는 재료가 부족할 수 있으므로, OneAI Voice Object rawResult 또는 별도 timestamp STT 결과가 확보될 때 후속으로 진행한다.

## 버린 선택지와 이유

### OneAI DB/GCS/ES 직접 접근

서비스 경계를 깨고 운영 결합도가 높아진다. OneAI 내부 저장 구조가 바뀌면 medical이 같이 깨진다. 1차는 API adapter로 충분하다.

### 1차부터 GCP Voice Object 전체 파이프라인 사용

장시간 음성, rawResult 보존, 재처리에는 좋지만 현재 Voice Note의 10분 이하 즉시 처리에는 무겁다. 파일 경로, 세션, ECM, Kafka, batch 상태까지 한 번에 맞춰야 한다.

### 1차부터 FE에 OneAI 상태 노출

FE 계약이 커지고 검증 범위가 늘어난다. 현재 FE는 jobId polling만 알면 되고, provider가 OpenAI인지 OneAI인지는 몰라도 된다.

## 재검토 조건

다음 조건 중 하나가 생기면 설계를 다시 본다.

- 10분 녹음에서 multipart STT timeout 또는 provider read timeout이 반복된다.
- 화자 timestamp, audio seek, 전문 검수 UX가 제품 요구로 확정된다.
- 서버 재시작 후 진행 중 Voice Note job 복구가 필요해진다.
- OneAI 크레딧 정책상 medical 서버 간 호출에 별도 인증/과금 흐름이 필요하다.
- OneAI가 Voice Note 전용 rich STT result API를 제공한다.

## 관련 문서

- [[Voice to EMR 경과기록지 구현 절차]]
- [[Voice to EMR 경과기록지 1차 PoC 의사결정]]
