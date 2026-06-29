# OneAI Voice Note Provider 전환 분석

## 배경

Voice Note 1차 PoC는 `amaranth10-medical`에서 OpenAI STT와 SOAP LLM을 직접 호출하는 구조로 구현했다. 이 구조는 빠르게 업무 흐름을 검증하기에는 좋지만, 운영 기준에서는 회사 내부 AI gateway인 OneAI를 통해 STT와 LLM을 호출해야 할 가능성이 있다.

이번 분석의 목적은 OneAI를 붙일 수 있는지, 붙인다면 어디까지 기존 Voice Note 계약을 유지할 수 있는지 판단하는 것이다. 핵심 결론은 다음이다.

```text
현재 전환은 medical BE adapter에서 ECM 업로드와 OneAI Voice Object STT를 호출한다.
FE는 voiceUid/mqttTopic으로 MQTT 완료 이벤트를 수신하고, timeout 시 status API를 1회만 확인한다.
SOAP 생성은 OneAI oai001A04 동기 LLM 호출을 사용한다.
품질 gate와 SOAP JSON 검증은 medical이 책임진다.
```

초기 분석에서는 `oai001A02` multipart STT를 1차 후보로 봤지만, 이후 STT 요청 규격과 실제 연동 테스트를 거치며 ECM 파일 업로드와 OneAI Voice Object 기반 흐름으로 방향이 바뀌었다. 아래의 multipart STT 내용은 초기 후보 검토 기록이고, 현재 구현 기준은 Voice Object 흐름이다.

## 현재 Voice Note 구조

현재 Voice Note는 FE가 녹음 blob을 medical BE로 전송하고, BE가 ECM 업로드와 OneAI STT 요청을 시작한다. FE는 `voiceUid`, `mqttTopic`을 받아 MQTT 완료 이벤트를 기다리고, timeout 시 status API를 1회만 확인한다.

```text
FE 녹음 Blob
-> medical BE OneAiVoiceNoteService 시작 요청
-> ECM 임시 음성 파일 업로드
-> OneAI Voice Object STT 요청
-> FE MQTT 완료 이벤트 수신
-> STT result 조회
-> SOAP 우선 표시
-> 전문/화자 구분 후속 처리
```

이 구조에서는 브라우저가 긴 HTTP 요청 하나를 계속 붙잡지 않는다. STT 완료 감지는 MQTT 이벤트를 기본 경로로 두고, 이벤트 유실이나 timeout 상황에서만 status API를 1회 확인한다.

## OneAI STT 선택지

### 초기 후보: oai001A02 multipart STT

`oai001A02`는 음성 파일을 multipart `content`로 받아 STT provider에 전달한다. 초기에는 현재 Voice Note가 브라우저 녹음 blob을 multipart로 보내고 있었기 때문에 1차 전환 후보로 가장 가깝다고 봤다.

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
- FE에 OneAI 내부 `operationId`까지 노출하면 1차 범위가 커진다. 다만 현재 구현에서는 MQTT 완료 수신을 위해 `voiceUid`, `mqttTopic`은 FE 계약에 포함한다.

초기에는 `oai001A02`를 1차로 보고 아래 조건이 생기면 Voice Object 흐름을 재검토하려 했다. 현재는 STT 요청 규격과 ECM 파일 업로드 요구가 확인되어 Voice Object 흐름을 사용한다.

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

초기 후보였던 `oai001A02`는 음성 길이와 `WHISPER` credit 기준으로 사전 quota를 확인하고, 성공 후 사용량 통계를 기록한다. 현재 Voice Object STT 경로도 OneAI quota/통계 정책과 연결될 수 있으므로 실제 차단과 기록/차감은 개발 환경에서 별도로 확인한다. `oai001A04` 같은 LLM API는 `@AiCalculate` aspect가 사전 quota check를 수행한다.

따라서 개발 테스트에서는 두 가지를 분리해서 확인해야 한다.

- 차단: `checkQuota()`가 요청을 막는지
- 기록/차감: `createStat()` 이후 사용량이 어떻게 남고, WEHAGO 계열 고객사에서 외부 차감 API가 타는지

## 단계적 구현 계획

### Phase 1. medical oneai 패키지 정리

`amaranth10-medical`의 `hospital.common.oneai.voiceNote` 패키지에서 Voice Note 전용 adapter, controller, service, DTO 경계를 명시한다. OpenAI 직접 호출 코드는 제거하고 OneAI/ECM 연동만 남긴다.

### Phase 2. OneAI Voice Object STT

FE 녹음 blob을 medical로 받고, medical에서 ECM 임시 음성 파일 업로드 후 OneAI Voice Object STT를 요청한다. FE에는 `voiceUid`, `mqttTopic`을 반환하고 MQTT 완료 이벤트 수신 후 result API를 조회한다. timeout 시에만 status API를 1회 조회한다.

### Phase 3. OneAI SOAP

STT transcript를 기준으로 `oai001A04`를 호출한다. 기존 prompt를 messages로 구성하고, 응답 JSON을 medical에서 검증한다. SOAP는 먼저 화면에 노출하고, 전문/화자 구분은 후속 처리한다.

### Phase 4. 로그와 단계별 재시도

provider, 단계, 처리 시간, transcript 길이, 실패 원인을 남긴다. STT 성공 후 SOAP가 실패하면 STT를 다시 호출하지 않고 SOAP만 재시도할 수 있게 한다.

2026-06-17 개발 테스트에서 OneAI voice object 상태가 `FAILED`로 조회되자 medical이 `cleanupEcmAudioIfTerminal(..., reason=status)` 경로로 ECM 음성 문서를 즉시 삭제하는 흐름을 확인했다. 이 경우 사용자는 녹음 파일을 다시 전송하거나 같은 ECM 문서로 STT를 재시도할 수 없다.

현재 동작은 임시 파일 누적을 막는 장점이 있지만, 실패 시 복구성이 낮다. 기능 구현이 끝난 뒤 다음 정책을 별도 작업으로 재검토한다.

- FE는 마지막 녹음 blob을 세션 내에서 일시 보관하고, 전송 실패 시 같은 blob으로 재시도할 수 있게 한다.
- BE는 ECM 업로드 성공 후 OneAI 처리 실패가 발생했을 때 즉시 삭제할지, TTL 기반 보관 후 재시도를 허용할지 결정한다.
- STT 실패와 LLM 실패를 분리한다. STT 성공 후 SOAP/화자 분류만 실패한 경우에는 음성 파일을 다시 쓰지 않고 transcript 기준으로 LLM만 재시도한다.
- cleanup 로그에는 `reason`, `status`, `voiceUid`, `docUid count`를 남기되, 사용자 화면에는 기술 식별자를 그대로 노출하지 않는다.

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

이 기능은 `speakerSegments.start/end` 또는 word offset이 필요하다. 현재 Voice Object rawResult 또는 별도 timestamp STT 결과가 안정적으로 확보될 때 후속으로 진행한다.

## 버린 선택지와 이유

### OneAI DB/GCS/ES 직접 접근

Voice Object 흐름은 현재 사용하지만, medical이 OneAI 내부 DB, GCS, Elasticsearch를 직접 만지는 방식은 선택하지 않는다. 서비스 경계를 깨고 운영 결합도가 높아지기 때문이다. medical은 ECM 업로드와 OneAI 공개 API 호출, 상태 수신, 사용자용 결과 정리에 집중한다.

### 1차부터 FE에 OneAI 상태 노출

FE 계약이 커지고 검증 범위가 늘어난다. 현재 FE에는 MQTT 상태 수신에 필요한 `voiceUid`, `mqttTopic`까지만 노출하고, OneAI 내부 `operationId`, GCS 경로, rawResult 저장 구조는 숨긴다.


## 2026-06-29 MQTT 상태 수신과 SOAP 우선 노출 개선

정리 문서: [[Voice Note 성능 개선 - MQTT 상태 수신과 SOAP 우선 노출]]

OneAI Voice Note 실제 테스트에서 기존 완료 시간이 약 44초였고, MQTT 상태 수신과 SOAP 우선 노출 적용 후 약 30초로 줄었다. 약 14초 단축이며, 비율로는 약 32% 감소다.

이번 개선은 STT provider 품질이나 모델 속도를 바꾼 것이 아니라 완료 감지와 화면 노출 순서를 바꾼 것이다.

```text
기존: 2초 polling으로 STT 상태 확인 + SOAP/전문/화자 처리 대기
변경: MQTT 완료 이벤트 수신 + timeout 시 status 1회 조회 + SOAP 우선 노출
```

현재 FE 계약은 `voiceUid`, `mqttTopic`을 받아 MQTT topic을 구독하는 구조다. MQTT 구독 실패는 polling fallback으로 숨기지 않고 에러 처리한다. 정상 경로에서는 MQTT 이벤트 수신 후 result API를 조회하고, timeout 시에만 status API를 1회 조회한다.

전문 및 화자 구분은 SOAP 초안 노출 이후 후속 처리한다. 사용자가 먼저 검토해야 하는 산출물은 SOAP 초안이고, 전문/화자 구분은 검토 보조 정보이기 때문이다.

## 타 모듈 확인 요청 항목

아래 항목은 `amaranth10-medical`에서 임의로 해결하지 않고 OneAI 또는 ECM 모듈의 API 계약으로 확인해야 한다. medical은 호출 로그와 사용자용 오류 분리, 재시도 UX만 담당한다.

### OneAI voice object 실패 원인

현재 `oai011A03` 상태 조회에서 `status=FAILED`만 확인되고, 실패 원인은 `failureMessage=null`로 내려올 수 있다. medical 로그에는 `voiceUid`, `manageType`, `voiceObjectKeys`, `resourceKeys`, `apiPath`까지 남길 수 있지만 실제 실패 사유는 OneAI 내부 처리 결과가 내려와야 알 수 있다.

OneAI 쪽에 확인할 내용은 다음이다.

- Google STT, Kafka consumer, GCS upload/output parse, Elasticsearch 저장 실패 중 어느 단계에서 실패했는지 반환 가능한지
- 실패 메시지 또는 실패 코드를 `oai011A03` 응답에 안정적으로 포함할 수 있는지
- `resources.fileInfo`, `rawResult`, provider raw error 같은 디버깅 필드를 운영 로그 또는 개발 응답에 노출할 수 있는지
- `manageType=L` 화자 구분 요청에서 추가로 필요한 옵션이나 제한이 있는지

### OneAI LLM API 계약

SOAP와 발화 역할 분류는 prompt 기반 JSON 생성이 필요하다. 개발 테스트에서는 `oai001A16`에서 `resultCode=29040`, `Failed to receive module data.`가 발생했고, prompt 기반 동기 생성은 `oai001A04`를 우선 후보로 본다.

OneAI 쪽에 확인할 내용은 다음이다.

- 의료 경과기록 SOAP JSON 생성에 권장되는 API와 모델
- JSON schema strict 또는 구조화 출력에 준하는 옵션 제공 여부
- prompt, model, input/messages 필드의 정식 요청 구조
- 실패 시 사용자에게 보여줄 메시지와 개발 로그용 상세 메시지를 분리해서 받을 수 있는지

### ECM 임시 음성 파일 정책

Voice Note는 ECM에 음성 파일을 업로드한 뒤 OneAI voice object가 해당 파일을 처리한다. 현재 medical은 terminal 상태에서 cleanup을 수행할 수 있지만, 실패 직후 바로 삭제하면 같은 음성 파일로 STT를 재시도할 수 없다.

ECM 쪽에 확인할 내용은 다음이다.

- `uploadFolderType=voice`로 업로드한 파일의 권장 보관 정책과 TTL
- OneAI 처리 실패 후 medical이 즉시 삭제해야 하는지, 일정 시간 재시도를 위해 남겨도 되는지
- 삭제 API가 멱등적으로 동작하는지
- 개발/운영 로그에서 docUid 외에 파일 처리 실패 원인을 추적할 수 있는지

## 재검토 조건

다음 조건 중 하나가 생기면 설계를 다시 본다.

- 10분 녹음에서 multipart STT timeout 또는 provider read timeout이 반복된다.
- 화자 timestamp, audio seek, 전문 검수 UX가 제품 요구로 확정된다.
- 서버 재시작 후 진행 중 Voice Note job 복구가 필요해진다.
- STT 실패 시 녹음 파일 재시도 UX 또는 ECM 임시 파일 TTL 보관 정책이 필요해진다.
- OneAI 크레딧 정책상 medical 서버 간 호출에 별도 인증/과금 흐름이 필요하다.
- OneAI가 Voice Note 전용 rich STT result API를 제공한다.

## 관련 문서

- [[Voice to EMR 경과기록지 구현 절차]]
- [[Voice to EMR 경과기록지 1차 PoC 의사결정]]
