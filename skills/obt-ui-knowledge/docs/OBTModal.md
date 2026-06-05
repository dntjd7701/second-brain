# OBTModal

```tsx
import { OBTModal, OBTModalProps, OBTModalMethods } from 'luna-orbit';

export interface OBTModalProps {
  /**
   * 다이얼로그가 열렸는지 여부
   */
  open: boolean;

  /**
   */
  width: string | number;

  /**
   */
  height: string | number;

  /**
   */
  onRequestClose: () => void;

  /**
   */
  onAfterOpen?: () => void;

  /**
   */
  header?: Element | (() => Element);

  /**
   */
  footer?: Element | (() => Element);

  /**
   */
  right?: Element | (() => Element);

  /**
   * 최상단 Element의 className
   */
  className?: string;

}

export interface OBTModalMethods {
  /**
   */
  handleHeaderMouseDown(e: MouseEvent<HTMLDivElement, MouseEvent>): void;

  /**
   */
  getPosition(): { x: number; y: number; };

  /**
   */
  setPosition(pos: { x: number; y: number; }): void;

}
```
