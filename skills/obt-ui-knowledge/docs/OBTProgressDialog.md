# OBTProgressDialog

```tsx
import { OBTProgressDialog, OBTProgressDialogProps, OBTProgressDialogMethods } from 'luna-orbit';

export interface OBTProgressDialogProps {
  /**
   */
  open: boolean;

  /**
   */
  buttons?: IButton[];

  /**
   */
  title?: string;

  /**
   */
  subTitle?: Element;

  /**
   */
  type?: Type;

  /**
   */
  progressItems: IProgressItem[];

  /**
   */
  isShowTotalProgress?: boolean;

  /**
   */
  countLabel?: string;

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
   * 활성화여부
   * @default false
   */
  disabled: boolean;

}

export interface OBTProgressDialogMethods {
  /**
   */
  renderButtons(): any;

  /**
   */
  renderProgress(isEntireLoading: boolean): Element;

  /**
   */
  handleKeyDown(e: KeyboardEvent<HTMLDivElement>): void;

}

// --- Referenced Types ---

export enum Type {
    'error' = 'error',
    'default' = 'default',
    'warning' = 'warning',
    'success' = 'success'
}

```
