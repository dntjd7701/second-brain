# OBTConditionItem

OBTConditionPanel 하위의 각 검색조건 아이템입니다.

```tsx
import { OBTConditionItem, OBTConditionItemProps, OBTConditionItemMethods } from 'luna-orbit';

export interface OBTConditionItemProps {
  /**
   * 각 항목의 라벨을 지정합니다.
   */
  labelText?: ReactNode;

  /**
   * 라벨텍스트 표시여부를 지정합니다.
   */
  labelTextVisible?: boolean;

  /**
   */
  labelWidth?: number;

  /**
   * 조회조건에 툴팁을 띄울지 여부를 지정합니다. 
   * tooltip 지정 값이 있을시에 라벨 왼쪽 물음표 아이콘과 함께 툴팁이 제공됩니다.
   * @type {IOBTTooltip}
   * @see {@link IOBTTooltip }
   */
  tooltip?: {IOBTTooltip};

  /**
   * 추가 조회조건 항목으로 사용할지 여부를 지정합니다.
   * true 지정한 항목은 하단 접혀진 패널 내에 위치합니다.
   * @default false
   */
  optional?: boolean;

  /**
   */
  children?: any;

  /**
   * 필수입력 조회조건으로 사용할지 여부를 지정합니다.
   */
  required?: boolean;

  /**
   * 하위 컴포넌트에서 입력된 값이 변경될 때 발생하는 Callback 함수입니다.
   * @param e - 이벤트인자입니다.
   */
  onChange?: (e: ChangeEventArgs<any>) => void | Promise<void>;

  /**
   */
  guideMessage?: any;

  /**
   * required요소가 비었을 때 나타나는 tooltip을 사용자가 원하는 방식으로 지정할 수 있습니다.
   * @type {IOBTTooltip}
   */
  requiredTooltip?: {IOBTTooltip};

  /**
   * @deprecated 
   */
  columnSpan?: 1 | 2 | 3;

  /**
   * 조회조건 컴포넌트가 부모의 영역에서 차지할 범위를 지정합니다.
   * 1. 원본크기
   * 2. 두배 
   * 3. 세배
   */
  colSpan?: 1 | 2 | 3;

  /**
   * Item 내의 항목들 사이에 공간을 줄 수 있습니다.
   */
  spaceBetweenChildren?: boolean;

  /**
   * 컴포넌트간 포커스 이동 전에 호출되는 이벤트 callBack입니다.
   * @param e - 이벤트 인자입니다.
   * @see {@link BeforeMoveFocusEventArgs }
   */
  onBeforeMoveFocus?: (e: BeforeMoveFocusEventArgs) => void;

  /**
   */
  editing?: string;

  /**
   */
  fixedLayout?: boolean;

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
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

}

export interface OBTConditionItemMethods {
  /**
   */
  LabelSpace(props: any): Element;

  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(isLast: boolean): boolean;

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
