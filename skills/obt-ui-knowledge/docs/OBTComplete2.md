# OBTComplete2

```tsx
import { OBTComplete2, OBTComplete2Props, OBTComplete2Methods } from 'luna-orbit';

export interface OBTComplete2Props {
  /**
   * keyWord 로 검색하는 함수이며 외부에서 작성하여 사용합니다.
   */
  onSearch: (e: string) => Promise<any>;

  /**
   * @default 300
입력이 멈춘 후 부터 검색시까지의 지연시간 입니다. (단위 : ms)
   */
  delayTime?: number;

  /**
   * 리턴값을 columnWidths과 itemInfo를 가지는 함수입니다. 데이터를 어떻게 보여줄 것인지 정할 수 있습니다. 
   * 1. columWidths : 하나의 column(행) 들어가는 텍스트 공간(열)의 크기를 조절할 수 있습니다. 
   * ex) 이메일 부분을 넓게 보여주고 싶다면 20 20 60 으로 넣으면 이메일 텍스트 공간의 크기가 커집니다. 
   * 2. itemInfo : 
   * - key : 아이템의 key
   * - column : column의 순서(예제: 이름 - 회사명 - 이메일)
   * - isKeyValue: 텍스트 필드에 보여지는 값입니다. 현재는 name 이므로 리스트 선택시 텍스트 필드에 이름이 들어갑니다
   */
  dataInfo: { columnWidths: number[]; itemInfo: { key: string; codeProperty?: boolean; textProperty?: boolean; hideTooltip?: boolean; }[]; };

  /**
   * @default left
dropDownList에서 텍스트 정렬을 설정할 수 있습니다.
   */
  textAlign: "center" | "left" | "right";

  /**
   * 드롭다운을 열 수 있는 버튼을 생성할지에 대한 여부입니다.
   */
  hasDropDownButton?: boolean;

  /**
   * 드롭다운을 열 수 있는 버튼을 생성할지에 대한 여부입니다. (기존 OBTComplete)
   */
  isDropDown?: boolean;

  /**
   * @deprecated hasItemTooltip 으로 대체요망
드롭다운 리스트들에 tooltip을 달 것인지에 대한 여부입니다.
   */
  isShowTooltip?: boolean;

  /**
   * @default false
드롭다운 아이템들에 tooltip을 달 것인지에 대한 여부입니다.
   */
  hasItemTooltip?: boolean;

  /**
   * tooltip
   */
  tooltip?: IOBTTooltip;

  /**
   * 값이 어떻게 매핑될지에 대한 모드 설정
   * - StrictMode.toBefore : 직전에 선택한 값으로 다시 선택됩니다.
   * - StrictMode.toEmpty : 필드에 남아있는 문자를 비웁니다.
   */
  isStrictMode?: StrictMode;

  /**
   * 드롭다운 내부의 총 아이템 개수를 지정합니다. 지정하지 않으면 default 10개
   */
  itemCount: number;

  /**
   * 드롭다운 내부의 하나의 아이템 높이를 지정합니다. 지정하지 않으면 default 27px
   */
  itemHeight: string;

  /**
   * 데이터를 추가하는 버튼이 생기는지에 대한 여부를 지정합니다.
   */
  canAdd?: boolean;

  /**
   * 사용자가 입력한 값을 등록하는 버튼을 클릭했을 때 호출되는 콜백함수입니다.
   */
  onAdd?: (e: SelectAddPanelEventArgs) => void;

  /**
   * 항목 삭제여부를 지정할 수 있습니다. (우측에 X 버튼 생성)
   */
  canDelete?: boolean;

  /**
   * 데이터를 삭제할 때 호출되는 콜백함수입니다.
   */
  onDelete?: (e: DeleteListEvents) => boolean;

  /**
   * dropDown을 누를 때 호출되는 Callback 함수입니다.
   */
  onDropDownListClick?: (e: ClickListEventArgs) => void;

  /**
   * 입력창에 원하는 값으로 초기화할 때 사용합니다. (내부 inputValue)
   */
  defaultValue?: string;

  /**
   * defaultValue가 바뀔 때 발생하는 이벤트입니다. (내부 inputValue)
   */
  onDefaultValueChange?: (e: ChangeEventArgs<string>) => void;

  /**
   * dropDown의 width를 지정할 수 있습니다. 지정하지 않을 경우 input의 너비와 동일합니다. (number 타입)
   */
  dropDownWidth?: number;

  /**
   * 드롭다운 리스트의 아이템을 dataInfo의 itemInfo를 위주로 바라볼 것인지에 대해 지정할 수 있습니다. 
   * 기존에는 들어가는 데이터 위주로 보고 있음. 
   * 기존에 들어가는 데이터와, 보여지는 데이터의 개수를 다르게 할 수 없었다면 
   * 해당 속성을 사용하여 원하는 속성만 원하는 위치에 사용이 가능합니다.
   */
  autoArrange?: boolean;

  /**
   * 드롭다운영역 className
   */
  dropDownClassName?: string;

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
  value: any[];

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
  onChange: (e: ChangeEventArgs<any[]>) => void;

  /**
   * 데이터 미 입력시 기본표시되는 문구
   */
  placeHolder?: string;

  /**
   */
  onValidate?: (e: ValidateEventArgs<any[]>) => void;

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

  /**
   * Click 시 발생하는 Callback 함수
   */
  onClick?: (e: MouseEventArgs) => void;

}

export interface OBTComplete2Methods {
  /**
   */
  focus(): void;

  /**
   */
  blur(): void;

  /**
   */
  isEmpty(): boolean;

  /**
   */
  validate(): boolean;

  /**
   */
  renderLi(data: any, index: number): any;

  /**
   */
  renderText(data: any, index: number): any;

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

export enum StrictMode {
    'toEmpty' = 'toEmpty',
    'toBefore' = 'toBefore',
    'noChanges' = 'noChanges'
}

```
