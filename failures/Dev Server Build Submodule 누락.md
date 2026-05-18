---
date: 2026-05-14
type: failure
project: klago-ui-micro
tags:
  - frontend
  - react-scripts
  - submodule
impact: 루트 build submodule 누락으로 dev server가 static base를 감시하지 못해 react-scripts 시작 실패
---

# Dev Server Build Submodule 누락

## 왜 중요한가

`klago-ui-micro`의 dev server는 일반적인 React 앱처럼 단일 소스만 서빙하지 않고, 루트 `build` submodule을 static shell처럼 사용한다.

따라서 dev server 오류가 발생했을 때 소스 코드 import 문제만 보는 것이 아니라, submodule 상태와 static base 구성을 함께 확인해야 한다.

## 증상

`yarn workspace bundler start` 실행 중 `react-scripts` 시작 단계에서 아래 오류로 종료됐다.

```text
ENOENT: no such file or directory, stat '/.VolumeIcon.icns'
```

## 실제 원인

`micro-common/bundler/config-overrides.js`의 devServer 설정은 `contentBase`를 루트 `build` 경로로 고정한다.

```js
const build = path.resolve(workspace, "build");
config.contentBase = build;
```

하지만 루트 `build`는 일반 빌드 산출물이 아니라 Git submodule이고, 작업 트리에서 삭제된 상태였다.

```text
D build
-8f538ad1c41f585c4fa4df1856aa50f1710f7bb4 build
```

CRA 기본 devServer는 `watchContentBase: true`이므로 누락된 static base를 감시/서빙하는 과정에서 macOS 루트 파일 stat 오류가 표면화될 수 있다.

## 구조 다이어그램

```mermaid
flowchart LR
    A[yarn workspace bundler start] --> B[react-scripts devServer]
    B --> C[config-overrides.js]
    C --> D[contentBase = root build]
    D --> E{build submodule 존재?}
    E -- 없음 --> F[static base 감시 실패]
    F --> G[/.VolumeIcon.icns ENOENT]
    E -- 있음 --> H[static shell 정상 서빙]
```

이 다이어그램에서 중요한 지점은 `build`가 일반 폴더가 아니라 submodule이라는 점이다.

따라서 dev server 오류가 소스 import 문제가 아니라 submodule checkout 상태에서 시작될 수 있다.

## 어떻게 해결했는가

로컬 `.git/modules/build`에 submodule 객체가 남아 있어 네트워크 없이 아래 명령으로 복구했다.

```bash
git -C /Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro submodule update --init build
```

복구 후 `build` submodule은 `8f538ad1c41f585c4fa4df1856aa50f1710f7bb4`로 체크아웃됐다.

## 기대효과

dev server 장애를 소스 코드 문제로 오진하지 않고, submodule과 static shell 구성을 빠르게 점검할 수 있다.

동일 증상이 재발했을 때 복구 시간이 줄어든다.

## 재발 방지 전략

프론트 dev server에서 `/.VolumeIcon.icns` ENOENT가 보이면 소스 import부터 보지 말고 먼저 다음을 확인한다.

```bash
git -C /Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro status --short
git -C /Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro submodule status build
ls -la /Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro/build
```

`build`가 삭제되어 있으면 `git submodule update --init build`를 우선 수행한다.

추가로 dev server가 켜져 있는데 클릭이 먹지 않거나 `curl /modules/bundler/asset-manifest.json` 연결이 불안정하면 다음을 확인한다.

```bash
git -C /Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro submodule status build
git -C /Users/woosung/Desktop/Amaranth10/1.Front/klago-ui-micro/build status --short --branch
```

`build`가 루트 프로젝트가 기대하는 커밋이 아닌 최신 `master`로 바뀌거나, `build/node_modules`, `build/yarn.lock`이 생기면 devServer의 `contentBase=build` 감시와 충돌할 수 있다.

`micro-common/bundler/config-overrides.js`에서는 static shell은 서빙하되 감시는 끄는 편이 안전하다.

```js
config.contentBase = build;
config.contentBasePublicPath = "/";
config.watchContentBase = false;
```

## 기술적 성장 관점

표면 오류 메시지보다 실행 환경의 구조를 먼저 확인하는 디버깅 관점을 축적했다.

프론트 dev server 장애에서도 source, bundler, submodule, static asset serving이 함께 얽힐 수 있음을 확인했다.
