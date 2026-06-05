# OBTColorPickerMain

```tsx
import { OBTColorPickerMain, OBTColorPickerMainProps, OBTColorPickerMainMethods } from 'luna-orbit';

export interface OBTColorPickerMainProps {
  /**
   */
  type?: MainType;

  /**
   */
  onButtonClick?: (e: EventArgs) => void;

  /**
   */
  onChange: ColorWrapChangeHandler;

  /**
   */
  onDialogClosed?: () => void;

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
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: any;

}

export interface OBTColorPickerMainMethods {
  /**
   */
  onSave(): void;

  /**
   */
  onClose(): void;

}

// --- Referenced Types ---

enum MainType {
    'basic' = 'basic',
    'popUp' = 'popUp'
}

```
