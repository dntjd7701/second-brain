# OBTYearField

```tsx
import { OBTYearField, OBTYearFieldProps, OBTYearFieldMethods } from 'luna-orbit';

export interface OBTYearFieldProps {
  /**
   */
  max?: string;

  /**
   */
  min?: string;

  /**
   */
  getWrapperStyle?: any;

  /**
   */
  align: AlignType;

  /**
   */
  position: PositionType;

  /**
   */
  onFocus: () => void;

  /**
   */
  onBlur: () => void;

  /**
   */
  onChange: (event: ChangeEvent<Element>, value: string) => void;

  /**
   */
  onMoveFocus: (direction: string) => void;

  /**
   */
  onKeyDown?: (event: any) => void;

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

  /**
   * 읽기전용(선택은 가능하지만 값은 변경불가) 여부
   * @default false
   */
  readonly: boolean;

  /**
   * 필수입력 여부
   * true로 설정시 OBTFormPanel, OBTConditionPanel등 컨테이너에서 필수적으로 값이 입력되어야하는 컴포넌트로 인식한다.
   * @default false
   */
  required: boolean;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: string;

}

export interface OBTYearFieldMethods {
  /**
   */
  focus(move: string): void;

  /**
   */
  onPopoverOpen(): void;

  /**
   * LUXPopoverController의 Popover 콤포넌트를 닫을 때 호출 시키는 Callback 함수를 통하여 dialog를 닫는다.
   */
  openDialog(): void;

  /**
   */
  closeDialog(): void;

  /**
   * 달력에서 날짜 클릭시 반영되게 하는 함수
   */
  onAccept(event: any, value: number): void;

  /**
   */
  getClassName(): string;

  /**
   */
  getNoMaskValue(value: string): string;

  /**
   */
  isValidValue(value: string): boolean;

  /**
   */
  shouldDisableBackspace(caretPosition: CaretPosition): false;

  /**
   */
  onChange(event: ChangeEvent<Element>, value: string, caretPosition: CaretPosition): void;

  /**
   */
  onKeyDown(event: any): void;

  /**
   */
  onKeyDownMask(event: any): void;

}

// --- Referenced Types ---

enum AlignType {
    'near' = 'near',
    'center' = 'center',
    'far' = 'far'
}

import { PositionType } from 'luna-orbit/OBTFloatingPanel/OBTFloatingPanel';
export enum PositionType {
    'top' = 'top',
    'left' = 'left',
    'right' = 'right',
    'bottom' = 'bottom'
}

```
