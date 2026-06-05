# OBTCheckBox2

```tsx
import { OBTCheckBox2, OBTCheckBox2Props, OBTCheckBox2Methods } from 'luna-orbit';

export interface OBTCheckBox2Props {
  /**
   * 체크박스 모양을 라디오버튼 형태로 만들어주는 속성
   * @default false
   */
  useRadioStyle?: boolean;

  /**
   * 툴팁 설정 객체
   */
  tooltip?: IOBTTooltip;

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
  value: boolean;

  /**
   * 라벨에 표시될 문구
   */
  labelText?: string;

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
  onValidate?: (e: ValidateEventArgs<boolean>) => void;

  /**
   */
  onChange: (e: ChangeEventArgs<boolean>) => void;

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

export interface OBTCheckBox2Methods {
  /**
   */
  isEmpty(): boolean;

  /**
   */
  validate(): boolean;

  /**
   */
  focus(): void;

  /**
   */
  blur(): void;

}

// --- Referenced Types ---

import { IOBTTooltip } from 'luna-orbit/OBTTooltip/OBTTooltip';
export interface IOBTTooltip extends CompositeProps.Default, Events.onFocus, Events.onBlur, Events.onActivate, Events.onDeactivate, Events.onClick,
    Events.onDblClick, Events.onMouseDown, Events.onMouseMove, Events.onMouseUp, Events.onMouseLeave, Events.onMouseEnter, Events.onKeyDown, Events.onKeyPress,
    Events.onKeyUp, Events.onMoveFocus {
    /**
     *  값이 true 이면, tooltip이 띄워집니다. 기본으로 부모 요소에 마우스 오버했을 때나 포커스가 잡혔을 때 tooltip이 열리게 됩니다.
     * @type {boolean}
     */
    value?: boolean,

    /**
     * 라벨에 표시될 문구를 지정합니다.
     * @type {any | string}
     * @required
     */
    labelText?: any | string,

    /**
     * 컴포넌트를 띄울 위치를 지정합니다.
     * @type {PositionType}
     * @see {@link PositionType}
     * @default top
     */
    position?: PositionType,

    /**
     * 컴포넌트의 정렬 상태를 지정합니다. (position 내에서 anchor 와 툴팁의 정렬을 지정)
     * @type {AlignType}
     * @see {@link AlignType}
     * @default center
     */
    align?: AlignType

    /**
     * 툴팁의 배경색에 대한 테마를 지정합니다
     * @type {TooltipTheme}
     * @see {@link TooltipTheme}
     * @default default
     */
    theme?: TooltipTheme,

    /**
     *  컴포넌트에 focus 됐을 때 tooltip을 유지 시킬지 지정 합니다
     * @type {boolean}
     */
    focusValue?: boolean,

    /**
     * @internal  
     */
    style?: any,

    /**
     * @internal  
     */
    overrideSize?: boolean,

    /**
     * @internal  
     */
    rootProps?: any,

    /**
     * @internal  
     */
    ignoreDisabled?: boolean,

    /**
     * 컴포넌트를 포탈로 띄울지 여부를 지정합니다.
     * @internal  
     */
    usePortal?: boolean,
    /**
     * @default true
     * 툴팁 고정 버튼 노출 유무를 지정합니다.
     */
    useFixButton?: boolean

    useNormalLineHeight?: boolean;
}

```
