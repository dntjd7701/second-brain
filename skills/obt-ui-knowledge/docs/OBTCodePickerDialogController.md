# OBTCodePickerDialogController

```tsx
import { OBTCodePickerDialogController, OBTCodePickerDialogControllerProps, OBTCodePickerDialogControllerMethods } from 'luna-orbit';

export interface OBTCodePickerDialogControllerProps {
  /**
   * 코드피커의 기본적인 속성및 데이터를 담고있는 오브젝트
   */
  codePicker: IBuiltInCodePicker;

  /**
   * 다이얼로그가 보여지는지 여부
   */
  isShowDialog: boolean;

  /**
   * 멀티선택이 가능한지 여부
   */
  canMultiSelect: boolean;

  /**
   * 코드피커의 getData에 넘기는 정적 파라미터
   */
  parameters: any;

  /**
   * fetch api
   */
  fetch?: any;

  /**
   * @deprecated 데이터소스를 캐시할것인지 여부
사용안함
   */
  isCacheDataSource: boolean;

  /**
   * @deprecated 데이터 소스를 이미 읽은 상태로 다이얼로그를 열때 readData를 하지 않는다.
   */
  alreadyRead?: boolean;

  /**
   * 전체선택을 사용할것인지 여부
   */
  useTotalToEmpty?: boolean;

  /**
   * 코드 도움창에서 확인 버튼 클릭시 default로 포커스가 있는 아이템을 선택값으로 할 것인지 여부
   */
  selectFocusedItem?: boolean;

  /**
   * 닫기 콜백
   */
  onClose: () => void;

  /**
   * 열기 콜백
   */
  onShow?: () => void;

  /**
   */
  dialogParameters?: () => any;

  /**
   */
  useDecryptPrivacy?: boolean;

  /**
   */
  keyword?: string;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: any[] | CodePickerValue;

  /**
   */
  onChange: (e: CodePickerChangeEventArgs) => void;

}

export interface OBTCodePickerDialogControllerMethods {
  /**
   * keyword
   */
  openDialog(options: { searchTextRequired: boolean; }): Promise<void>;

  /**
   */
  searchByKeyword(keyword: string): Promise<void>;

  /**
   */
  getSearchTextRequired(): Promise<boolean>;

  /**
   */
  getValuesWithPrivacy(grid: OBTDataGridInterface, rowIndexes: number[], items: any[]): Promise<any[]>;

  /**
   */
  handleChangeRowCheckedWithPrivacy(grid: OBTDataGridInterface, rowIndexes: number[], items: any[]): Promise<void>;

  /**
   */
  handleSelectAndConfirmWithPrivacy(grid: OBTDataGridInterface, rowIndexes: number[], items: any[], exceptItems: any[], totalSelect: boolean): Promise<void>;

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

import { CodePickerValue } from 'luna-orbit/OBTCodePicker/OBTCodePicker';
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
