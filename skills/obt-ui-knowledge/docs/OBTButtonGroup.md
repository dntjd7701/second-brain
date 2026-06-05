# OBTButtonGroup

```tsx
import { OBTButtonGroup, OBTButtonGroupProps } from 'luna-orbit';

export interface OBTButtonGroupProps {
  /**
   * 그룹지을 OBTButton들
   * @required 
   */
  children: any;

  /**
   * 버튼 크기 타입
   * big | default | small | state
   * @default ButtonType.default
   */
  type?: ButtonType;

  /**
   * OBTButton 콤포넌트의 key 속성값과 매핑되어 default로 선택되는 OBTButton 콤포넌트를 정의하는 속성
   * @required 
   */
  value: string;

  /**
   * 버튼 그룹에 대한 툴팁 설정
   */
  tooltip?: any;

  /**
   */
  align?: AlignType;

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
   */
  onChange: (e: ChangeEventArgs<string>) => void;

  /**
   * MouseEnter 시 발생하는 Callback 함수
   */
  onMouseEnter?: (e: MouseEventArgs) => void;

  /**
   * MouseLeave 시 발생하는 Callback 함수
   */
  onMouseLeave?: (e: MouseEventArgs) => void;

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

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


// --- Referenced Types ---

enum ButtonType {
    'big' = 'big',
    'default' = 'default',
    'small' = 'small',
    'state' = 'state',
    'smallState' = 'smallState'
}

enum AlignType {
    'left' = 'left',
    'center' = 'center',
    'right' = 'right'
}

```
