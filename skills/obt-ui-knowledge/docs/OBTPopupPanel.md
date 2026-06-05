# OBTPopupPanel

설정한 영역에 슬라이드 형태로 팝업패널을 실행하는 컴포넌트입니다.

```tsx
import { OBTPopupPanel, OBTPopupPanelProps } from 'luna-orbit';

export interface OBTPopupPanelProps {
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

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: boolean;

  /**
   */
  onChange: (e: ChangeEventArgs<boolean>) => void;

}

```
