# OBTConfirm

OBTConfirm
Prop : { value, labelText, type, open, cancelText, confirmText }

```tsx
import { OBTConfirm, OBTConfirmProps, OBTConfirmMethods } from 'luna-orbit';

export interface OBTConfirmProps {
  /**
   */
  type: Type;

  /**
   */
  title?: any;

  /**
   */
  labelText?: any;

  /**
   */
  confirmText: string;

  /**
   */
  cancelText: string;

  /**
   */
  onConfirm?: (e: EventArgs) => void;

  /**
   */
  onCancel?: (e: EventArgs) => void;

  /**
   * Dialog의 하단의 버튼을 설정합니다.
   */
  buttons?: IButton[];

  /**
   * 좀 더 엄격하게 onConfirm을 체크하여 OBTConfirm의 close 여부를 결정합니다.
   */
  strictConfirmCheck?: boolean;

  /**
   * 좀 더 엄격하게 onCancel 체크하여 OBTConfirm의 close 여부를 결정합니다.
   */
  strictCancelCheck?: boolean;

  /**
   */
  tutorialTitle?: string;

  /**
   */
  tutorialLabel?: string;

  /**
   */
  tutorialOrder?: number;

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

export interface OBTConfirmMethods {
  /**
   */
  handleKeyDown(e: KeyboardEvent<HTMLDivElement>): void;

  /**
   */
  handleOnKeyUp(event: KeyboardEvent<HTMLDivElement>): void;

}

// --- Referenced Types ---

enum Type {
    'default' = 'default',
    'success' = 'success',
    'warning' = 'warning',
    'error' = 'error',
    'question' = 'question'
}

```
