---
date: 2026-05-14
type: settings
tags:
  - codex
  - obsidian
  - second-brain-system
---

# Vault Root 설정

## 왜 필요한가

Codex가 Obsidian 문서를 생성하거나 수정하려면, 어떤 경로를 장기 기억 저장소로 취급해야 하는지 명확해야 한다.

작업 디렉터리나 Markdown 파일 존재 여부만으로 Vault root를 추정하면 잘못된 위치에 문서가 쌓일 수 있다.

## 확정된 Vault Root

```text
/Users/woosung/Documents/second-brain
```

## 적용 규칙

Codex는 이 명시적으로 확인된 경로만 Obsidian Vault root로 취급한다.

현재 작업 디렉터리, `AGENTS.md` 위치, `emr-ai-context`, `Personal`, 기존 Markdown 파일, 사용자가 제공한 “작업 위치”는 Vault root 판단 근거가 아니다.

이 경로가 바뀌면 새 Vault root를 먼저 사용자에게 확인한 뒤 문서를 작성한다.

## 기대효과

Obsidian 기반 장기 기억이 한 곳에 축적되어 다음 세션에서 안정적으로 탐색하고 재사용할 수 있다.
