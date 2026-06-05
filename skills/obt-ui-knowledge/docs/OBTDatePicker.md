# OBTDatePicker

```tsx
import { OBTDatePicker, OBTDatePickerProps, OBTDatePickerMethods } from 'luna-orbit';

export interface OBTDatePickerProps {
  /**
   * 날짜 포맷을 선택합니다.(ex YYYYMMDD, YYYYMM, YYYY)
   */
  format: FormatType;

  /**
   * 데이터의 타입이 single인지 period 인지 지정합니다.
   */
  type: Type;

  /**
   * 입력 가능한 날짜에 대한 범위의 최대(끝) 날짜를 지정하는 속성입니다.
   */
  max?: string;

  /**
   * 입력 가능한 날짜에 대한 범위의 최소(시작) 날짜를 지정하는 속성입니다.
   */
  min?: string;

  /**
   * 툴팁에 대한 설정입니다.
   */
  tooltip?: IOBTTooltip;

  /**
   * input을 custom element로 쓸 때 사용합니다.
   */
  customInputElement?: any;

  /**
   * 날짜 선택을 위한 dialog의 정렬을 지정하는 속성입니다.
   */
  dialogAlign?: AlignType;

  /**
   * 날짜 선택을 위한 dialog의 위치를 지정하는 속성입니다.
   */
  dialogPosition?: PositionType;

  /**
   * periodPicker의 상단 버튼들의 사용여부를 지정하는 속성입니다.
   */
  useControlButton?: boolean;

  /**
   * periodPicker의 왼쪽 하단의 라벨 부분을 custom element로 쓸 때 사용합니다.
   */
  customLabel?: (from?: string, to?: string, onResetFrom?: () => void, onResetTo?: () => void) => any;

  /**
   * 단축키 사용 여부
   */
  useShortCut?: boolean;

  /**
   * data-orbit-component 타입
   */
  dataOrbitComponent?: string;

  /**
   * periodPicker의 확인 버튼을 눌렀을때 발생하는 callback 함수 입니다..
   */
  onConfirm?: () => void;

  /**
   * periodPicker의 취소 버튼을 눌렀을때 발생하는 callback 함수 입니다..
   */
  onCancel?: () => void;

  /**
   * dateButton을 클릭할 때 발생하는 callback 함수 입니다.
   */
  onDateButtonClick?: (e: EventArgs) => void;

  /**
   * 상태 ( disabled, readonly, required ) 를 가진 경우라도 기본 스타일을 유지합니다.
   */
  useStatelessStyle?: boolean;

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
  value: any;

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
  onChange: (e: ChangeEventArgs<any>) => void;

  /**
   */
  onValidate?: (e: ValidateEventArgs<any>) => void;

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

export interface OBTDatePickerMethods {
  /**
   * value가 Date 형식으로 표시 될 수 있는 값인지 판별
   */
  isDate(format: FormatType, value: any, minMax: any): boolean;

  /**
   * value를 알맞는 형식으로 바꿔줌
   */
  changeDate(value: any, length: number, format: string): string;

  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(): void;

  /**
   * 값이 비어있는지를 확인하는 함수
   * 비어있다면 true, 입력된 상태라면 false를 반환
   */
  isEmpty(): boolean;

  /**
   */
  validate(): boolean;

}

// --- Referenced Types ---

export enum FormatType {
    'YYYYMMDD' = 'YYYYMMDD',
    'YYYYMM' = 'YYYYMM',
    'YYYY' = 'YYYY'
}

export enum Type {
    'single' = 'single',
    'period' = 'period',
    'week' = 'week'
}

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

import { AlignType } from 'luna-orbit/OBTFloatingPanel/OBTFloatingPanel';
export enum AlignType {
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
