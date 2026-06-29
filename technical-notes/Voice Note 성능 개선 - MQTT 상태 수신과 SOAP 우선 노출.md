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

## 코드 기준

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

### audio seek

전문 문장을 클릭하면 녹음 위치로 이동하는 audio seek는 여전히 후속 기능이다. 이 기능을 하려면 segment timestamp 또는 rawResult 기반 word offset이 안정적으로 필요하다.

## 관련 문서

- [[OneAI Voice Note Provider 전환 분석]]
- [[Voice to EMR 경과기록지 구현 절차]]
