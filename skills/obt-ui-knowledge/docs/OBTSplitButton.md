# OBTSplitButton

```tsx
import { OBTSplitButton, OBTSplitButtonProps, OBTSplitButtonMethods } from 'luna-orbit';

export interface OBTSplitButtonProps {
  /**
   * @default left
더보기 위치를 지정합니다.
   */
  position?: ButtonPosition;

  /**
   * @default default
컴포넌트의 크기를 지정합니다.
   */
  type?: ButtonType;

  /**
   * @default default
값이 blue 이면, 파란색 테마, skyBlue면 하늘색 테마를 적용시킵니다.
   */
  theme?: ButtonTheme;

  /**
   * 툴팁에 대한 설정입니다.
   */
  tooltip?: IOBTTooltip;

  /**
   * @default dropDown
메인버튼 클릭시에 발생하는 모션의 타입을 지정합니다.
   */
  motionType?: ButtonMotionType;

  /**
   * 컴포넌트에서 onClick 동작이 있을 때 발생하는 Callback 함수입니다.
   */
  onClick?: (e: MouseEventArgs) => void;

  /**
   * dropDown 메뉴의 width 입니다.
   */
  dropDownWidth?: string;

  /**
   * OBTAutoValueBinder와 연결키
   */
  id?: string;

  /**
   * 최상단 Element의 className
   */
  className?: string;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: IValue[];

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

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

export interface OBTSplitButtonMethods {
  /**
   */
  open(): void;

  /**
   */
  onBlur(e: EventArgs): void;

}

// --- Referenced Types ---

enum ButtonPosition {
    'left' = 'left',
    'right' = 'right'
}

export enum ButtonType {
    'big' = 'big',
    'default' = 'default',
    'small' = 'small'
}

export enum ButtonTheme {
    'default' = 'default',

    /**
     * 파란색(Emphasized) 테마 입니다.
     */
    'blue' = 'blue',

    /**
     * 하늘색(Primary) 테마 입니다.
     */
    'skyBlue' = 'skyBlue',

    /**
     *  Drawer
     */
    'drawer' = 'drawer',

    /**
     * Drawer Important
     */
    'drawerImportant' = 'drawerImportant'
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

enum ButtonMotionType {
    /**
     * 메인 버튼을 클릭 하위 리스트가 열립니다.
     */
    'dropDown' = 'dropDown',

    /**
     * 메인 버튼을 클릭 하여도 리스트가 열리지 않습니다.
     */
    'split' = 'split'
}

```
