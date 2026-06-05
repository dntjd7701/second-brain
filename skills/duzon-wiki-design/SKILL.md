---
name: duzon-wiki-design
description: Duzon Confluence 위키 문서를 HisPageHeader 페이지처럼 읽기 쉬운 카드형 디자인과 Confluence storage format으로 작성한다.
---

# Duzon Wiki Design

## Purpose

Use this skill when writing or updating Duzon Confluence wiki pages and the user wants a polished, readable page design. This skill captures the visual pattern observed from the `HisPageHeader` wiki page: a strong summary block, compact label typography, colored callout cards, two-column before/after examples, and scannable FAQ sections.

## When To Use

- 사용자가 위키, Confluence, 사내 Wiki 문서 작성을 요청할 때
- 기존 기술 문서를 더 보기 좋게 정리해 달라고 할 때
- `wiki_create_child_page`, `wiki_update_page`에 넣을 Confluence storage format HTML을 작성할 때
- 컴포넌트 가이드, 마이그레이션 가이드, FAQ, 사용 예시 문서를 만들 때

## Design Principles

- 문서 첫 화면에서 무엇을 설명하는지 바로 보이게 한다.
- 기능 문서는 랜딩 페이지처럼 꾸미지 말고, 읽기와 복사 가능한 예제를 우선한다.
- 큰 제목만 나열하지 말고, 요약 카드와 상태 배지를 먼저 배치한다.
- 같은 종류의 정보는 같은 카드 패턴으로 반복한다.
- 색상은 의미를 가진다. 장식용 색상 남발보다 정보 구분을 우선한다.
- Confluence storage format에서 깨지기 쉬운 복잡한 CSS보다 인라인 스타일 기반의 단순한 블록을 쓴다.

## Page Structure

Recommended order:

1. Hero summary card
2. TOC
3. Quick start or minimum setup
4. Concept or prop overview cards
5. Scenario sections
6. Before/after code comparison
7. Detailed API tables
8. FAQ cards
9. Related components or links

## Visual System

Use these values as defaults:

- Page accent blue: `rgb(30,64,175)`, `rgb(37,99,235)`, `rgb(239,246,255)`
- Neutral border: `rgb(226,232,240)`
- Muted text: `rgb(71,85,105)`, `rgb(100,116,139)`
- Body text: `rgb(31,41,55)`, `rgb(51,65,85)`
- Success: `rgb(240,253,244)`, `rgb(22,163,74)`, `rgb(22,101,52)`
- Warning: `rgb(254,252,232)`, `rgb(202,138,4)`, `rgb(120,53,15)`
- Danger: `rgb(254,242,242)`, `rgb(220,38,38)`, `rgb(153,27,27)`
- Info: `rgb(239,246,255)`, `rgb(37,99,235)`, `rgb(30,64,175)`
- Purple detail: `rgb(253,244,255)`, `rgb(162,28,175)`

Spacing and shape:

- Hero card: `border-radius: 12px; padding: 24px; margin-bottom: 24px`
- Normal card: `border-radius: 8px` or `10px`; `padding: 12px` to `18px`
- Callout left border: `border-left: 4px solid ...`
- Labels: `font-size: 11px; font-weight: bold; letter-spacing: 0.5px` or `1px`
- Body text in cards: `font-size: 12px` to `13px`; `line-height: 1.6` for explanatory paragraphs

## Component Patterns

### Hero Summary Card

Use this at the top of a page. Keep the title, one-sentence summary, status badges, compact metadata cards, and TOC in one bordered block.

```html
<div style="border-radius: 12px;padding: 24px;margin-bottom: 24px;border: 1px solid rgb(191,219,254);">
  <p style="font-size: 24px;font-weight: bold;color: rgb(30,64,175);margin: 0 0 8px 0;">PageTitle</p>
  <p style="font-size: 14px;color: rgb(71,85,105);margin: 0 0 12px 0;">한 문장으로 역할과 범위를 설명한다.</p>
  <p style="margin: 0 0 18px 0;">
    <span style="display: inline-block;background: rgb(220,38,38);color: rgb(255,255,255);padding: 3px 10px;border-radius: 12px;font-size: 11px;font-weight: 600;margin-right: 6px;">DEPRECATED 대체</span>
    <span style="display: inline-block;background: rgb(255,255,255);color: rgb(30,64,175);padding: 3px 10px;border-radius: 12px;font-size: 11px;font-weight: 600;border: 1px solid rgb(191,219,254);">Before -> After</span>
  </p>
  <div style="background: rgb(240,253,244);border-left: 4px solid rgb(22,163,74);border-radius: 8px;padding: 12px 14px;margin-bottom: 8px;">
    <p style="font-size: 11px;font-weight: bold;color: rgb(22,163,74);margin: 0 0 4px 0;letter-spacing: 0.5px;">위치</p>
    <p style="margin: 0;font-size: 12px;color: rgb(31,41,55);">src/components/Example/Example.js</p>
  </div>
  <div style="border-top: 1px dashed rgb(203,213,225);padding-top: 16px;">
    <p style="font-size: 11px;font-weight: bold;color: rgb(100,116,139);margin: 0 0 8px 0;letter-spacing: 1px;">목차</p>
    <ac:structured-macro ac:name="toc" ac:schema-version="1"><ac:parameter ac:name="maxLevel">3</ac:parameter><ac:parameter ac:name="style">disc</ac:parameter></ac:structured-macro>
  </div>
</div>
```

### Callout Card

Use callouts for key behavior, data flow, warnings, migration notes, or mental models. Put a short bold title first and one clear paragraph or list after it.

```html
<div style="background: rgb(239,246,255);border-left: 4px solid rgb(37,99,235);border-radius: 8px;padding: 14px;margin: 12px 0;">
  <p style="font-weight: bold;color: rgb(30,64,175);margin: 0 0 6px 0;">핵심 규칙</p>
  <p style="margin: 0;font-size: 13px;color: rgb(30,58,138);line-height: 1.6;">중요한 동작을 한 문단으로 설명한다.</p>
</div>
```

### Quick Start Card

Use this directly after the TOC for the minimum working code path.

```html
<div style="background: rgb(248,250,252);border: 1px solid rgb(226,232,240);border-radius: 10px;padding: 18px;margin: 12px 0;">
  <p style="font-size: 11px;font-weight: bold;color: rgb(100,116,139);margin: 0 0 10px 0;letter-spacing: 1px;">MINIMUM SETUP</p>
  <ac:structured-macro ac:name="code" ac:schema-version="1">
    <ac:parameter ac:name="language">javascript</ac:parameter>
    <ac:plain-text-body><![CDATA[
// shortest working example
]]></ac:plain-text-body>
  </ac:structured-macro>
  <p style="font-size: 13px;color: rgb(71,85,105);margin: 8px 0 0 0;">예제가 왜 최소 구성인지 한 줄로 설명한다.</p>
</div>
```

### Prop Or Concept Cards

Use stacked white cards for public API groups. The label color can vary by category, but the internal shape stays identical.

```html
<div style="background: rgb(255,255,255);border: 1px solid rgb(226,232,240);border-radius: 10px;padding: 14px;">
  <p style="font-size: 11px;font-weight: bold;color: rgb(59,130,246);margin: 0 0 6px 0;letter-spacing: 0.5px;">propName <span style="font-weight: 400;color: rgb(100,116,139);font-size: 10px;">object</span></p>
  <p style="margin: 0 0 4px 0;font-size: 13px;color: rgb(51,65,85);">역할을 한 문장으로 적는다.</p>
  <p style="margin: 0;font-size: 12px;color: rgb(100,116,139);">필드, 제약, 주의사항을 짧게 적는다.</p>
</div>
```

### Before And After Comparison

Use two equal layout cells for migration examples. Red is old/deprecated, green is current/recommended.

```html
<ac:layout>
  <ac:layout-section ac:type="two_equal">
    <ac:layout-cell>
      <div style="background: rgb(254,242,242);border: 1px solid rgb(254,202,202);border-radius: 8px;padding: 12px;">
        <p style="font-size: 11px;font-weight: bold;color: rgb(153,27,27);margin: 0 0 8px 0;letter-spacing: 0.5px;">기존</p>
        <ac:structured-macro ac:name="code" ac:schema-version="1"><ac:parameter ac:name="language">javascript</ac:parameter><ac:plain-text-body><![CDATA[
// before
]]></ac:plain-text-body></ac:structured-macro>
      </div>
    </ac:layout-cell>
    <ac:layout-cell>
      <div style="background: rgb(240,253,244);border: 1px solid rgb(187,247,208);border-radius: 8px;padding: 12px;">
        <p style="font-size: 11px;font-weight: bold;color: rgb(22,101,52);margin: 0 0 8px 0;letter-spacing: 0.5px;">현재</p>
        <ac:structured-macro ac:name="code" ac:schema-version="1"><ac:parameter ac:name="language">javascript</ac:parameter><ac:plain-text-body><![CDATA[
// after
]]></ac:plain-text-body></ac:structured-macro>
      </div>
    </ac:layout-cell>
  </ac:layout-section>
</ac:layout>
```

### FAQ Section

Use a light gray wrapper and repeated white cards. Keep each answer short and operational.

```html
<div style="background: rgb(250,250,250);border-radius: 10px;padding: 6px;margin: 12px 0;">
  <div style="background: rgb(255,255,255);border-radius: 8px;padding: 14px;margin: 6px;">
    <p style="margin: 0 0 6px 0;"><span style="display: inline-block;background: rgb(59,130,246);color: rgb(255,255,255);padding: 2px 8px;border-radius: 10px;font-size: 11px;font-weight: bold;margin-right: 6px;">Q</span><strong>질문을 적는다.</strong></p>
    <p style="margin: 0;color: rgb(71,85,105);font-size: 13px;">답변은 원인과 해결책 중심으로 짧게 적는다.</p>
  </div>
</div>
```

## Writing Rules

- Hero 제목은 페이지명 또는 컴포넌트명으로 둔다.
- Hero 요약은 "무엇을 통합/대체/제공하는지"를 한 문장으로 쓴다.
- 배지는 상태, 마이그레이션 방향, 중요 제약처럼 즉시 봐야 하는 정보에만 쓴다.
- 코드 예시는 실제 복사 가능한 형태를 우선한다.
- "기존"과 "현재" 비교는 한 섹션 안에서 같은 수준의 예제를 보여준다.
- 테이블은 상세 API에만 사용하고, 처음부터 테이블로 모든 것을 설명하지 않는다.
- FAQ는 사용자가 실제로 막힐 질문을 제목으로 쓴다.
- 문서의 색상 의미를 뒤섞지 않는다. deprecated나 위험은 red, 권장안은 green, 정보는 blue, 주의는 yellow를 사용한다.

## Confluence Storage Guidelines

- `wiki_update_page`와 `wiki_create_child_page`에는 Markdown이 아니라 Confluence storage format HTML을 넣는다.
- Code block은 `ac:structured-macro ac:name="code"`와 `ac:plain-text-body><![CDATA[...]]>`를 사용한다.
- TOC는 `ac:structured-macro ac:name="toc"`를 사용한다.
- 복잡한 외부 CSS class에 의존하지 말고 인라인 style을 사용한다.
- Emoji는 Confluence 렌더링과 사내 문서 톤에 따라 깨질 수 있으므로 기본적으로 쓰지 않는다.
- HTML 특수 문자는 필요 시 escape한다. 예: `&lt;`, `&gt;`, `&amp;`, `&mdash;`

## Quality Checklist

Before publishing:

- 첫 화면에서 페이지 목적, 상태, 핵심 위치를 알 수 있는가?
- TOC가 있고 heading level이 3단계 안에서 정리되는가?
- Quick start가 실제 최소 사용 예시인가?
- Red/green before-after 비교가 같은 주제를 비교하는가?
- 콜아웃 색상이 의미와 맞는가?
- 카드 안 문장이 길어져 읽기 어려워지지 않았는가?
- code macro의 CDATA가 깨지지 않았는가?
- Confluence storage format으로 저장 가능한 HTML인가?
