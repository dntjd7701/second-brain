# OBTDockPanel

```tsx
import { OBTDockPanel, OBTDockPanelProps, OBTDockPanelMethods } from 'luna-orbit';

export interface OBTDockPanelProps {
  /**
   * DockPanel 의 각 Dock항목에 대한 추가 조건.
   * value 를 지정한 경우 onChange 이벤트를 반드시 핸들링 해야 합니다.
   * 각 dock 항목중, resizable 를 지정한 경우 size 항목이 반드시 지정되야 합니다.
   */
  value?: IDockInfo;

  /**
   */
  onChange?: (e: ChangeEventArgs<IDockInfo>) => void;

  /**
   */
  children?: any;

  /**
   */
  tutorialLabel?: string;

  /**
   */
  tutorialOrder?: number;

  /**
   */
  tutorialTitle?: string;

  /**
   * OBTAutoValueBinder와 연결키
   */
  id?: string;

  /**
   * 최상단 Element의 className
   */
  className?: string;

  /**
   * 컴포넌트 넓이(width)
   */
  width?: string;

  /**
   * 컴포넌트 높이(height)
   */
  height?: string;

}

export interface OBTDockPanelMethods {
  /**
   */
  handleMouseDown(target: Dock, e: MouseEvent): void;

}

// --- Referenced Types ---

interface IDockInfo {
    left?: IDockSideInfo,
    top?: IDockSideInfo,
    right?: IDockSideInfo,
    bottom?: IDockSideInfo
}

```
