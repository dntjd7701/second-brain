# Voice Note 성능 개선 - MQTT 상태 수신과 SOAP 우선 노출

## 배경

OneAI Voice Note 전환 후 사용자가 실제 화면에서 체감한 1차 완료 시간은 약 44초였다. 이 시간에는 STT 자체 처리 시간뿐 아니라 FE가 STT 완료를 감지하는 시간, SOAP 생성, 전문/화자 역할 처리, 화면 표시 순서가 모두 섞여 있었다.

이번 개선의 목적은 AI 품질 자체를 바꾸는 것이 아니라, 이미 완료된 작업을 더 빨리 감지하고 사용자가 가장 먼저 필요한 SOAP 초안을 먼저 보여주는 것이다.

## 기존 문제

기존 흐름은 STT 상태를 2초 간격 polling으로 확인했다. 이 방식은 구현은 단순하지만 다음 문제가 있었다.

- OneAI 처리가 완료되어도 다음 polling 주기까지 FE가 완료 사실을 모른다.
- 완료 여부를 확인하기 위해 status API를 반복 호출하므로 불필요한 요청이 생긴다.
- SOAP 결과와 전문/화자 역할 처리를 한 흐름에서 기다리면 SOAP 초안 노출이 늦어진다.
- 사용자 입장에서는 우선 SOAP 초안을 보고 싶은데, 검토용 전문 영역까지 같이 준비될 때까지 기다리는 것처럼 보인다.

## 처리한 내용

### MQTT 상태 수신을 기본 경로로 변경

`startStt` 응답에서 받은 `voiceUid`, `mqttTopic`을 기준으로 FE가 MQTT topic을 구독한다. STT 완료 이벤트가 오면 그 시점에 result API를 조회한다.

현재 Voice Note에서는 `MqttService.js`에 전용 유틸을 추가하지 않고, `VoiceNoteDialog` 안에서 `commonGwUtil.mqttManager`를 직접 사용한다. Voice Note 전용 흐름이므로 화면 컴포넌트 안에서 구독, 이벤트 검증, 해제를 한 곳에서 추적하기 위함이다.

이벤트는 아래 조건을 만족할 때만 현재 녹음의 완료 이벤트로 본다.

```text
payload.type = 902
payload.subType = 001
payload.data.uid = 현재 voiceUid
```

MQTT 구독에 실패하면 polling으로 조용히 우회하지 않고 에러로 처리한다. 이번 목적이 MQTT 경로 검증과 polling 부하 제거이기 때문에, 구독 실패를 숨기면 실제 문제가 다시 보이지 않게 된다.

### timeout 시 status 1회 조회만 수행

MQTT는 이벤트 기반이라 빠르지만, 브라우저 구독 실패, 네트워크 순간 끊김, 이벤트 유실 같은 예외 가능성이 있다. 그래서 timeout 시점에는 status API를 1회만 조회한다.

```text
MQTT 이벤트 수신
-> result 조회
-> PROCESSING이면 다음 MQTT 이벤트 대기

MQTT timeout
-> status 1회 조회
-> COMPLETED이면 result 조회
-> 그 외 상태면 timeout/실패 처리
```

반복 polling으로 되돌아가지 않는 것이 핵심이다. timeout 보정은 사용자에게 무한 대기를 만들지 않기 위한 안전장치이고, 정상 경로는 MQTT 이벤트 수신이다.

### SOAP 우선 노출, 전문/화자 역할은 후속 처리

화면에서는 사용자에게 가장 먼저 필요한 SOAP 초안을 먼저 노출한다. 전문 및 화자 구분은 검토용 정보이므로 SOAP 표시 이후 백그라운드 처리 또는 전문보기 시점 처리로 분리한다.

이렇게 하면 전체 STT/LLM 파이프라인이 모두 끝날 때까지 기다리는 느낌을 줄이고, 사용자는 SOAP 결과를 먼저 확인할 수 있다.

### 단계별 로그 추가

FE console에는 테스트 시점에서 흐름을 추적할 수 있도록 단계별 로그를 남긴다.

- 음성 파일 처리 시작
- STT job 생성 요청/완료
- MQTT 구독 준비/완료/실패
- MQTT 이벤트 대기 시작/수신/timeout
- 이벤트 후 result 조회 시작/완료
- timeout 후 status 1회 조회 시작/완료
- SOAP 표시와 전문/화자 처리 단계
- 전체 소요 시간

## 결과

사용자 로컬 테스트 기준으로 기존 약 44초였던 완료 시간이 약 30초로 줄었다.

```text
기존: 약 44초
개선 후: 약 30초
단축: 약 14초
감소율: 약 32%
```

이 개선은 STT 모델 자체의 속도를 바꾼 결과라기보다, 완료 감지 방식과 화면 노출 순서를 바꾼 결과다. 특히 polling 주기 대기와 전문/화자 역할 처리 대기를 줄인 것이 체감 시간 감소에 직접적인 영향을 줬다.

## 2차 개선 (SOAP 완전 비동기 분리 · 전용 RestTemplate · 2026-06-30)

1차 개선에서 "SOAP 우선 노출, 전문/화자 후속"으로 분리했지만, SOAP 생성 자체는 여전히 `getResult`(STT 결과 조회) 응답 안에서 **동기로 LLM을 호출**하고 있었다. 즉 사용자는 `STT 완료 감지 + SOAP LLM 생성`을 한 번에 기다린 뒤에야 화면을 봤다. 화자 역할만 deferred였고 SOAP는 critical path에 남아 있던 것이다.

### SOAP를 STT 결과 응답에서 완전히 분리

`getResult` 응답에서 SOAP LLM 동기 호출을 제거하고, `llmResult.status = PENDING`만 내려준다(BE `OneAiVoiceNoteService.buildDeferredSoapLlmResult`). FE는 전사문이 표시된 직후 기존 `/soap` 엔드포인트를 백그라운드로 1회 자동 호출해 SOAP를 채운다. 화자 역할 deferred와 정확히 같은 패턴이고, `/soap`(`regenerateSoap`)는 이미 존재하던 엔드포인트라 FE 변경 비용도 작았다.

결과적으로 전사문은 즉시 노출되고 SOAP는 스피너로 뒤따른다. 긴 진료 대화일수록 LLM 생성 시간이 체감 지연에서 빠진다.

주의: SOAP와 화자 역할이 둘 다 백그라운드로 동시에 OneAI LLM을 호출하므로, FE에서 `llmResult` 병합을 **함수형 setState**(최신 state 기준)로 바꿔야 한다. 캡처한 previousLlmResult로 병합하면 늦게 끝난 호출이 먼저 끝난 호출의 필드(예: segmentRoles)를 덮어쓰는 race가 생긴다.

### Voice Note 전용 RestTemplate 타임아웃

ECM 업로드·OneAI STT·LLM 호출이 공용 `RestTemplate` 빈(read timeout 30s, 원래 의뢰회송용으로 임시 상향된 값)을 공유하고 있었다. 긴 전사문의 SOAP 생성이 30s를 넘으면 그대로 실패한다.

전용 빈 `oneAiVoiceNoteRestTemplate`(connect 10s / read 120s)을 신설하고, 기존 공용 빈에 `@Primary`를 부여해 다른 주입부를 보호한 뒤, `OneAiVoiceNoteApiClient`를 `@RequiredArgsConstructor` 대신 명시적 생성자 + `@Qualifier`로 전용 빈을 주입하도록 바꿨다.

### 버린 선택지 - cleanup 비동기화 / 중복 detail 호출 제거

`getResult` 비-script 경로에서 cleanup용 `getSttDetail`을 한 번 더 호출하는 것이 중복으로 보여 제거를 검토했으나 버렸다.

- 비-script 경로는 `requestStt`가 항상 `manageType=L`로 요청하므로 실사용에서 거의 도달하지 않는다.
- 그 재조회는 버그가 아니라 의도된 것이다. 1차 detail 시점의 status는 아직 PROCESSING일 수 있고, cleanup은 terminal 상태에서만 동작하므로 COMPLETED 확정 후 다시 조회해야 삭제가 실제로 트리거된다. 재사용으로 바꾸면 오히려 cleanup 스킵 버그가 된다.
- cleanup을 `@Async`로 빼는 것도 검토했으나, ECM delete 호출이 `BaseInfoContext`/`RequestInfo`(인증 서명)에 의존하는데 요청 스레드 밖에서의 유효성 검증이 필요하다. 줄어드는 시간은 ECM delete 1회뿐이라 정합성 리스크 대비 이득이 작아 하지 않았다.

판단 기준: "중복처럼 보이는 호출"이라도 terminal 상태 확정 같은 **시점 의존성**이 있으면 제거 전에 그 의도를 먼저 확인한다. SOAP 비동기 분리만으로 critical path의 큰 덩어리(LLM 대기)가 이미 빠지므로, 남은 수십~수백 ms를 위해 스레드/컨텍스트 리스크를 떠안지 않는다.

### 함께 정리한 죽은 코드

SOAP 분리로 미사용이 된 `requestLlmResult`, 그리고 SOAP/화자 분리 리팩터 이후 호출처가 사라진 `resolveLlmStatus`·`resolveLlmMessage`·`addMessage`를 제거하고, `extractResultData`의 도달 불가 null 분기를 단순화했다.

## 코드 기준

- BE 서비스: `3.Boot/amaranth10-medical/.../oneai/voiceNote/service/OneAiVoiceNoteService.java`
- BE API client / RestTemplate 주입: `.../oneai/voiceNote/service/OneAiVoiceNoteApiClient.java`, `config/WebConfig.java`
- FE Voice Note dialog: `common/klago-ui-hospital-common/src/components/VoiceNote/VoiceNoteDialog.js`
- FE Voice Note API wrapper: `common/klago-ui-hospital-common/src/components/VoiceNote/VoiceNoteService.js`
- MEDA0010 연결부: `packages/klago-ui-medical-micro/src/app/components/MED/MEDA/MEDA0000/MEDA0010/MEDA0010.js`

## 재사용 기준

외부 provider가 비동기 작업 완료 이벤트를 발행하고, FE가 해당 topic을 받을 수 있다면 반복 polling보다 MQTT 수신을 기본 경로로 두는 것이 낫다.

다만 다음 원칙은 유지한다.

- MQTT 구독 실패는 에러로 드러낸다.
- timeout 보정은 status 1회 조회 정도로 제한한다.
- 완료 이벤트는 현재 작업 식별자와 반드시 매칭한다.
- 사용자가 먼저 봐야 하는 결과와 검토용 부가 결과를 분리한다.
- 장기 보관이 필요한 실패/재시도 정책은 별도 설계로 남긴다.

## 남은 고민

### polling 지연을 완전히 없앨 수 있는가

MQTT 경로가 정상이라면 반복 polling은 제거할 수 있다. 다만 이벤트 유실 가능성을 완전히 0으로 볼 수 없으므로 timeout 시 status 1회 조회는 남긴다. 추후 운영 데이터에서 MQTT 이벤트 유실이 거의 없다는 것이 확인되면 timeout 정책을 더 짧게 가져갈 수 있다.

### 실패 시 재시도와 ECM cleanup

현재는 STT/LLM 흐름 중 실패하면 사용자가 다시 녹음해야 하는 상황이 생길 수 있다. 특히 ECM 업로드 후 OneAI 처리에서 실패하면 업로드된 파일을 즉시 cleanup할지, 일정 시간 보관해 재시도를 허용할지 결정이 필요하다.

### 전문/화자 처리 시점

SOAP를 먼저 보여주는 방향은 맞지만, 전문보기 버튼 클릭 시점에 화자 역할을 생성할지, SOAP 이후 백그라운드로 미리 생성해 둘지는 UX와 비용을 함께 봐야 한다. 빠른 화면 반응이 우선이면 백그라운드가 유리하고, LLM 호출 비용 절감이 우선이면 전문보기 시점 생성이 유리하다.

2차 개선에서는 빠른 화면 반응을 우선해 SOAP와 화자 역할을 둘 다 preview 직후 백그라운드 생성으로 정했다. 다만 이 경우 SOAP+화자 역할 LLM 호출이 **녹음 1건당 2회 동시** 발생하므로, OneAI 측 동시 요청 제한과 비용을 운영 데이터로 확인할 필요가 있다. 비용이 문제가 되면 화자 역할만 전문보기 시점 생성으로 되돌리는 것이 현실적이다.

### audio seek

전문 문장을 클릭하면 녹음 위치로 이동하는 audio seek는 여전히 후속 기능이다. 이 기능을 하려면 segment timestamp 또는 rawResult 기반 word offset이 안정적으로 필요하다.

## 관련 문서

- [[OneAI Voice Note Provider 전환 분석]]
- [[Voice to EMR 경과기록지 구현 절차]]
