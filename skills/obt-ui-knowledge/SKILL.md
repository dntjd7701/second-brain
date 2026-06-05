---
name: obt-ui-knowledge
description: LUNA ORBIT(OBT) 프레임워크의 React UI 컴포넌트 명세서. 사용자가 OBT 컴포넌트(OBTDataGrid, OBTButton 등) 사용/수정을 요청하면 코드를 작성하기 전에 반드시 이 스킬을 조회하세요. 컴포넌트별 Props, Methods, Referenced Types 인터페이스와 정확한 npm Import 경로를 제공하여 API 환각(Hallucination)을 방지합니다.
---

# LUNA ORBIT UI Knowledge Base

이 프로젝트는 OBT 기반의 오픈 프레임워크 컴포넌트를 사용합니다. 특정 컴포넌트를 사용하거나 수정해야 한다면 다음 규칙을 따라 문서 창고를 조회하십시오.

## 지식 창고 접근 방법
1. `./docs/index.md` 파일을 확인하여 현재 사용 가능한 컴포넌트 리스트와 설명을 조회합니다.
2. 컴포넌트의 상세 사용법(API)이 필요하다면 `./docs/[컴포넌트명].md` (예: `./docs/OBTDataGrid.md`) 를 읽어들입니다.

## 코딩 규칙
- 컴포넌트 명세(마크다운 내 TypeScript 인터페이스 코드블록)에 정의된 `Props` 타입과 `Methods` 시그니처를 절대적으로 준수해야 합니다.
- `@default` 태그가 있는 속성은 해당 기본값을 인지하여 불필요한 속성 주입을 방지하세요.
- 각 속성에 명시된 주석(JSDoc)을 참고하여 이벤트 핸들러 및 데이터 바인딩을 구현하세요.
[OBTAccordion2.md](docs/OBTAccordion2.md)