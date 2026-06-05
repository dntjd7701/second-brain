# OBTDataGrid

```tsx
import { OBTDataGrid, OBTDataGridProps, OBTDataGridMethods } from 'luna-orbit';

export interface OBTDataGridProps {
  /**
   * 리얼그리드와의 연결을 담당하는 인터페이스
   */
  interface: OBTDataGridInterface;

  /**
   */
  customStyle?: CustomStyle;

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
   * 컨텍스트로 전달된 권한(일반적으로 로그인 유저의 권한정보)을 사용할것인지 여부
   * @default true
   */
  usePageAuthority?: boolean;

  /**
   * 컨텍스트로 넘어오는 pageAuthority를 바라보는것이 디폴트
   * 변경을 원할 경우 사용하는 옵션
   */
  pageAuthority?: IPageAuthority;

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

}

export interface OBTDataGridMethods {
  /**
   * 정렬 및 소계
   * 컬럼 크기, 순서등의 정보를 localStorage에 저장시 사용될 키값을 생성한다.
   */
  makeClientId(): string;

  /**
   * 그리드에 포커스
   */
  focus(): void;

  /**
   * 그리드 refresh
   */
  refresh(): void;

  /**
   */
  getGridElement(): HTMLDivElement;

  /**
   */
  setDateColumnDefaultValue(rowIndex: number, columnName: string): void;

  /**
   */
  getDateDialogValue(): string | number | Date;

  /**
   * 다이얼로그 닫기 콜백
   */
  handleClickCloseDialogButton(evt: EventArgs): void;

  /**
   */
  processSearch(keywordOption: SearchKeywordOption): Promise<void>;

  /**
   */
  suspendLoading(): Promise<void>;

  /**
   */
  resumeLoading(): Promise<void>;

  /**
   */
  showProgress(options: IShowProgressOptions): Promise<void>;

  /**
   */
  setProgress(options: ISetProgressOptions): void;

  /**
   */
  hideProgress(): Promise<void>;

  /**
   */
  showPrintDialog(e: { askMasking?: boolean; askReadAllPages?: boolean; }): Promise<{ cancel: boolean; useMasking?: boolean; readAllPages?: boolean; }>;

  /**
   */
  renderSearchBox(): any;

  /**
   */
  renderCodePickerDialog(): Element;

  /**
   */
  handleReorderMouseDown(e: MouseEvent<Element, MouseEvent>): void;

  /**
   */
  handleReorderMouseUp(e: MouseEvent): void;

  /**
   */
  handleDocumentMouseMove(e: MouseEvent): void;

  /**
   */
  _updateHover(): void;

  /**
   */
  handleMouseLeave(e: MouseEvent<Element, MouseEvent>): void;

  /**
   */
  handleMouseMove(e: MouseEvent<Element, MouseEvent>): void;

  /**
   * 엑셀 내려받기 다이얼로그 렌더링
   * 요청으로 더티 데이터 체크로직 제거
   */
  renderExcelExportDialog(): Element;

  /**
   * 컬럼표시 다이얼로그
   */
  renderCustomColumnDialog(): Element;

  /**
   */
  handleYearMonthDayDateDialogAccept(valueFrom: any, valueTo: any): void;

  /**
   */
  handleYearDateDialogAccept(valueFrom: any, valueTo: any): void;

  /**
   */
  handleYearMonthDateDialogAccept(valueFrom: any, valueTo: any): void;

  /**
   * 날짜 다이얼로그가 열린후 처음으로 선택되는 날짜를 가져온다.
   */
  getInitialDate(dataColumn: { minDate?: string; maxDate?: string; rowIndex: number; columnName: string; dateFormat: DateFormat; value: string; }): Date;

  /**
   */
  renderDateDialog(): Element;

  /**
   */
  renderAutoComplete(): Element;

  /**
   */
  setPrivacyProgress(percent: number, visible: boolean, labelText: string): Promise<void>;

  /**
   */
  getPrivacyOptions(): any;

  /**
   */
  isPrivacyEnabled(): boolean;

  /**
   */
  isOneAiAvailable(): boolean;

  /**
   */
  fatalError(error: string): void;

  /**
   */
  oneAiDataAnalysisDataSender(e: any): Promise<void>;

  /**
   */
  copyClipboard(): Promise<void>;

  /**
   */
  openOneAiDataAnalysis(): Promise<void>;

  /**
   */
  openCalculator(): void;

}

// --- Referenced Types ---

import OBTDataGridInterface from 'luna-orbit/OBTDataGrid/OBTDataGridInterface';
class OBTDataGridInterface {
  GridType: any;
  ColumnType: any;
  ColumnAlignment: any;
  ImageLabelTemplate: any;
  PrivacyBehavior: any;
  /**
       * 두 개 이상의 그리드가 check 될 경우 하나의 그리드만 체크되게끔 한다.
       * @param grids 
       */
  setSingleGridCheckable(...grids: Array<OBTDataGridInterface>): void;
  /**
       * @deprecated 개발중인 기능이므로 동작이 언제든 바뀔수 있습니다.
       * @param detailGrids 
       * @param option 
       */
  setDetailGrids(detailGrids: Array<OBTDataGridInterface>, option?: IDetailGridOption): void;
  setDetailGrid(grid: OBTDataGridInterface, option?: IDetailGridOption): void;
  /**
       * fieldName 기반 리턴
       * @param column 
       * @returns 
       */
  getFieldName(column: IColumn, options?: {
        useMultiLang?: boolean;
        multiLangInfo?: { langCode: string; };
    }): void;
  getFieldName(column: IColumn): void;
  /**
       * grid 인자를 넘겨주지 않으면 
       * 개인정보 비활성화 여부를 체크하지 않고 값을 리턴함에 주의
       * @param column 
       * @param grid 
       * @returns 
       */
  getOriginFieldName(column: IColumn, grid?: OBTDataGridInterface): void;
  getOriginFieldName(column: IColumn): void;
  isUseMultiLang(column?: IColumn): void;
  /** @internal */
  _gridElementId: string;
  dateFieldMinDate: any;
  dateFieldMaxDate: any;
  reservedIconNames: any;
  /** @internal */
  _clientKey: string | null;
  getStorageKey: any;
  /**
       * @internal
       */
  readCallbackList: { key: string, function: Read, done: boolean, canceled: boolean }[];
  /**
       * 최초 그리드 설정시 컬럼 설정을 캐시한다.
       * @internal
       */
  _initialColumnProperty: ChangedLayoutByColumn | null;
  /**
       * 최초 그리드 설정시 fixedColumnCount를 캐시한다.
       * @internal
       */
  _initialFixedColumnCount: number | undefined;
  /**
       * not implemented
       * 최초 그리드 설정시 fixedColumnCount를 캐시한다.
       * 
       * @internal
       */
  _initialGroupFields: string[] | undefined;
  setModuleCode: any;
  setFetch: any;
  multiSelectModeContext: {
        mode: 'block' | 'cell'
    };
  /**
       * 생성자에서 주입받은 아이디
       */
  get id(): any;
  /**
       * 생성자에서 주입받은 그리드옵션
       */
  get gridOption(): any;
  /**
       * 세팅된 컬럼리스트
       */
  get columns(): any;
  /**
       * 관리되지않는 그리드옵션
       * @internal
       */
  get unmanagedGridOptions(): any;
  /**
       * 코드피커 getaData로 넘기는 fetch
       * @internal
       */
  get codePickerAjaxEbp(): any;
  /**
       * 리얼그리드의 gridview
       */
  get gridView(): any;
  /**
       * provider
       */
  get provider(): any;
  get customStyle(): any;
  /**
       * 리얼그리드의 프로바이더
       */
  get realGridProvider(): any;
  get isReady(): any;
  /**
       * 새로운행이 추가되기전에 발생되는 이벤트, cancel 가능
       * [Events.BeforeAddRowEventArgs]
       * 이벤트파리미터 클래스
       */
  onBeforeAddRow: any;
  /**
       * 새로운행이 추가되기된 이후에 발생하는 이벤트
       * [AfterAddRowEventArgs]
       */
  onAfterAddRow: any;
  /**
       * 행 삭제전에 발생하는 이벤트
       * cancel가능
       * [BeforeRemoveRowEventArgs]
       */
  onBeforeRemoveRow: any;
  /**
       * 행이 삭제된 이후에 발생하는 이벤트
       * [AfterRemoveRowEventArgs]
       */
  onAfterRemoveRow: any;
  /**
       * 행이 삭제된 이후에 발생하는 비동기 이벤트
       * [AfterRemoveRowEventArgs]
       */
  onAfterRemoveRowAsync: any;
  /**
       * 셀의 데이터가 변경되기전 발생하는 이벤트
       * cancel가능 
       * [BeforeChangeEventArgs]
       */
  onBeforeChange: any;
  /**
       * 셀의 데이터가 변경되기전에 변경되기 발생하는 이벤트
       * 변경되기 전값과 변경된 값을 이용한 유효성검사를 할 수 있다.
       * cancel가능 
       * [ValidateChangeEventArgs]
       */
  onValidateChange: any;
  /**
       * @event
       * 셀의 데이터가 변경된 이후에 발생하는 이벤트
       * [AfterChangeEventArgs]
       */
  onAfterChange: any;
  /**
       * @event
       * 셀의 데이터가 변경된 이후에 발생하는 이벤트
       * [AfterChangeEventArgs]
       */
  onAfterChangeAsync: any;
  /**
       * 
       */
  onBeforeCheck: any;
  /**
       * before
       * checkable 그리드에서 행이 체크상태가 변경된 이후에 발생하는 이벤트
       * [AfterCheckEventArgs]
       */
  onAfterCheck: any;
  /**
       * checkable 그리드에서 헤더의 전체체크, 해제 여부가 바뀐후 발생하는 이벤트
       * [AfterHeaderCheckEventArgs]
       */
  onAfterHeaderCheck: any;
  /**
       * 셀 선택이 바뀌기 전에 발생하는 이벤트 
       * [BeforeSelectChangeEventArgs]
       */
  onBeforeSelectChange: any;
  /**
       * 셀선택이 바뀐 이후에 발생하는 이벤트
       * [AfterSelectChangeEventArgs]
       */
  onAfterSelectChange: any;
  /**
       * 셀 선택이 바뀌기 전에 발생하는 이벤트 
       * [BeforeSelectChangeEventArgs]
       */
  onBeforeChangeRowSelection: any;
  /**
       * onBeforeChangeRowSelectionAsync 이벤트를 발생시킬 것인지 여부
       * [BeforeSelectChangeEventArgs]
       */
  shouldInvokeBeforeChangeRowSelectionAsync: any;
  /**
       * 셀 선택이 바뀌기 전에 발생하는 이벤트 
       * [BeforeSelectChangeEventArgs]
       */
  onBeforeChangeRowSelectionAsync: any;
  /**
       * 행 변경이 확정되고, 이동되기 전에 호출된다.
       * @internal
       */
  onRowSelectionChanging: any;
  /**
       * 셀선택이 바뀐 이후에 발생하는 이벤트
       * [AfterSelectChangeEventArgs]
       */
  onAfterChangeRowSelection: any;
  /**
       * 데이터를 읽은 후에 호출되는 이벤트
       * [AfterReadEventArgs]
       */
  onAfterRead: any;
  /**
       * 데이터 셀을 더블클릭했을때 발생하는 이벤트
       * [DataCellDblClickedEventArgs]
       */
  onDataCellDblClicked: any;
  /**
       * 데이터 셀을 클릭했을때 발생하는 이벤트
       * [DataCellClickedEventArgs]
       */
  onDataCellClicked: any;
  /**
       * 마우스 오버시 툴팁을 보여주기전 발생
       * [DataCellDblClickedEventArgs]
       */
  onShowTooltip: any;
  /**
       * 컬럼헤더셀의 툴팁이 표시될때 발생하는 콜백 함수이다. return 되는 값이 툴팁에 표시된다. 기본값으로 컬럼헤더 text가 툴팁에 표시된다.
       */
  onShowHeaderTooltip: any;
  /**
       * 데이터, 체크등 내부의 데이터가 변경될때 호출
       * [AfterDataChangeEventArgs]
       * @internal
       */
  onAfterDataChanged: any;
  /**
       * PageContainer에서 Drawer를 보여줘야 되는 상황에서 호출되는 이벤트
       * [DrawerEventArgs]
       */
  onDrawer: any;
  /**
       * 
       */
  onAlert: any;
  /**
       * rowSelectMode에서 엔터 입력이 들어왔을때 호출되는 이벤트
       * [SelectByEnterEventArgs]
       * @internal
       */
  onSelectByEnter: any;
  /**
       * 수정가능한 그리드에서 엔터, 방향키로 셀 이동시 빈값이면 발생하는 이벤트
       * [SelectByEnterEventArgs]
       */
  onSkipEmptyCell: any;
  /**
       * 헤더의 컬럼 너비가 바뀌고나서 호출됨
       */
  onColumnWidthChanged: any;
  /**
       * 컬럼표시 확인 클릭시 호출
       * @internal 
       */
  onCustomLayoutChanged: any;
  /**
       * 컬럼표시 초기화 동작시 호출
       * @internal 
       */
  onCustomLayoutReset: any;
  /**
       * 헤더의 컬럼 표시가 바뀌고나서 호출됨
       */
  onColumnVisibleChanged: any;
  /**
       * 헤더의 컬럼 순서가 바뀌고나서 호출됨
       */
  onColumnDisplayIndexChanged: any;
  /**
       * hasActionButton true인 컬럼의 액션버튼을 클릭했을때 발생한다.
       */
  onClickCustomActionButton: any;
  /**
       * hasImageButton true인 컬럼의 액션버튼을 클릭했을때 발생한다.
       */
  onImageButtonClicked: any;
  /**
       * 페이지 넘버가 바뀌기 전에 호출된다.
       */
  onBeforeChangePageNumber: any;
  /**
       * 페이지 넘버가 바뀐후에 호출된다.
       */
  onAfterChangePageNumber: any;
  /**
       * 코드피커 다이얼로그가 호출되기 이전에 호출됨, cancel 가능
       */
  onBeforeCallCodePicker: any;
  /**
       * 스크롤이 마지막에 이르렀을때 호출된다.
       */
  onReachLastPage: any;
  /**
       * 드래그를 시작하면 발생하는 이벤트
       * cancle = true drag가 취소된다. 
       * [InnerDragStartEventArgs]
       */
  onInnerDragStart: any;
  /**
       * 드래그 상태에서 마우스버튼을 놓으면 발생하는 이벤트.
       * 행 단위 드래그 이동에 사용
       * cancle = true drag가 취소된다. 
       * [InnerDropEventArgs]
       */
  onInnerDrop: any;
  /**
       * link타입 컬럼 클릭 이벤트
       */
  onClickLinkColumn: any;
  /**
       * 
       */
  onDisplayEmptyBody: any;
  /**
       * 
       */
  onMoveFocus: any;
  /**
       * 탭키를 입력하여 포커스 이동시
       */
  onMoveFocusByTab: any;
  /**
       * 
       */
  onKeyDown: any;
  /**
       * 
       */
  onKeyUp: any;
  /**
       * 
       */
  onAfterColumnHeaderCheck: any;
  /**
      * type = autoComplete 일때, 아이템을 선택했을 때 호출
      */
  onSearchedItemSelect: any;
  /**
       * 개인정보 암호화 - 개인정보 조회 이벤트
       */
  onGetPrivacy: any;
  /**
       * 개인정보 암호화 - 개인정보 조회 완료 이벤트
       */
  onPrivacyRetrieved: any;
  /**
       * 컨텍스트 메뉴
       */
  onContextMenuItemClicked: any;
  /**
       * 컨텍스트 메뉴 - 엑셀 내려받기
       */
  onContextMenuExportExcel: any;
  /**
       * 헤더 클릭 이벤트
       */
  onColumnHeaderClicked: any;
  /**
       * GroupBy 변경 이벤트
       */
  onGroupByChanged: any;
  /**
       * OrderBy 변경 이벤트
       */
  onOrderByChanged: any;
  onAiGetData: any;
  /**
       * 트리뷰 펼치기 변경 이벤트
       */
  onTreeItemExpanding: any;
  /**
       * 트리뷰 접기 변경 이벤트
       */
  onTreeItemCollapsing: any;
  /**
       * 붙여넣기 이벤트
       */
  onPaste: any;
  onAutoPrint: any;
  /**
       * @internal
       */
  onChangeEmptySetType: (emptySetType: EmptySetType) => void;
  /**
       * @internal
       */
  onClickContextSettingDialog: () => void;
  /**
       * @internal
       */
  onClickContextMenuExportExcel: () => void;
  /**
       * @internal
       */
  onClickContextMenuShowSearchBox: () => void;
  /**
       * @internal
       */
  onClickContextMenuCustomColumn: () => void;
  /**
       * @internal
       */
  onClickContextMenuCollapseLevel: () => void;
  /**
       * @internal
       */
  onClickContextMenuExpandLevel: () => void;
  /**
       * @internal
       */
  onCallCodePickerDialog: ((e: any) => void) | undefined;
  /**
       * @internal
       */
  onCallCodePickerSearch: ((e: any) => void) | undefined;
  /**
       * OBTDataGrid에 데이트피커 팝오버를 열라고 요청
       * @internal
       */
  onCallDatePickerDialog: ((e: any) => void) | undefined;
  /**
       * OBTDataGrid에 데이트피커 팝오버를 닫으라고 요청
       * @internal
       */
  onCloseDatePickerDialog: (() => void) | undefined;
  /**
       * AutoCompleteDialog에 팝오버를 열라고 요청
       * @internal
       */
  onCallAutoCompleteDialog: ((e: any) => void) | undefined;
  /**
       * AutoCompelteDialog에 팝오버를 닫으라고 요청
       * @internal
       */
  onCloseAutoCompleteDialog: (() => void) | undefined;
  /**
       * onShowEditor에 의해 처음 세팅될 애들
       * @internal
       */
  onShowEditorAutoCompleteDialog: ((e: any) => void) | undefined;
  /**
       * AutoCompleteDialog와 연결되는 onKeyDown
       * @internal
       */
  onKeyDownAutoComplete: ((keyCode: number) => boolean) | undefined;
  /**
       * OBTDataGrid에 데이트피커 팝오버를 닫으라고 요청
       * @internal
       */
  onKeyDownInternal: ((keyCode: number) => boolean) | undefined;
  /**
       * 다국어 패널 표시 콜백
       */
  onShowMultiLangPanel: ((e: {
        show: false;
    } | {
        show: true;
        boundary: {
            left: number;
            top: number;
            width: number;
            height: number;
        };
        rowIndex: number;
        column: IColumn;
        multiLangInfo: IMultiLangInfo;
        multiLangValue: {
            kr: string;
            en: string;
            jp: string;
            cn: string;
            ex: string;
        };
        required: boolean;
        readonly: boolean;
        align: string;
        maxLength?: number;
        focusLangCode?: string;
        multiLangPanelTitle?: any;
    }) => void) | undefined;
  /**
       * 
       * @param id 그리드의 아이디 한 페이지 내에서는 유일해야한다.
       * @param options 그리드의 전역옵션
       */
  constructor(id: string, options?: IGridGlobalOption);
  /**
       * @internal
       * @param erpNumberFormatType 
       */
  _setErpNumberFormatType(erpNumberFormatType: IERPNumberFormatType): void;
  setSkipGroupingChanged: any;
  setSkipSortingChanged: any;
  /**
       * @param owner 
       * @param gridWrapperId 
       * @param clientKey 클라이언트를 구분하기 위한 키값
       * @param pageAuthority 
       * @internal
       */
  _initialize(owner: OBTDataGrid, gridWrapperId: string, clientKey: string | null, options: InitializeOption): void;
  getUserCustomLayoutProcessor(): void;
  /**
       * @param erpNumberFormatType 
       * @internal
       */
  _setErpUserNumberFormat(erpNumberFormatType?: IERPNumberFormatType): void;
  setSelectMode(mode: 'block' | 'cell'): void;
  refreshContextMenu(): void;
  /**
       * 인자 그대로 컨텍스트 메뉴를 구성합니다. 
       * 그리드에서 기본적으로 제공되는 메뉴가 포함되지 않습니다. 
       * @param menuItems 
       */
  setCustomContextMenu(menuItems: any[]): void;
  /**
       * 컨텍스트 메뉴 설정
       */
  setContextMenu(additionalMenuItems?: any[], options: { position?: 'before' | 'after' } = { position: 'after' }): void;
  loadUserCustomLayout(option: { column?: boolean, group?: boolean, sort?: boolean, fixedColumn?: boolean } = { column: true, group: true, sort: true, fixedColumn: true }): void;
  /**
       * 컬럼 표시 기능으로 표시될수 있는 컬럼인지 판단한다.
       * @param columnNameOrColumn 
       * @returns 
       */
  isDisplayableColumn(columnNameOrColumn: string | IColumn): void;
  asTreeView(): ITreeViewMethod;
  formatNumberWithCommas(numberString: string): void;
  setOnExcelConverting(value: null | {
        showEmptyToZero: boolean
    }): void;
  convertValueOnExcelExport(column: IColumn, value: any): void;
  isUseSFormat(column: IColumn, rowIndex?: number): boolean;
  getInternalCellStyleManager(): void;
  /**
       * @param defaultRealGridColumn 
       * @param column 
       * @returns 
       */
  makeDecimalColumn(defaultRealGridColumn: any, column: IColumn): any;
  getMaskedValue(rowIndex: number, column: IColumn, value: string, withMasking?: boolean): string | null;
  /**
       * rowIndex, targetColumnName에 해당하는 셀의 다음 활성화된 셀 정보를 리턴한다.
       * @param rowIndex 
       * @param targetColumnName 
       */
  getNextActiveCell(rowIndex: number, targetColumnName: string): ICell | null;
  getNextActiveCellUsingIColumn(rowIndex: number, column: IColumn): ICell | null;
  /**
       * 호출시점의 컬럼정보를 분석해 초기정보를 저장하고
       * 사용자가 변경한 컬럼설정을 반영한다.
       * @returns 
       */
  endColumnSetting(): void;
  /**
       * 검색효율성을 위한 컬럼맵을 가져온다.
       * @internal
       */
  getColumnMap(): void;
  /** @internal */
  invokeEvent(event: ChaningEvent<(e: T) => void>, eventArgs: T, containData?: boolean, warnNotAllowAsync?: boolean): void;
  /**
       * 로우단위 유효성체크
       * @internal
       */
  checkRowValidation(rowIndex: number): RowValidationAlert;
  /**
       * SearchedItemSelectEventArgs 이벤트 invoke 함수
       * @param eventArgs 
       */
  invokeSelectEvent(eventArgs: Events.SearchedItemSelectEventArgs): void;
  invokeAlertEvent(eventArgs: Events.AlertEventArgs): void;
  /**
       * 지정한 셀이 수정가능한 마지막셀인지 체크한다.
       * @param columnName 
       * @param rowIndex 
       */
  isLastEditableColumn(columnName: string, rowIndex: number): void;
  /**
       * 지정한 셀이 보여지는 마지막셀인지 체크한다.
       * @param columnName 
       * @param rowIndex 
       */
  isLastVisibleColumn(columnName: string, rowIndex: number): void;
  /**
       * 지정한 셀이 보여지는 마지막셀인지 체크한다.
       * @param columnName 
       * @param rowIndex 
       */
  isLastVisibleColumnUsingIColumn(targetColumn: IColumn, rowIndex: number): void;
  /**
      * 특정 인덱스의 특정 컬럼이 수정 가능한지 여부를 리턴한다.
      * 컬럼세팅에 수정가능 여부가 지정되어있지 않으면 그리드 레벨의 수정가능 여부를 본다. 
       * @param targetColumn 
       * @param rowIndex 
       * @param columnName 
       */
  isColumnEditable(targetColumn: IColumn, rowIndex: number): boolean;
  /**
       * @param columnName 
       * @returns 
       */
  isColumnVisibleSingle(columnNameOrColumn: string | IColumn): boolean;
  isColumnVisible(columnName: string): boolean;
  /**
       * rowIndex의 행이 행 그룹 아이템인지 여부
       * @deprecated 제대로된 값을 리턴하지 않음 https://support.realgrid.com/tickets/no/2163
       * @param rowIndex 
       */
  isGroupItem(rowIndex: number): void;
  isEditing(): boolean;
  /**
       * 
       * @param use 
       */
  setFocusStyle(use: boolean): OBTDataGridInterface;
  /**
       * GlobalGridOption을 리턴한다.
       * 복사본을 리턴하기 때문에 리턴된 오브젝트의 값을 변경해도 그리드에는 영향이 없다.
       */
  getGridOption(): void;
  /**
       * 그리드옵션을 동적으로 조정한다.
       * 옵션중 할당되지 않은 값에는 디폴트값이 할당된다.
       * @param options 
       */
  setGridOption(options: IGridGlobalOption): OBTDataGridInterface;
  lockCellChangeTemplate(callback: Promise<void> | (() => Promise<void>)): Promise<void>;
  lockRowChangeTemplate(callback: Promise<void> | (() => Promise<void>)): void;
  /**
       * @internal
       */
  setLockRowSelectionChange(value: boolean): void;
  /**
       * @internal
       */
  setLockCellSelectionChange(value: boolean): void;
  /**
       * 
       * @param visible 
       */
  setIndicator(visible: boolean): OBTDataGridInterface;
  /**
       * GridView.setEditOptions를 이용해서 그리드 전체의 수정가능여부 설정
       * 각 컬럼별 editable 설정이 우선되며 별로도 세팅하지 않았을때 해당 값을 사용한다. 
       * @param editable 
       * @returns fluent api
       */
  setEditable(editable: boolean): OBTDataGridInterface;
  /**
       * 그리드 옵션의 디스플레이 옵션
       * @param option 
       */
  setDisplayOptions(option: IGridDisplayOption): OBTDataGridInterface;
  /**
       * 그리드 옵션 푸터 설정
       * @param visible 
       * @param footerCount  
       */
  setFooter(visible: boolean, footerCount?: number): OBTDataGridInterface;
  /**
       * 헤더 높이 설정
       * heightFill: 헤더의 높이 계산 방식을 지정하는 상수
       * default: 헤더의 높이를 자동으로 계산한다.
       * fixed: 헤더의 높이를 고정한다
       * @param option 
       * @see http://help.realgrid.com/api/types/Header/
       */
  setHeader(option: {
        height?: number,
        heightFill?: "heightFill" | "default" | "fixed",
        visible?: boolean,
        minHeight?: number,
        resizable?: boolean,
        filterable?: boolean,
        sortable?: boolean,
        subTextGap?: number,
        subTextLocation?: string,
        imageList?: string,
        itemOffset?: number,
        itemGap?: boolean,
        styles?: any,
        subStyles?: any,
        showTooltip?: boolean,
        summary?: boolean,
        tooltipEllipseTextOnly?: boolean,
    }, merge: boolean = false): OBTDataGridInterface;
  /**
       * 그리드의 마지막 행에서 엔터입력시 새로운 로우를 추가할 것인지 여부
       * @param appendable 
       */
  setAppendable(appendable: boolean): OBTDataGridInterface;
  setCheckBar(option: {
        /**
         * CheckBar의 너비를 픽셀 단위로 지정한다. 최소 너비는 1 픽셀이다.
         */
        width?: number,

        /**
         * checkBar.head 에 “v” 표시 여부를 지정한다.
         */
        showAll?: boolean,

        /**
         * 행 그룹핑시 그룹 헤더 영역에 체크박스 표시 여부를 지정한다.
         */
        showGroup?: boolean,

        /**
         * checkBar.head를 클릭하여 전체 선택시 보이는 행만 체크할 것인지의 여부를 지정한다.
         */
        visibleOnly?: boolean,

        /**
         * 체크 가능한 행만 체크할 수 있는지의 여부를 지정한다. (checkableExpression에서 체크 가능 여부를 지정할 수 있다.)
         */
        checkableOnly?: boolean,

        /**
         * CheckBar를 그리드에 표시할 것인지의 여부를 지정한다.
         */
        visible?: boolean,

        /**
         * 한 행만 체크 가능할지의 여부를 지정한다.
         */
        exclusive?: boolean,

        /**
         * 체크 가능 여부의 수식을 지정한다.
         */
        checkableExpression?: string,

        /**
         * 
         */
        headText?: string,

        /**
         * 
         */
        footText?: string,

        /**
         * 
         */
        headImageUrl?: string,

        /**
         * 
         */
        footImageUrl?: string,

        done?: (() => {}),

        stateStyles?: any,

        dynamicStyles?: IRealGridCellStyleOption[],

        checkImageUrl?: string,

        unCheckImageUrl?: string,

        // disableCheckImageUrl: string

        radioImageUrl?: string,

        headCheckImageUrl?: string,

        headUnCheckImageUrl?: string,

        /**
         * checkbox의 외곽라인을 여부를 지정한다.
         */
        drawCheckBox?: boolean,

        /**
         * true인 경우 데이터 영역의 전체 item 체크 상태가 CheckBar Head의 체크 상태가 연동된다.
         * ex) 데이터행의 모든 item이 체크되면 Head영역에도 자동으로 체크가 됨
         */
        syncHeadCheck?: boolean

    }): OBTDataGridInterface;
  setRowGroupOption(option: {
        expandedAdornments?: string,
        collapsedAdornments?: string,
        summaryMode?: ColumnSummaryExpression,
        cellDisplay?: string,
        headerStatement?: string,
        levelIndent?: number,
        mergeExpander?: boolean,
        mergeMode?: boolean,
        footerStatement?: string,
        footerCellMerge?: boolean,
        sorting?: boolean,
        levels?: any[],
        headerCallback?: (groupModel: any, grid: any) => void,
        createFooterCallback?: (grid, groupModel) => void,
    }): OBTDataGridInterface;
  /**
       * 체크모드 설정
       * gridView.setCheckBar
       * @param checkable 
       */
  setCheckable(checkable: boolean, showHeaderCheck: boolean): OBTDataGridInterface;
  /**
       * IColumn배열을 받아 필드에 할당하고 그리드뷰와 데이터프로바이더에 세팅한다.
       * _initialize된 상태에서만 리얼그리드에 컬럼을 세탕한다.
       * fluent api
       */
  setColumns(columns: IColumn[] | null): OBTDataGridInterface;
  /**
       * 필드 설정이 완료되고 순수 setColumns만 수행하는 메소드
       * @internal
       */
  _setColumnsInternal(columns: IColumn[]): OBTDataGridInterface;
  mapColumnToDefault(column: IColumn): void;
  buildColumns(columns: INewColumn[]): OBTDataGridInterface;
  buildColumn(column: INewColumn): OBTDataGridInterface;
  /** 
       * index나 컬럼명을 기반으로 컬럼을 제거한다.
       * index를 기반으로 할 경우 그룹 컬럼의 자식을 삭제할 수 없다.
       * @param indexOrName 
       */
  removeColumn(indexOrName: number | string): void;
  /**
       * 
       * @param index 
       * @param columns 
       */
  addColumn(index: number, ...columns: IColumn[]): void;
  /**
       * @internal
       */
  _groupBy(columnNames: string[]): void;
  /**
       * @internal
       * @param columnNames 
       * @param directions 
       */
  _orderBy(columnNames: string[], directions: string[]): void;
  orderBy(columnNames: string[], directions: string[]): void;
  /**
       *
       * @param columnNames 
       */
  groupBy(columnNames: string[]): void;
  /**
       * 프로바이더 세팅
       * @param provider 
       */
  setProvider(provider: IDataProvider | null): OBTDataGridInterface;
  /**
       * 컬럼의 width를 컨텐츠 사이즈에 맞춰 조정한다.
       * @param columnName? 적용할 컬럼이름
       * @param maxWidth?
       * @param minWidth?
       */
  fitColumnWidth(option?: { columnName?: string, maxWidth?: number, minWidth?: number, visibleOnly?: boolean }): void;
  /**
       * rowIndex의 height를 컨텐츠에 맞춰 조정한다.
       * @param rowIndex 
       * @param maxHeight 
       */
  fitRowHeight(itemIndex: number, maxHeight: number, textOnly: boolean = true, refresh: boolean = true): void;
  /**
       * 모든 행의 높이를 표시되는 데이터에 맞게 변경한다.
       * (* displayOptions.eachRowResizable: true로 지정되어 있어야 한다. multiLine인 경우 textWrap: “explicit”로 지정 )
       * * 데이터 행의 수가 많은 경우 브라우져에서 응답없음이 발생할 수 있으므로 주의해서 사용한다.* 
       * @param maxHeight 
       * @param textOnly 
       */
  fitRowHeightAll(maxHeight: number, textOnly: boolean = true): void;
  /**
       * 
       * @param rowIndex 
       * @param height 
       * @param refresh 
       */
  setRowHeight(rowIndex: number, height: number, refresh: boolean = true): void;
  /**
       * 
       * @param renderer 
       */
  addCellRenderers(renderer: any[]): void;
  /**
       * 그리드 컬럼설정에서 개발자가 설정한 콜백을 호출한다.
       * @internal
       * @param rowIndex 
       * @param columnName 
       * @param item 
       * @internal
       */
  _callAfterCodePickerCallback(rowIndex: number, columnName: string, items: any[] | CodePickerValue): void;
  /**
       * 그리드에 바인딩된 데이터의 길이를 리턴한다.
       * 주의: 트리 뷰(Tree View) 사용 시, 최상위 부모 행의 개수가 아닌 현재 펼쳐진(Visible) 전체 행의 개수를 반환합니다. 따라서 동일한 데이터라도 노드의 접힘/펼침 상태에 따라 결과값이 달라질 수 있습니다.
       * @returns 데이터의 길이(count)
       */
  getRowCount(): number;
  /**
       * 체크된 것이나 특정 GridState인 행의 인덱스 배열을 가져온다. 
       * [GridState]
       * @param options 가져오는 기준이되는 옵션
       */
  getRowIndexes(options?: { checkedOnly?: boolean, states?: GridState[] }): number[];
  // /**
      //  * 체크된 것이나 특정 GridState인 행의 데이터 배열을 가져온다.
      //  * @param options 가져오는 기준이 되는 옵션
      //  */
      // public getRows(options?: { checkedOnly?: boolean, states?: GridState[] }): any[] {
      //     if (!this.isReady) {
      //         throw new Error('OBTDataGridInterface.getRows: 그리드가 준비되지 않았습니다.');
      //     }
  
      //     let rows: any[] = [];
  
      //     if (options && Object.keys(options).length > 0) {
      //         const rowIndexes = this.getRowIndexes(options);
      //         return rowIndexes.map((rowIndex) => this._gridView.getValues(rowIndex));
      //     } else {
      //         if (this.gridOption.gridType === GridType.treeView) {
      //             rows = this._realGridProvider.getJsonRows(-1, true, '_rows');
      //         }
      //         else {
      //             rows = this._realGridProvider.getJsonRows(0, -1);
      //         }
      //     }
  
      //     return rows;
      // }
  
      /**
       * 체크된 것이나 특정 GridState인 행의 데이터 배열을 가져온다.
       * @param options 가져오는 기준이 되는 옵션
       */
  getRows(options?: { checkedOnly?: boolean, states?: GridState[], containCollapsed?: boolean, usePrivacyOriginField?: boolean }): any[];
  /**
       * 페이징 모드일때 모든 데이터를 가져온다.
       * @internal
       */
  getAllPageRows(options?: {
        showProgress?: boolean,
        setGridData?: boolean,
        cancelled?: boolean
    }): Promise<any[] | null | undefined>;
  /**
       * 그리드뷰에 정렬된 순서로 모든 데이터를 가져온다.
       * @param options 
       */
  getDisplayRows(options?: {
        checkedOnly?: boolean,
        states?: GridState[],
        /**
         * @deprecated withFormat 옵션을 사용하세요
         */
        containDisplayedValue?: boolean,
        withFormat?: boolean,
        containsFooter?: boolean,
        containsGroup?: boolean,
    }): any[];
  /**
       * 그룹컬럼과 해당 컬럼의 레벨을 리턴한다.
       */
  getGroupColumns(): void;
  /**
       * 그룹컬럼을 제외하고 순수 컬럼만을 가져온다.
       */
  toFlatColumns(columns: IColumn[], visibleOnly: boolean, containGroupColumn: boolean = false): IColumn[];
  /**
       * 그룹컬럼을 제외하고 순수 컬럼만을 가져온다.
       */
  getFlatColumns(visibleOnly: boolean = false, containGroupColumn: boolean = false): IColumn[];
  /**
       * 그룹컬럼을 제외하고 순수 컬럼만을 가져온다.
       * @internal
       */
  _getFlatColumns(targetColumnList: IColumn[], visibleOnly: boolean, containGroupColumn: boolean = false): IColumn[];
  /**
       * 파라미터로 준 인덱스의 행 데이터를 가져온다.
       * @param rowIndex 
       * @param options 
       */
  getRow(rowIndex: number, options?: GetValuesOption): any;
  /**
       * 파라미터로 준 인덱스의 행 데이터를 가져온다.
       * @param rowIndex 행의 인덱스
       * @param options 
       * @returns 데이터
       */
  getValues(rowIndex: number, options?: GetValuesOption): any;
  /**
       * 특정 셀의 데이터를 가져온다. option.withFormat은 성능 저하를 일으키니 필요한 케이스에서만 사용
       * 
       * @param rowIndex 
       * @param columnName 
       * @param option
       */
  getValue(rowIndex: number, columnName: string, option?: GetValueOption): any;
  /**
       * 다국어 컬럼의 모든 다국어 값을 리턴한다.
       * @param rowIndex 
       * @param columnName 
       * @returns 
       */
  getMultiLangValues(rowIndex: number, columnName: string): void;
  /**
       * 그리드에 세팅된 IColumn을 컬럼이름으로 검색해 가져온다.
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       * @returns 이름으로 찾은 IColumn이나 undefined
       */
  getColumnByName(columnName: string): IColumn | undefined;
  /**
       * setColums로 할당한 컬럼 정보를 리턴한다.
       */
  getColumns(): IColumn[];
  /**
       * unmanaged result 리얼그리드의 컬럼정보를 이름으로 가져온다.
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       * @returns 리얼그리드에서 관리되는 컬럼 속성
       */
  getRealGridColumnByName(columnName: string): any | null;
  hasDuplicatedName(columns: IColumn[]): { hasDuplicated: boolean, columnName: string | null };
  /**
       * IColumn을 기반으로 그리드에 컬럼을 세팅한다.
       * fluent api
       * @param column 세팅할 컬럼
       * @param merge column.name에 일치하는 기존의 컬럼을 column으로 할당한 값과 merge한다. (변경할 값만 업데이트)
       */
  setColumn(column: IColumn, merge?: boolean): OBTDataGridInterface;
  /**
       * itemIndex에 json object인 values로 행 데이터를 세팅한다.
       * 다른행에 포커스가 있을때 호출하면 행이동을 우선 수행한다.
       * 다른행으로 포커스 이동을 할 수 없을 때 데이터를 세팅하고 storeData를 호출한다.
       * @param rowIndex 행의 인덱스
       * @param values 데이터
       * @param moveRow 해당 셀로 셀 선택을 이동시킨다. [default: true] 
       */
  setValues(rowIndex: number, values: any, moveRow: boolean = true): void;
  /**
       * 특정 셀의 데이터를 세팅한다.
       * editable이 가능한 셀이 아니면 false를 리턴하고 동작을 수행하지 않는다.
       * 다른셀에 포커스가 있을때 호출하면 셀 이동을 우선 수행한다. (moveRow = false로 사용하지 않을수 있음)
       * BeforeChange와 ValidateChange에서 cancel되었는지 여부를 리턴한다.
       * lockCellChangeTemplate, lockRowChangeTemplate 동작을 취소시킨다.
       * @param rowIndex 가져올 데이터의 행
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       * @param value 바인딩할 데이터
       * @param moveRow 해당 셀로 셀 선택을 이동시킨다. [default: true] 
       */
  setValue(rowIndex: number, columnName: string, value: any, moveRow: boolean = true, options?: {
        usePrivacyOriginField?: boolean;
        langCode?: 'auto' | string;
    }): boolean;
  setValueAsync(rowIndex: number, columnName: string, value: any, moveRow: boolean = true, options?: {
        usePrivacyOriginField?: boolean;
        langCode?: string;
    }): void;
  /**
       * @internal
       */
  setValueUnmanaged(rowIndex: number, columnName: string, value: any, options?: {
        langCode?: string;
    }): void;
  /**
       * BeforeChange와 ValidateChange 이벤트를 무시한 setValue
       * @param rowIndex 가져올 데이터의 행
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       * @param value 바인딩할 데이터
       */
  setValueInternal(rowIndex: number, columnName: string, value: any, options?: {
        langCode?: string;
    }): void;
  /**
       * 리얼그리드 내부에 아이콘 식으로 사용할 이미지 리스트를 등록한다.
       *  iconPathList는 columnName + '_image'의 키값으로 저장된다.
       * @internal
       * @param columnName 적용할 컬럼이름, 아이콘세트 이름의 기준이된다.
       * @param iconPathList 아이콘경로리스트
       * @internal
       */
  registerColumnImageList(columnName: string, iconPathList: string[]): void;
  /**
       * styleId를 추가한다.
       * @param styleId id
       * @param style 스타일 오브젝트
       */
  addCellStyle(styleId: string, style?: IRealGridCellStyleOption): void;
  _addCellStyleUsingRealGrid(styleId: string, style?: IRealGridCellStyleOption): void;
  /**
       * 특정 셀에 addCellStyle로 지정한 styleId를 지정한다.
       * 여기서 지정된 속성은 다이나믹 스타일보다 우선됨
       * @param rowIndex 
       * @param columnName 
       * @param styleId 적용할 styleId
       */
  setCellStyle(rowIndex: number, columnName: string, styleId: string, updateNow?: boolean): void;
  /**
       * 특정 로우에 addCellStyle로 지정한 styleId를 지정한다.
       * 여기서 지정된 속성은 다이나믹 스타일보다 우선됨
       * @param rowIndex 
       * @param columnName 
       * @param styleId 적용할 styleId
       */
  setRowStyle(rowIndex: number, styleId: string): void;
  /**
       * styleId를 제거한다. 적용된 스타일도 제거됨
       * @param styleId 
       */
  removeCellStyle(styleId: string): void;
  /**
       * 그리드에 빈 행을 추가한다.
       * BeforeAddRow, AfterAddRow 이벤트를 발행한다.
       * @param rowIndex 데이터를 추가할 위치
       */
  addRow(rowIndex?: number, dataRowValues?: any): void;
  isEmptyDataItem(dataItem: any): void;
  /**
       * 
       * @param parentRowIndex 
       * @param childRowIndex 
       */
  addTreeRow(parentRowIndex: number = -1, childRowIndex: number = -1): void;
  /**
       * 체크스테이트를 검사해 변경된 데이터가 있는지 여부를 리턴한다.
       * @returns 변경된 데이터가 있는지 여부
       */
  hasDirtyData(): boolean;
  /**
       * 데이터 커밋
       */
  commit(): void;
  /**
       * unmanaged result
       * header 정보 리턴
       */
  getHeader(): any;
  /**
       * 특정 인덱스 체크처리
       * @param rowIndex 
       * @param checked 
       */
  setCheck(rowIndex: number, checked: boolean, invokeEvent?: boolean): void;
  /**
       * 특정 인덱스의 행이 체크되어있는지 여부를 리턴한다.
       * @param rowIndex 
       */
  isCheckedRow(rowIndex: number): boolean;
  /**
       * 특정 인덱스의 행이 체크되어있는지 여부를 리턴한다.
       * @param rowIndex 
       */
  getCheck(rowIndex: number): boolean;
  /**
       * 특정 인덱스의 행이 체크가능 여부를 세팅한다.
       * @param rowIndex 
       * @param checkable 
       */
  setRowCheckable(rowIndex: number, checkable: boolean): void;
  /**
       * 특정 인덱스의 행이 체크가능한지 여부를 리턴한다.
       * @param rowIndex 
       */
  isRowCheckable(rowIndex: number): boolean;
  /**
       * 조회된 모든 행들을 체크처리한다.
       * @param rowIndex 
       */
  checkAll(): void;
  /**
       * 조회된 모든 행들을 언체크처리한다.
       * @param rowIndex 
       */
  unCheckAll(): void;
  /**
       * REMARK: useTotalToEmpty
       * 페이징 그리드에서 체크청보를 리턴한다.
       * getTotalSelectValue
       */
  getTotalSelectValue(): {
        isTotalSelect: boolean,
        value: Object[] | null,
        exceptValue: Object[] | null,
    };
  /**
       * 그리드에서 체크된 로우를 가져온다.
       */
  getCheckedRows(containCollapsed?: boolean): any[];
  getUnCheckedRows(checkableOnly?: boolean): any[];
  /**
       * 체크한 인덱스 가져오기
       */
  getCheckedIndexes(): number[];
  /**
       * rowIndex의 스테이트를 가져온다.
       * @param rowIndex 
       */
  getState(rowIndex: number): GridState | null;
  /**
       * rowIndex의 스테이트를 state로 설정한다.
       * @param rowIndex 
       * @param state 
       */
  setState(rowIndex: number, state: GridState, noCheckBeforeState = false): void;
  /**
       * 선택한 행의 로우를 삭제한다.
       * 여러개의 로우를 한번에 삭제할때는 removeRows를 사용
       * @param rowIndex 
       */
  removeRow(rowIndex: number, options?: { focus?: boolean, soft?: boolean }): void;
  /**
       * 여러건의 로우를 한번에 삭제한다. 
       * @param rowIndexes 
       */
  removeRows(rowIndexes: number[], options?: { focus?: boolean, soft?: boolean }): Promise<void>;
  /**
       * getFocusedIndex 폐기 예정인 API입니다. getSelectedIndex를 대신 사용해주세요
       * @internal
       * @deprecated 
       */
  getFocusedIndex(): number;
  /**
       * 선택된 로우의 인덱스를 가져온다.
       */
  getSelectedIndex(): number;
  /**
       * getFocusedColumnName 폐기 예정인 API입니다. getSelectedColumnName를 대신 사용해주세요
       * @internal
       * @deprecated
       */
  getFocusedColumnName(): string;
  /**
       * '선택된 컬럼의 이름을 가져온다.'
       */
  getSelectedColumnName(): string;
  /**
       * getFocusedRow 폐기 예정인 API입니다. getSelectedRow를 대신 사용해주세요
       * @internal
       * @deprecated
       */
  getFocusedRow(): any;
  /**
       * 선택되어있는 행의 데이터를 가져온다.
       */
  getSelectedRow(): any;
  /**
       * 특정 셀 선택.
       * 포커스까지 옮기지는 않는다.
       * @param rowIndex 
       * @param columnNameOrFieldIndex 
       */
  setSelection(rowIndex: number, columnNameOrFieldIndex?: string | number): void;
  /**
       * 현재 선택된 데이터
       * @returns { rowIndex: 선택되어있는 인덱스, columnName: 선택되어있는 컬럼이름}
       */
  getSelection(): ICell;
  /**
       * 그리드뷰에 포커스를 준다.
       */
  focus(): void;
  /**
       * 현재 페이징 정보 조회
       */
  getPagingInfo(): Pagination | undefined;
  readRow(rowIndex: number): void;
  /**
       * 데이터를 읽어 그리드에 바인딩한다.
       * @param readCallback 
       */
  readData(readCallback?: Read): Promise<any[]>;
  resolveColumnDecimalInfo(column: IColumn, rowIndex?: number): void;
  toFixedDecimal(decimal: Decimal, decimalLength: number, lastCutType: number | null): void;
  /**
       * use applyInternalCellStyleByRowIndex
       * 
       * rowIndex에 체크펜등 내부적인 셀 스타일을 적용한다.
       * @deprecated
       * @param rowIndex 
       */
  applyInternalCellStyle(rowIndex: number, options?: {
        columns?: IColumn[],
        selectedRow?: boolean,
        applyNothingStyle?: boolean,
    }): void;
  /**
       * @internal
       */
  makePagination(): Promise<Pagination>;
  refreshCellStyle(): void;
  /**
       * @internal
       * @param readCallback 
       */
  _appendPagingData(readCallback?: Read): void;
  /**
       * 특정 컬럼을 보여준다. visible이 false로 지정된 컬럼에 대해서만 영향이 있다.
       * 보여지지 않는다고해서 required, unique의 유효성 체크가 무시되는것은 아님
       * @param columnName 
       */
  showColumn(columnName: string): void;
  /**
       * 특정 컬럼을 숨간다. 
       * 보여지지 않는다고해서 required, unique의 유효성 체크가 무시되는것은 아님
       * @param columnName 
       */
  hideColumn(columnName: string): void;
  /**
       * 컬럼의 활성화 여부를 지정한다. 
       * 컬럼이 비활성화 될 경우 화면상에서 보이지 않게되며 [컬럼표시] 기능으로 컨트롤 할수 없게된다.
       * 
       * @param nameOrColumn 적용할 컬럼명
       * @param active 활성화 여부
       */
  setColumnActive(nameOrColumn: string | IColumn, active: boolean): void;
  /**
       * 특정 컬럼 보여지는지 여부 지정.
       * 보여지지 않는다고해서 required, unique의 유효성 체크가 무시되는것은 아님
       * 
       * @param nameOrColumn 
       * @param isVisible 
       */
  setColumnVisible(nameOrColumn: string | IColumn, isVisible: boolean): void;
  /**
       * @internal
       * @param columnName 
       * @param property 리얼그리드의 property를 의미함
       * @param value 
       */
  setColumnProperty(columnName: string, property: string, value: any): void;
  /**
       * @internal
       * @returns 현재 페이지 넘버
       */
  getCurrentPageNumber(): number;
  /**
       * 특정 컬럼의 데이터에 대한 집계값을 리턴한다.
       * @param columnName 컬럼이름
       * @param expression 지정되어있는 표현식중 하나
       */
  getSummary(columnName: string, expression: ColumnSummaryExpression): number;
  setLookups(lookups: any[]): void;
  fillLookupData(lookupKey: string, data: { rows: [] }): void;
  /**
       * rowIndex에 checkPenRGB 세팅하고 저장
       * @internal
       */
  storeCheckPen(rowIndex: number, checkPenRGB: string): void;
  /**
       * rowIndex에 memoCode 세팅하고 저장
       * @internal
       */
  storeMemo(rowIndex: number, memoCode: string | null): void;
  getUseBulkInsert(): void;
  setUserBulkInsert(useBulkInsert: boolean): void;
  /**
      * 더티 데이터를 추려내 존재한다면 provider의 store를 호출한다.
      * 삭제시엔 특정로우 지정해서 처리하지 말것
      * @param rowIndex 
      * @param storeCallback 
      */
  storeData(option?: { rowIndex?: number, store?: Store, removeRowsMode?: boolean, bulk?: boolean }): void;
  /**
       * 그리드 클리어
       */
  clearData(): void;
  setColumnHeaderCheck(columnName: string, checked: boolean): void;
  /**
       * 
       * @param refresh RealGrid refresh 호출 여부 default true
       */
  refresh(refresh: boolean = true): void;
  refreshGridView(): void;
  /**
       * 푸터를 갱신한다.
       * @param column 
       */
  refreshFooter(column: IColumn): void;
  /**
       * @returns 엑셀 변환 컬럼목록 저장 스토리지키  
       */
  getExcelExportStorageKey(): void;
  /**
       * 엑셀 익스포트
       * @link http://help.realgrid.com/api/types/GridExportOptions/
       * @param exportOption 리얼그리드의 GridView.exportGrid 함수의 옵션
       */
  exportExcel(exportOption?: any): void;
  /**
       * @deprecated searchCell 함수를 이용해 주세요.
       */
  searchData(startIndex: number, columnNamesForSearch: string[] | null, value: string, selectSearchedCell: boolean, partialMatch: boolean): ICell | null;
  /**
       * 데이터 검색
       * @param startIndex 검색시 시작 인덱스
       * @param columnNamesForSearch 
       * @param value 
       * @param partialMatch 
       */
  searchCell(option: {
        startIndex: number,
        startFieldIndex: number,
        columnNames: string[] | null,
        value: string,
        selectSearchedCell: boolean,
        partialMatch: boolean,
        caseSensitive: boolean
        wrap?: boolean,
    }): ICell | null;
  /**
       * 키에 해당하는 로우 데이터 가져오기
       * @param keyColumnName 
       * @param key 
       */
  getRowByKey(keyColumnName: string, key: string): void;
  /**
       * 키에 해당하는 셀 선택
       * @param keyColumnName 
       * @param key 
       */
  selectByKey(keyColumnName: string, key: string): void;
  setCheckByKey(keyColumnName: string, key: string, check: boolean, invokeEvent?: boolean): void;
  getCheckByKey(keyColumnName: string, key: string): void;
  /**
       * 접혀있는 자식노드를 모두 연다.
       */
  expandAll(): void;
  /**
       * TreeGrid 전용 
       * @param rowIndex 행 인덱스
       * @param recursive 하위의 모든 자식들을 열것인지 여부
       * @param force 
       */
  expand(rowIndex: number, recursive?: boolean, force?: boolean): void;
  /**
       * TreeGrid 전용 
       * @param rowIndex 행 인덱스
       * @param recursive 하위의 모든 자식들을 접을것인지 여부
       */
  collapse(rowIndex: number, recursive?: boolean): void;
  /**
       * TreeGrid 전용 
       * 모든 자식노드들을 접는다.
       */
  collapseAll(): void;
  /**
       * realGrid fillJsonData
       * @param data
       * @param option 
       */
  fillJsonData(data: any[], option: any): void;
  /**
       * rowIndex나 rowId를 이용해 가르키는 행의 자식행의 갯수를 리턴.
       * @param rowIndex 
       * @returns 
       */
  getChildCount(rowIndex: number | { rowId?: number, rowIndex?: number }): number | null;
  /**
       * 해당 인덱스의 행이 자식을 가지고 있는지 여부리턴
       * @param rowIndex 행 인덱스
       * @returns 자식을 가지고 있는지 여부
       */
  hasChildren(rowIndex: number): boolean;
  /**
       * TreeGrid 전용 
       * @param rowIndex 행 인덱스
       * @returns 자식 행의 모든 인덱스 
       */
  getChildrenIndexes(rowIndex: number): number[];
  /**
       * TreeGrid 전용 
       * 부모의 인덱스를 가져온다.
       * 부모가 없다면 null;
       * @param rowIndex 
       * @returns 부모의 인덱스
       */
  getParentIndex(rowIndex: number): number | null;
  /**
       * TreeGrid 전용 
       * 특정 인덱스의 자식행 체크여부 제어
       * @param rowIndex 
       * @param checked 
       * @param recusive 
       */
  checkChildren(rowIndex: number, checked: boolean, recusive: boolean): void;
  /**
       *
       * @param wrapperHeightPx 
       */
  getBodyAreaHeight(wrapperHeightPx: number): number;
  /**
       *
       * @param wrapperHeightPx 
       */
  getHeaderHeight(): number;
  /**
       *
       * @param wrapperHeightPx 
       */
  getFooterHeight(): number;
  /**
       * columnName의 헤더 텍스트를 가져온다.
       * @param columnName 
       */
  getHeaderText(columnName: string): string;
  /**
       * columnName의 헤더 텍스트를 가져온다.
       * @param columnName 
       */
  getHeaderTextUsingIColumn(column: IColumn): string;
  setRowChangeAfterCheck(value: boolean): void;
  handleEditCanceled(grid: any, index: any): void;
  isValidDate(dataString: string, format: DateFormat = DateFormat.yyyyMMdd, column: IColumn): boolean;
  /**
       * @interface
       * @param value
       * @deprecated 
       */
  isEmptyValue: any;
  getColumnRequired(column: IColumn, rowIndex?: number): boolean;
  getColumnReaonly(column: IColumn, rowIndex?: number): boolean;
  /**
       * 리얼그리드 onInnerDragStart 이벤트 콜백
       * false를 지정하면 드래그가 취소된다.
       * @internal
       */
  handleInnerDragStart(grid: any, dragCells: any): boolean;
  /**
       * 리얼그리드 onInnerDrop 이벤트 콜백
       * @internal
       */
  handleInnerDrop(grid: any, dropIndex: any, dragCells: any): void;
  setUnFixedColumn: any;
  setFixedColumn: any;
  setFixedColumnByCount: any;
  /**
       * true로 설정할시 페이징 스크롤이 동작하지 않는다.
       * @param value 
       */
  setLockScrollPaging(value: boolean): void;
  /**
       * 스크롤 한번만 잠그기. 스크롤 이벤트에서 lockScrollPaging이 true일 때 스크롤을 고정하는 용도
       */
  preserveScrollOnce(): void;
  resetUserCustomColumn(): void;
  setColumsByColumnChangeInfo(columnChangeInfo: any[]): void;
  _invokeColumnWidthChangedWhenResize(): void;
  _invokeCustomLayoutChanged(): void;
  _invokeCustomLayoutReset(columns: IColumn[]): void;
  /**
       * 코드피커 데이터 조회
       * @param rowIndex 
       * @param columnName 
       * @param keyword 
       * @returns 
       */
  getCodePickerSearchResult(rowIndex: number, columnName: string, keyword?: string): void;
  /**
       * 코드피커 다이얼로그를 연다.
       * @param rowIndex 
       * @param columnName 
       */
  callCodePickerDialog(rowIndex: number, columnName: string, keyword?: string): void;
  getDateDialogPosition(): void;
  setDateDialogPosition(dateDialogPosition: {
        align: AlignType,
        position: PositionType
    }): void;
  /**
       * @internal
       */
  _changeCodePickerState(columnName: string, state: "search" | "unbinded" | "binded"): void;
  /**
       * @internal
       */
  _handleFocus(): void;
  /**
       * @internal
       */
  _handleBlur(wrapperRef: any): void;
  getKeyDownForSelectionChange(): void;
  /**
       * labelText를 기반으로 리얼그리드의 이미지버튼으로 사용될 수 있는 버튼오브젝트를 생성한다. 
       * @param buttonName 
       * @param width 
       * @param labelText 
       */
  generateImageButton(buttonName: string, width: number, labelText: string): void;
  updatePrivacy(rowIndex: number, columnName: string, updatePrivacyValue: string, column?: IColumn): void;
  isPrivacyEnabled(): boolean;
  isUsePrivacy(columnName: string, column?: IColumn): boolean;
  getPrivacyBehavior(columnName: string, column?: IColumn, rowIndex?: number, privacyType?: string, options?: {
        ignorePrivacyAlwaysEnabled: boolean
    }): PrivacyBehaviorEnum;
  getPrivacyOriginValue(rowIndex: number, columnName: string, column?: IColumn): string | undefined | null;
  getPrivacyModifiedValue(rowIndex: number, columnName: string, column?: IColumn): any;
  setPrivacyModifiedValue(rowIndex: number, columnName: string, modifiedValue: string, column?: IColumn): void;
  getPrivacy(rowIndex: number, columnName: string, column?: IColumn): Privacy | undefined;
  getPrivacyKey(rowIndex: number, columnName: string): string | undefined | null;
  getPrivacyValues(e: {
        rowIndexes: number[],
        columns: IColumn[],
        accessType: 'read' | 'download' | 'print' | 'program',
        force?: boolean,
        cancellation?: () => boolean,
        readCallback?: (e: { rowIndex: number, column: IColumn, privacy: Privacy }[]) => void,
        privacyBehavior?: PrivacyBehaviorEnum
    }): Promise<void>;
  getPrivacyValue(rowIndex: number, columnName: string, column?: IColumn): Promise<string | undefined | null>;
  retrievePrivacies(columnNames?: string[]): Promise<void>;
  clearRetrievePrivacies(): void;
  isRetrievePrivacies(): void;
  getPrivacyComponentHandler: any;
  isPrivacyMaskedComponentHandler: any;
  suspendLoading(): void;
  resumeLoading(): void;
  showProgress(options: IShowProgressOptions): void;
  setProgress(options: ISetProgressOptions): void;
  hideProgress(): void;
  /**
       * 인쇄 지원함수 (기존 다이얼로그 호출 기반 인쇄용 데이터 추출 함수)
       */
  getPrintRows(options?: {
        appendHeader?: boolean,
        checkedRows?: boolean,
        useMasking?: boolean,
        readAllPages?: boolean
        exceptRowIndexes?: number[]
    }): void;
  /**
       * 인쇄 지원함수 (특정 행들만 지정하여 인쇄용 데이터를 추출하는 함수)
       */
  getPrintRowsByRowIndexes(options?: {
        appendHeader?: boolean,
        useMasking?: boolean,
        rowIndexes?: number[],
    }): void;
  getHtml(): void;
  copyClipboard(): void;
  openOneAiDataAnalysis(): void;
  invokeAiDataEvent(e: {
        columns: any,
        rows: { [name: string]: any }[]
    }): void;
  executeContextMenu(contextMenuId: 'excel' | 'column' | 'fixedColumn' | 'unfixedColumn' | 'unsort' | 'find' | 'collapseLevel' | 'expandLevel' | 'oneAiAnalysis' | 'copyClipboard' | string): void;
  openCalculator(): void;
  autoPrint(): void;
}

import { IPageAuthority } from 'luna-orbit/OBTPageContainer/OBTPageContainer';
export interface IPageAuthority {
    /**
     * 조회권한입니다.
     */
    selectAuthType: 'NO' | 'G' | 'C' | 'B' | 'D' | 'U',
    /**
     * 수정권한입니다.
     */
    modifyAuthYn: "Y" | "N",
    /**
     * 삭제권한입니다.
     */
    deleteAuthYn: "Y" | "N",
    /**
     * 인쇄권한입니다.
     */
    printAuthYn: "Y" | "N",
}

```
