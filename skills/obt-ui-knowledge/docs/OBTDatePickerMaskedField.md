# OBTDatePickerMaskedField

```tsx
import { OBTDatePickerMaskedField, OBTDatePickerMaskedFieldProps, OBTDatePickerMaskedFieldMethods } from 'luna-orbit';

export interface OBTDatePickerMaskedFieldProps {
  /**
   */
  type: MaskType;

  /**
   */
  pattern?: IPattern;

  /**
   */
  align: AlignType;

  /**
   */
  useMasking?: boolean;

  /**
   */
  onCancel: () => void;

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

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

  /**
   */
  onChange: (e: ChangeEventArgs<string>) => void;

  /**
   * 데이터 미 입력시 기본표시되는 문구
   */
  placeHolder?: string;

  /**
   */
  onValidate?: (e: ValidateEventArgs<string>) => void;

  /**
   * Click 시 발생하는 Callback 함수
   */
  onClick?: (e: MouseEventArgs) => void;

  /**
   * MouseDown 시 발생하는 Callback 함수
   */
  onMouseDown?: (e: MouseEventArgs) => void;

  /**
   * MouseMove 시 발생하는 Callback 함수
   */
  onMouseMove?: (e: MouseEventArgs) => void;

  /**
   * MouseUp 시 발생하는 Callback 함수
   */
  onMouseUp?: (e: MouseEventArgs) => void;

  /**
   * MouseLeave 시 발생하는 Callback 함수
   */
  onMouseLeave?: (e: MouseEventArgs) => void;

  /**
   * MouseEnter 시 발생하는 Callback 함수
   */
  onMouseEnter?: (e: MouseEventArgs) => void;

  /**
   * KeyDown 시 발생하는 Callback 함수
   */
  onKeyDown?: (e: KeyEventArgs) => void;

  /**
   * KeyPress 시 발생하는 Callback 함수
   */
  onKeyPress?: (e: KeyEventArgs) => void;

  /**
   * KeyUp 시 발생하는 Callback 함수
   */
  onKeyUp?: (e: KeyEventArgs) => void;

}

export interface OBTDatePickerMaskedFieldMethods {
  /**
   */
  getAllIndexes(arr: any, val: any): any;

  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(): void;

  /**
   */
  isEmpty(): boolean;

  /**
   */
  validate(): boolean;

  /**
   */
  getPatterns(type: MaskType, pattern: IPattern): IPattern;

  /**
   */
  moveselectionStart(): void;

}

// --- Referenced Types ---

export enum MaskType {
    'singleDate' = 'singleDate',
    'periodDate' = 'periodDate',
    'singleYearMonth' = 'singleYearMonth',
    'periodYearMonth' = 'periodYearMonth',
    'singleYear' = 'singleYear',
}

interface IPattern {
    separator?: RegExp,
    rawExtractor?: (value?: string) => string,
    formatter?: (value?: string) => string,
    excludeStar?: (value?: string) => string,
}

enum AlignType {
    'left' = 'left',
    'center' = 'center',
    'right' = 'right'
}

```
