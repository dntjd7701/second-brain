---
date: 2026-06-02
type: failure
tags:
  - emr
  - database
  - history-audit
---

# MD_PRSC 히스토리 스키마 불일치

## 증상

처방 저장 중 `MD_PRSC` INSERT 경로에서 다음 형태의 DB 예외가 발생할 수 있다.

```text
SQLSyntaxErrorException: Unknown column 'MRI_RESN' in 'NEW'
mapperId: ...IPrescriptionMapper.insertPrsc
callStack: HistoryAuditInterceptor.intercept -> PrescriptionService.insertMdPrsc -> insertPrsc
```

스택에 `HistoryAuditInterceptor`가 보여도, interceptor가 직접 실패 원인이라고 단정하지 않는다. INSERT/UPDATE/DELETE를 감싼 감사 로직 또는 DB 트리거가 원본 테이블의 `NEW.<COLUMN>` 값을 참조하는 과정에서 원본/히스토리/트리거의 DDL 버전이 어긋나면 같은 형태로 터질 수 있다.

## 확인된 원인 구조

`MD_PRSC`는 처방 본 테이블이고, 히스토리 저장 대상에 포함되어 있다. 처방 INSERT SQL은 명시 컬럼 목록으로 저장하며, MRI 촬영 사유 본문은 별도 MRI 사유 테이블에 저장되는 흐름을 가진다.

이 계열 오류의 핵심은 요청 파라미터에 `mriResn` 값이 있느냐가 아니라, DB 객체들이 같은 컬럼 세트를 공유하는지다.

- 원본 테이블에 특정 컬럼이 없는데 트리거가 `NEW.MRI_RESN`을 참조하면 `Unknown column ... in 'NEW'`가 난다.
- 원본 테이블에는 컬럼이 있는데 히스토리 테이블 또는 트리거 생성 SQL이 오래된 컬럼 목록을 쓰면 히스토리 적재 단계에서 실패한다.
- `MD_PRSC`와 `MD_PRSC_H`가 모두 있어도 컬럼명, 순서, 누락 컬럼이 다르면 감사 로직이 의도와 다르게 동작할 수 있다.

## 디버깅 기준

먼저 실제 실행 DB에서 원본 테이블, 히스토리 테이블, 트리거 정의를 함께 확인한다.

```sql
SELECT TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = :emr_schema
  AND TABLE_NAME IN ('md_prsc', 'md_prsc_h')
  AND COLUMN_NAME IN ('MRI_RESN', 'LAST_LOG_DTS', 'LOG_FG', 'LOG_DTS')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT b.COLUMN_NAME, b.ORDINAL_POSITION AS base_pos, h.ORDINAL_POSITION AS hist_pos
FROM information_schema.COLUMNS b
LEFT JOIN information_schema.COLUMNS h
  ON h.TABLE_SCHEMA = b.TABLE_SCHEMA
 AND h.TABLE_NAME = 'md_prsc_h'
 AND h.COLUMN_NAME = b.COLUMN_NAME
WHERE b.TABLE_SCHEMA = :emr_schema
  AND b.TABLE_NAME = 'md_prsc'
  AND h.COLUMN_NAME IS NULL
ORDER BY b.ORDINAL_POSITION;

SELECT TRIGGER_SCHEMA, TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT
FROM information_schema.TRIGGERS
WHERE EVENT_OBJECT_SCHEMA = :emr_schema
  AND (
    LOWER(EVENT_OBJECT_TABLE) = 'md_prsc'
    OR ACTION_STATEMENT LIKE '%MRI_RESN%'
  );
```

MariaDB 환경에서는 테이블명이 `MD_PRSC`로 작성되어도 `information_schema`에서 `md_prsc`처럼 소문자로 보일 수 있다. 컬럼/트리거 조회 시 대소문자 때문에 빈 결과가 나오지 않도록 `LOWER(EVENT_OBJECT_TABLE)` 또는 실제 표시명을 확인한다.

## 재발 방지 전략

- 원본 테이블에 컬럼을 추가하거나 제거할 때 `_H` 히스토리 테이블과 트리거 생성 SQL도 같은 패치 단위로 검증한다.
- `HistoryTarget`에 테이블을 추가할 때는 본 테이블만 보지 말고 히스토리 테이블의 컬럼 세트까지 비교한다.
- 장애 로그에서 `NEW.<COLUMN>`이 보이면 요청 JSON 필드보다 DB 트리거/감사 SQL의 컬럼 참조를 먼저 의심한다.
- 배포 전 패치 검증에 원본/히스토리 테이블 컬럼 diff 쿼리를 포함한다.

## 관련 코드

- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-medical/src/main/java/com/amaranth10/common/mybatis/interceptor/HistoryAuditInterceptor.java`
- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-medical/src/main/java/com/amaranth10/hospital/common/history/HistoryTarget.java`
- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-medical/src/main/java/com/amaranth10/hospital/common/prescription/query/common/PrescriptionQuery.xml`
- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-medical/src/main/java/com/amaranth10/hospital/common/prescription/service/impl/PrescriptionService.java`
