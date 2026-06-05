# OBTPreviousNextSelector

```tsx
import { OBTPreviousNextSelector, OBTPreviousNextSelectorProps, OBTPreviousNextSelectorMethods } from 'luna-orbit';

export interface OBTPreviousNextSelectorProps {
  /**
   */
  list: any[];

  /**
   * 컴포넌트에서 데이터소스를 이용하여 매핑 정의하는 속성입니다.
   */
  fieldName?: TypeList;

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
   */
  onValidate?: (e: ValidateEventArgs<string>) => void;

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
   */
  useSubLang?: boolean;

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

export interface OBTPreviousNextSelectorMethods {
  /**
   */
  focus(): void;

}

// --- Referenced Types ---

interface TypeList {
    /**
     * value : 값
     */
    value: string,
    /**
     * labelText : 텍스트
     */
    labelText: string,
    /**
     * labelText : 텍스트
     */
    labelSubText?: string
}

```
