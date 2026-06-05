# OBTCodePicker

데이터소스에서 하나혹의 복수의 항목을 사용자에게 선택받는 컴포넌트입니다.
검색어를 입력받아 데이터소스로부터의 검색을 지원합니다.  
다이얼로그로 데이터소스를 조회하고 선택할 수 있습니다.
데이터소스의 형태와 fetch할 방법, 다이얼로그의 형태등은 codePicker props에 정의합니다. 
이 컴포넌트는 크게 3가지 영역으로 구분됩니다.  
1. 인풋영역 - 데이터를 검색거나 선택한 데이터가 표시되는 영역입니다.
2. 드랍다운 영역 - canMultiSelect true 일경우 선택한 모든 항목이 표시되는 영역입니다.
3. 다이얼로그 영역 - 데이터소스를 조회해 보여주고 조회조건을 통해 상세 검색을 할수 있는 영역입니다.

```tsx
import { OBTCodePicker, OBTCodePickerProps, OBTCodePickerMethods } from 'luna-orbit';

export interface OBTCodePickerProps {
  /**
   * codePicker의 getData 함수로 넘기게 되는 파라미터 객체입니다.
   * @type {object}
   */
  parameters?: {object};

  /**
   * 코드피커의 형태에 대한 정의를 담고있는 객체입니다.
   * @required 
   */
  codePicker: IBuiltInCodePicker;

  /**
   * 멀티선택이 가능한지 여부를 정하는 속성입니다.
   * @default false
   */
  canMultiSelect: boolean;

  /**
   * 선택한 데이터를 인풋에 바인딩할수 있는 전략을 커스텀할 수 있는 이벤트 콜백입니다.
   * @param evt - 이벤트 객체
   * @param evt.selectedItems - 선택된 아이템 배열
   * @returns 컴포넌트 인풋에 바인딩할 문자열
   */
  onDisplaySelectedItem?: (evt: CodePickerDisplayItemEventArgs) => string;

  /**
   * 드롭다운 리스트의 각 아이템을 표시할 때의 전략을 커스텀할 수 있는 이벤트 미설정시 코드. 텍스트
   */
  onDisplayDropDownItem?: (e: CodePickerDisplayDropDownItemEventArgs) => string;

  /**
   * 툴팁 객체로 OBTTooltip의 props와 동일한 타입의 객체를 할당해주면 컴포넌트의 툴팁으로 동작합니다.
   */
  tooltip?: any;

  /**
   * OBTAutoValueBinder 를 통해 바인딩 될때 codeColumn 으로 쓰일 컬럼명입니다.
   */
  bindingCodeColumnName?: string;

  /**
   * OBTAutoValueBinder 를 통해 바인딩 될때 textColumn 으로 쓰일 컬럼명입니다.
   */
  bindingTextColumnName?: string;

  /**
   * 전체선택 모드를 사용할지 여부입니다.
   * @see 
   * @default false
   */
  useTotalToEmpty?: boolean;

  /**
   * 코드피커 검색 시에 OBTLoading을 띄울지에 대한 여부입니다.
   * @default true
   */
  useLoading?: boolean;

  /**
   * 코드피커 로딩 타입 정의
   * @default default
   */
  loadingType?: Type;

  /**
   * 코드피커 다이얼로그가 열리기 전에 호출되는 콜백입니다.
   * 이벤트 인자의 cancel값을 false로 변경하여 다이얼로그가 열리기 전에 동작을 취소시킬 수 있습니다.
   * @param e - 이벤트 객체
   * @param e.cancel - 취소 여부, 콜백 내에서 false로 할당되었다면 코드피커 다이얼로그가 열리지 않는다.
   * @param e.keyword - 인풋에 검색어로써 입력된 문자열
   */
  onBeforeCallCodePicker?: (e: { target: any; cancel: boolean; keyword: string; }) => void;

  /**
   * 오직 다이얼로그로만 값을 검색해볼지에 대한 여부입니다. 
   * false로 지정시에 인풋영역에 키보드 입력은 불가합니다.
   * @default true
   */
  allowKeyboardInput?: boolean;

  /**
   * 코드피커 결과 회신시 개인정보암호화 복호화 여부입니다.
   */
  useDecryptPrivacy?: boolean;

  /**
   * 멀티선택코드피커 > dropDown 영역 className
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
  value: any[] | CodePickerValue;

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
  onChange: (e: CodePickerChangeEventArgs) => void;

  /**
   * 데이터 미 입력시 기본표시되는 문구
   */
  placeHolder?: string;

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

export interface OBTCodePickerMethods {
  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(isLast: boolean): void;

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

import IBuiltInCodePicker from 'luna-orbit/OBTCodePicker/DataSource/IBuiltInCodePicker';
export interface IBuiltInCodePicker extends IPagingOption {
    /**
     * 코드피커 객체에 할당되는 아이디입니다. 
     */
    id: string,

    /**
     * placeholder
     */
    placeHolder?: string,

    /**
     * 데이터소스 다이얼로그의 타이틀로 사용됩니다. 
     * @required
     */
    dialogTitle: string,

    /**
     * 데이터소스 다이얼로그의 오른쪽에 작게 들어가는 서브타이틀로 사용됩니다.
     */
    dialogSubtitle?: string,

    /**
     * 데이터 소스 다이얼로그의 사이즈입니다. 
     * 
     * "small", "medium", "default", "large", "largeBig", "custom"
     * "custom"일 경우 dialogWitdh, dialogHeight를 수동으로 지정합니다.
     * @required
     */
    size: CodePickerSize

    /**
     * 다이얼로그의 너비로 OBTDialog2.width로 전달되는 값입니다.
     * @example "300px"
     */
    dialogWidth?: string,
    /**
     * 다이얼로그의 높이 OBTDialog2.height로 전달되는 값입니다.
     * @example "300px"
     */
    dialogHeight?: string,
    /**
     * 기본 할당되는 데이터소스 다이얼로그를 사용하지 않을때 양식에 맞춘 다이얼로그 컴포넌트를 할당합니다. 
     */
    customDialogComponent?: React.ComponentType<IDefaultDialog> | null
    /**
     * 기본 할당되는 데이터소스 다이얼로그내의 조회조건을 사용하지 않을때 양식에 맞춘 다이얼로그 컴포넌트를 할당합니다. 
     */
    customSearchConditionComponent?: React.ComponentClass<IDefaultDialogConditionPanel> | null
    /**
     * @internal 
     */
    dialogConditionItems?: CodePickerDialogConditionPanelFactoryItem[]
    /**
     * 페이징을 사용할것인지 여부입니다.
     */
    paging?: boolean,
    /**
     * getData 콜백으로 부터 전달받은 데이터소스 객체에서 코드값에 해당하는 값을 가지는 프로퍼티명을 지정합니다.
     * @required
     */
    codeProperty: string;
    /**
     * getData 콜백으로 부터 전달받은 데이터소스 객체에서 텍스트값에 해당하는 값을 가지는 프로퍼티명을 지정합니다.
     * @required
     */
    textProperty: string;
    /**
     * 이 값이 존재한다면 인풋영역과 드랍다운 영역에 
     * 인풋영역과 드랍다운에 codeProperty 대신해서 표시할 값이 존재한다면 
     */
    displayCodeProperty?: string;
    /**
     * 인풋영역과 드랍다운에 textProperty 대신해서 표시할 값
     */
    displayTextProperty?: string;
    /**
     * OBTDataGrid에 바인딩되는 컬럼 종류
     */
    columns?: Array<IColumn>;
    /**
     * 다이얼로그 그리드에 바인딩할 이벤트 콜백
     */
    gridEvents?: any;
    /**
     * 조회하기전 searchText 입력여부를 체크할것인지 여부
     */
    searchTextRequired?: boolean | ((e: ICodePickerGetDataEventArgs) => Promise<boolean>);
    /**
     * 코드도움 그리드 상단 기능버튼 사용 여부
     */
    useFunctionButtons?: boolean | (() => boolean),
    /**
     * 코드도움 그리드 상단 기능버튼 구성 
     */
    functionButtons?: Array<any>,
    /**
     * 코드도움창 하단 OBTReferencePanel 사용여부 
     */
    useReferencePanel?: boolean | (() => boolean);
    /**
     * 코드도움창 하단 OBTReferencePanel 커스텀
     */
    referencePanel?: any,
    /**
     * 다이얼로그의 데이터가 read된 이후에 호출되는 콜백입니다.
     * @param e - 이벤트 인자
     * @param e.grid - 다이얼로그내 OBTDataGridInterface 객체
     * @returns 
     */
    onAfterOpen?: (e: { target: any, grid: OBTDataGridInterface }) => void;
    /**
     * 다이얼로그의 데이터가 read된 이후에 호출되는 콜백입니다.
     * @param e - 이벤트 인자
     * @param {OBTDataGridInterface} e.grid - 다이얼로그내 OBTDataGridInterface 객체
     * @param {GridEvents.AfterReadEventArgs} e.event - 다이얼로그내 OBTDataGridInterface 객체
     * @returns 
     */
    onAfterRead?: (e: { target: any, grid: OBTDataGridInterface, event: GridEvents.AfterReadEventArgs }) => void;
    /**
     * 
     * @param e 
     */
    getData?(e: ICodePickerGetDataEventArgs): Promise<IResponseData>;
    /**
     * 페이징, 전체선택 모드를 사용할 경우 전체 데이터아이템의 카운트 읽어오는 함수
     * @param e 
     */
    getTotalCount?(e: ICodePickerGetTotalCountEventArgs): Promise<number>;
}

import { Type } from 'luna-orbit/OBTLoading/OBTLoading';
export enum Type {
    'small' = 'small',
    'default' = 'default',
    'large' = 'large'
}

class CodePickerValue {
  constructor(isTotalSelect: boolean, value: Object[] | null, exceptValue: Object[] | null);
  get isTotalSelect(): any;
  get value(): any;
  get exceptValue(): any;
  /**
       * 아무것도 선택되지않은 빈 value인지 여부를 리턴한다.
       */
  isEmpty(): void;
  /**
       * 타입이 명확하지 않은 object가 전체선택 value로 취급될수 있는지 여부를 리턴한다.
       * @param object 
       */
  canConvert(object: any): void;
  /**
       * 타입이 명확하지 않은 오브젝트를 CodePickerValue 타입으로 매핑한다.
       * 매핑될수 없는 오브젝트라면 Error를 throw 한다.
       * @param object 
       */
  valueOf(object: any): void;
  /**
       * 아무것도 선택되지 않은 빈 CodePickerValue객체를 생성해 리턴한다.
       */
  default(): CodePickerValue;
  asArrayValue(value: any[] | CodePickerValue): void;
  /**
       * value 가 Object 타입인 경우 CodePickerValue 형태로 변환시켜준다.
       */
  toCodePickerValue(value: any): void;
}

```
