# OBTTextField

```tsx
import { OBTTextField, OBTTextFieldProps, OBTTextFieldMethods } from 'luna-orbit';

export interface OBTTextFieldProps {
  /**
   */
  type: TextType;

  /**
   */
  maxLength?: number;

  /**
   */
  maxByte?: number;

  /**
   */
  align: AlignType;

  /**
   */
  tooltip?: IOBTTooltip;

  /**
   */
  codePickerIcon?: string | ReactSVGElement;

  /**
   */
  onCodePickerClick?: (e: EventArgs) => void;

  /**
   */
  getProfileInfo?: (e: { value: any; }) => Promise<UserProfilePopUpParameter>;

  /**
   */
  validateState?: ValidateStateEnum;

  /**
   * @deprecated 
   */
  useAutoComplete?: boolean;

  /**
   */
  useCodePickerInput: boolean;

  /**
   * 포커스시 가상 키패드 사용자 지정 옵션
   */
  inputMode?: InputModeEnum;

  /**
   * input의 autoComplete속성을 직접 지정가능한 옵션
   */
  autoComplete?: string;

  /**
   * 다국어 사용 여부
   */
  useMultiLang?: boolean | "force";

  /**
   */
  multiLangInfo?: IMultiLangInfo;

  /**
   */
  multiLangId?: IMultiLangValue;

  /**
   */
  multiLangValue?: IMultiLangValue;

  /**
   */
  onMultiLangChange?: (e: ChangeEventArgs<IMultiLangValue>) => void;

  /**
   */
  onMultiLangValidate?: (e: ValidateEventArgs<IMultiLangValue>) => void;

  /**
   */
  multiLangPanelTitle?: ReactElement<any, string | JSXElementConstructor<any>>;

  /**
   */
  onMultiLangBlur?: (e: EventArgs) => void;

  /**
   */
  multiLangProps?: { en?: Partial<IOBTTextField>; jp?: Partial<IOBTTextField>; cn?: Partial<IOBTTextField>; ex?: Partial<IOBTTextField>; };

  /**
   */
  encodingType?: EncodingType;

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

export interface OBTTextFieldMethods {
  /**
   */
  setReadonly(): void;

  /**
   */
  setAutoComplete(): void;

  /**
   */
  setAutoCompleteAttribute(autoComplete: string): void;

  /**
   */
  closeMultiLangPanel(): void;

  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(): void;

  /**
   */
  blur(): void;

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

enum TextType {
    'default' = 'default',   // 기본타입
    'password' = 'password',  // 암호타입
    'codePicker' = 'codePicker' // 코드피커타입
}

enum AlignType {
    'left' = 'left',
    'center' = 'center',
    'right' = 'right'
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

enum ValidateStateEnum {
    'none' = 'none',
    'success' = 'success',
    'warning' = 'warning',
    'error' = 'error'
}

enum InputModeEnum {
    // 가상 키보드를 사용하지 않습니다. 키보드를 직접 구현
    'none' = 'none',
    // 기본값 제공
    'text' = 'text',
    // 숫자형 키보드 (소수점 제공)
    'decimal' = 'decimal',
    // 숫자형 키보드 (소수잠 제공X)
    'numeric' = 'numeric',
    // 전화번호 입력 키보드 (* # + 제공)
    'tel' = 'tel',
    // 검색에 적합한 키보드. 기본 키보드와 차이: return 대신 go 버튼
    'search' = 'search',
    // 이메일에 적합한 키보드 (@ . 제공)
    'email' = 'email',
    // 기본 키보드에 .com 등을 제공하여 url입력에 적합한 키보드 
    'url' = 'url'
}

import { IMultiLangInfo } from 'luna-orbit/Common/Util';
export interface IMultiLangInfo {
    langCode: string;
    useLanguages: { langCode: string; langName: string; }[];
    defaultLangCode: string;
}

interface IMultiLangValue {
    en: string;
    jp: string;
    cn: string;
    ex: string;
}

enum EncodingType {
    'EUC_KR' = 'EUC-KR',
    'UTF_8' = 'UTF-8'
}

```
