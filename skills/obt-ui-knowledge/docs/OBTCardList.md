# OBTCardList

데이터소스를 가로배열되는 카드형태로 표시합니다. 
데이터의 조회부터 조작등 대부분의 기능은 interface props에 할당된 객체를 이용합니다.

```tsx
import { OBTCardList, OBTCardListProps, OBTCardListMethods } from 'luna-orbit';

export interface OBTCardListProps {
  /**
   * OBTCardList의 데이터를 관리하고 조작하는 모든 기능을 담고있는 객체입니다.
   * @required 
   */
  interface: OBTCardListInterface;

  /**
   */
  pageAuthority?: IPageAuthority;

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

}

export interface OBTCardListMethods {
  /**
   */
  isPrivacyEnabled(): boolean;

}

// --- Referenced Types ---

import { OBTCardListInterface } from 'luna-orbit/OBTCardList/OBTCardListInterface';
class OBTCardListInterface {
  ///////////////////////////////////////////////////////////////////////////// PropDefinition
  PropDefinitions: any;
  ////////// 템플릿 타입 //////////
  
      /**
       * 카드리스트의 템플릿 속성입니다.
       */
  Template: any;
  ///////////////////////////////////////////////// Events //////////////////////////////////////////////////////
  
      /**
       * 셀 선택이 바뀌기 전에 발생하는 이벤트 
       * [BeforeSelectChangeEventArgs]
       */
  onBeforeChangeRowSelection: any;
  /**
       * 셀선택이 바뀐 이후에 발생하는 이벤트
       * [AfterSelectChangeEventArgs]
       */
  onAfterChangeRowSelection: any;
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
       * 셀의 데이터가 변경된 이후에 발생하는 이벤트
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
       * 데이터를 읽은 후에 호출되는 이벤트
       * [AfterReadEventArgs]
       */
  onAfterRead: any;
  /**
       * 데이터, 체크등 내부의 데이터가 변경될때 호출
       * [AfterDataChangeEventArgs]
       */
  onAfterDataChanged: any;
  /**
       * PageContainer에서 Drawer를 보여줘야 되는 상황에서 호출되는 이벤트
       * [DrawerEventArgs]
       */
  onDrawer: any;
  /**
       * 데이터 state가 change 되었을 때 호출되는 이벤트
       * [AfterStateChangeEventArgs]
       */
  onAfterStateChange: any;
  /**
       * 데이터 sort가 change 되었을 때 전에 호출되는 이벤트
       * [BeforeSortChangeEventArgs]
       */
  onBeforeSortChange: any;
  /**
       * 데이터 sort가 change 된 후에 호출되는 이벤트
       * [AfterSortChangeEventArgs]
       */
  onAfterSortChange: any;
  /**
       * 추가버튼 클릭했을 때 호출되는 이벤트
       * [AddButtonClickEventArgs]
       */
  onAddButtonClicked: any;
  /**
       * readData시 data가 없을 때 호출되는 이벤트
       * [emptyDataEventArgs]
       */
  onDisplayEmptySet: any;
  /**
       * readData시 data가 없을 때 호출되는 이벤트
       * [emptyDataEventArgs]
       */
  onItemClick: any;
  /**
       * 항목이 더블 클릭 되었을 떄 호출되는 이벤트
       */
  onItemDoubleClick: any;
  /**
       * 개인정보 암호화 - 개인정보 조회 이벤트
       */
  onGetPrivacy: any;
  /**
       * 개인정보 암호화 - 개인정보 조회 완료 이벤트
       */
  onPrivacyRetrieved: any;
  /**
       * tab키를 입력하여 포커스 이동시킬 시에 호출되는 이벤트
       */
  onMoveFocusByTab: any;
  /**
       * @internal
       * dataAdapter()
       * OBTCardList - 사용할 get함수
       */
  get dataAdapter(): any;
  /**
       * @internal
       * dataAdapter()
       * OBTCardList - 사용할 set함수
       */
  set dataAdapter(dataAdapter);
  /**
       * @internal
       * cardListTemplate()
       * OBTCardList - 사용할 get함수
       */
  get cardListTemplate(): any;
  /**
       * @internal
       * appendButton()
       * OBTCardList - 사용할 get함수
       */
  get addButton(): any;
  /**
       * @internal
       * listHeight()
       * OBTCardList - 사용할 get함수
       */
  get listHeight(): any;
  /**
       * @internal
       * headerCheckVisible()
       * OBTCardList - 사용할 get함수
       */
  get headerCheckVisible(): any;
  /**
       * @internal
       * checkable()
       * OBTCardList - 사용할 get함수
       */
  get checkable(): any;
  /**
       * @internal
       * _disabledCheckProperty
       * OBTCardListInterface 내부 사용
       */
  _disabledCheckProperty: string;
  /**
       * @internal
       * disabledCheckProperty()
       * OBTCardList - 사용할 get함수
       */
  get disabledCheckProperty(): any;
  /**
       * @internal
       * headerClassName()
       * OBTCardList - 사용할 get함수
       */
  get headerClassName(): any;
  /**
       * @internal
       * headerComponent()
       * OBTCardList - 사용할 get함수
       */
  get headerComponent(): any;
  /**
       * @internal
       * onRenderItem()
       * OBTCardList - 사용할 get함수
       */
  get onRenderItem(): any;
  /**
       * @internal
       * onRenderItem()
       * OBTCardList - 사용할 set함수
       */
  set onRenderItem(onRenderItem);
  setModuleCode: any;
  setFetch: any;
  setPageAuthority: any;
  /**
       * @internal
       * data()
       * OBTCardList - 사용할 get함수
       */
  get data(): any;
  /**
       * @internal
       * sortList()
       * OBTCardList - 사용할 get함수
       */
  get sortList(): any;
  /**
       * @internal
       * data()
       * OBTCardList - 사용할 get함수
       */
  get dropDownValue(): any;
  /**
       * @internal
       * displayType()
       * OBTCardList - 사용할 get함수
       */
  get displayType(): any;
  get useCheckPen(): any;
  set useCheckPen(useCheckPen: boolean);
  /**
       * @internal
       * page
       * true, false 일지
       */
  get paging(): any;
  /**
       * @internal
       * 현재페이지
       */
  get currentPage(): any;
  /**
       * @internal
       * 페이지갯수
       */
  get pageCount(): any;
  /**
       * @internal
       * 그리드의 보여줄 로우 갯수
       */
  get rowCountPerPage(): any;
  /**
       * @internal
       * 페이징시 페이지버튼 우측에 있는 로우 갯수 지정할 수 있는 드롭다운 커스텀 
       */
  get customRowCountDropDownList(): any;
  /**
       * @internal
      * 페이징의 총 데이터 갯수
      */
  get totalCount(): any;
  /**
       * @internal
       * radius
       */
  get borderRadius(): any;
  /**
       * @internal
       * itemPadding
       */
  get itemPadding(): any;
  /**
       * @internal
       * emptySet 속성
       */
  get emptySet(): any;
  /**
       * @internal
       * emptyImgText 속성
       */
  get emptyImgText(): any;
  get privacyColumns(): any;
  get memoCategory(): any;
  /**
       * 메모 키를 생성하는 콜백 함수입니다.
       * @param {Object} e 
       * @param {number} e.rowIndex
       * @param {OBTCardListInterface} e.cardList
       * @returns {string} - 메모 키는 string 타입으로 반환하며 36자리를 초과할 수 없습니다.
       */
  getMemoKey(e: { rowIndex: number, cardList: OBTCardListInterface }): void;
  get reservedColumnNames(): any;
  /**
       * 카드리스트의 생성자 입니다.
       */
  constructor(options: {
        /**
         * Read(), Store() 사용할 속성입니다. 
         */
        dataAdapter: IDataAdapter,
        /**
         * 행 추가 설정입니다. 
         * ( default : false )
         */
        appendable?: boolean,
        /**
         * Tamplete 기본 형식으로 사용합니다. 
         * (단. listHeight 무시, onRenderItem 무시)
         */
        cardListTemplate?: ICardListTemplate,
        /**
         * 사용자가 직접 Tamplete 만들시 각 List의 높이 설정 
         * (단. cardListTemplate 사용 시 listHeight : 50 고정 )
         */
        listHeight?: number,
        /**
         * 사용자가 직접 Tamplete을 만들시 
         * div스타일 및 데이터 설정 
         * (단. cardListTemplate 있을 시 무시 )
         */
        onRenderItem?: onRenderItem,
        /**
         * 헤더 체크박스 설정
         * ( default : false )
         */
        headerCheckVisible?: boolean,
        /**
         * list 체크박스 설정
         * ( default : false )
         */
        checkable?: boolean,
        /**
         * 아이템의 체크상태를 비활성화 시킬 수 있는 키값으로 사용할 string지정
         */
        disabledCheckProperty?: string,
        /**
         * 헤더 엘리먼드 들어갈 콤퍼넌트 속성입니다.
         */
        headerComponent?: React.ReactElement | (() => React.ReactElement),
        /**
         * 헤더 부분 스타일 수정할 수 있는 속성입니다.
         */
        headerClassName?: string,
        /**
         * 카드리스트의 페이징 사용여부
         */
        paging?: boolean,
        /**
         * 카드리스트의 보여줄 로우 갯수 기본 : 10 | 20 | 30 | 40 | 50
         */
        rowCountPerPage?: number,
        /**
         * 페이징시에 페이지버튼 우측 로우 갯수 지정할 수 있는 드롭다운 커스텀
         */
        customRowCountDropDownList?: Array<any>,
        /**
         * Add 카드리스트 템플릿 (추가)
         */
        appendButton?: IAddButton,
        /**
         * border-radius 카드리스트 스타일
         */
        borderRadius?: string,
        /**
         * Item-padding 카드리스트 padding (입체효과)
         */
        itemPadding?: IItemPadding,
        /**
         * 개인정보 암호화 적용 컬럼목록
         */
        privacyColumns?: string[],
        /**
         * 개인정보 암호화 강제 적용
         */
        forceEnablePrivacy?: boolean,
        /**
         * 메모의 카테고리
         */
        memoCategory?: string,
        /**
         * 메모 키를 생성하는 콜백 함수
         */
        getMemoKey?: (e: { rowIndex: number, cardList: OBTCardListInterface }) => string | undefined,
        /**
         * 
         */
        reservedColumnNames?: {
            memoCode: string;
            checkPen: string;
            insertDateTime: string;
            insertIPAddress: string;
            insertUserId: string;
            modifiedIPAddress: string;
            modifyDateTime: string;
            modifyUserId: string;
        }
    });
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Functions
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////초기 함수////////////////////////////////////////////////////////////////////////////
  
      /**
       * CardList 초기값 세팅
       * setHeaderCheckVisible(visible) : 카드리스트에 체크리스트 보여주기 여부 속성입니다.
       * @param {boolean} visible
       */
  setHeaderCheckVisible(visible: boolean): OBTCardListInterface;
  setCheckable(checkable: boolean, showHeaderCheck: boolean): OBTCardListInterface;
  /**
       * CardList 초기값 세팅
       * setSort(value, sortList) : 카드리스트에 SortList (상단 드랍다운리스트) 정렬 여부 속성입니다.
       * @param {string} index
       * @param {Array<IDropList>} sortList
       * @param {json} options (선택) { displayType?: DisplayType }
       */
  setSort(index: string, sortList: Array<Events.IDropList>, options?: { displayType?: DisplayType, comparer?: (sortItem: Events.IDropList, a: any, b: any) => number }): OBTCardListInterface;
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////권한 설정 함수////////////////////////////////////////////////////////////////////////////////
  
      /**
       *  @internal
       * CardList 권한값 설정
       * 1. appendable() : 사용자설정에 따라 addRow()
       */
  get appendable(): boolean;
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////////// 사용자 제공함수///////////////////////////////////////////////////////////////////////
      /**
      * Function() : Row
      * getRowCount() : 카드 리스트에서 전체 Row 수를 가지오는 함수입니다.
      */
  getRowCount(): number;
  /**
     * Function() : Row
     * getRowIndexes() : 카드 리스트에서 Row에 해당하는 index들을 가지오는 함수입니다.  
     * @param {json} options (선택) 
     * 1. checkedOnly : 체크된 index 가져오기
     * 2. states : ( GridState.none, GridState.added, GridState.modified, GridState.deleted )  
     */
  getRowIndexes(options?: {
        checkedOnly?: boolean,
        states?: GridState[]
    }): number[];
  setGridOption(options: {
        dataAdapter: IDataAdapter,
        appendable?: boolean,
        cardListTemplate?: ICardListTemplate,
        listHeight?: number,
        onRenderItem?: onRenderItem,
        headerCheckVisible?: boolean,
        checkable?: boolean,
        disabledCheckProperty?: string,
        headerComponent?: React.ReactElement | (() => React.ReactElement),
        headerClassName?: string,
        paging?: boolean,
        rowCountPerPage?: number,
        customRowCountDropDownList?: Array<any>,
        appendButton?: IAddButton,
        borderRadius?: string,
        itemPadding?: IItemPadding,
        privacyColumns?: string[],
        memoCategory?: string,
        getMemoKey?: (e: { rowIndex: number, cardList: OBTCardListInterface }) => string,
        reservedColumnNames?: {
            memoCode: string;
            checkPen: string;
            insertDateTime: string;
            insertIPAddress: string;
            insertUserId: string;
            modifiedIPAddress: string;
            modifyDateTime: string;
            modifyUserId: string;
        }
    }): void;
  refresh(): void;
  /**
     * Function() : Row
     * getRows() : 카드 리스트에서 Row에 해당하는 Row데이터를 가지오는 함수입니다.
     * @param {json} options (선택) 
     * 1. checkedOnly : 체크된 rows 가져오기
     * 2. states :( GridState.none, GridState.added, GridState.modified, GridState.deleted )
     */
  getRows(options?: {
        checkedOnly?: boolean,
        states?: GridState[]
    }): any[];
  /**
     * Function() : Row
     * gerRow(rowIndex) : 카드 리스트에서 해당하는 Row를 가지오는 함수입니다.
     * @param {number} rowIndex
     */
  getRow(rowIndex: number): any;
  /**
     * Function() : Row
     * addRow() : 카드 리스트에서 해당하는 Row를 추가하는 함수입니다.
     * @param {number} rowIndex (선택)
     */
  addRow(rowIndex?: number): void;
  /**
     * Function() : Row
     * removeRow(rowIndex) : 카드 리스트에서 해당하는 Row를 제거하는 함수입니다.
     * @param {number} rowIndex
     */
  removeRow(rowIndex: number): void;
  /**
     * Function() : Row
     * removeRows(rowIndexes) : 카드 리스트에서 원하는 Rows를 제거하는 함수입니다.
     * @param {number[]} rowIndexes 
     */
  removeRows(rowIndexes: number[]): void;
  /**
       * Function() : Value
       * getValues(rowIndex) : 카드 리스트에서 해당하는 Row의 values의 값을 가지오는 함수입니다.
       * @param {number} rowIndex
       */
  getValues(rowIndex: number): any;
  /**
       * Function() : Value
       * getValue(rowIndex, columnName) : 카드 리스트에서 해당하는 Row의 column에 맞는 value 값을 가지오는 함수입니다.
       * @param {number} rowIndex
       * @param {string} columnName
       */
  getValue(rowIndex: number, columnName: string): any;
  /**
       * Function() : Value
       * setValue(rowIndex, columnName, value) : 카드 리스트에서 해당하는 Row의 column에 맞는 value 값을 설정하는 함수입니다.
       * @param {number} rowIndex
       * @param {string} columnName
       * @param {any} value
       */
  setValue(rowIndex: number, columnName: string, value: any): void;
  /**
       * Function() : Value
       * setValues(rowIndex, values) : 카드 리스트에서 해당하는 Row의 values의 값을 설정하는 함수입니다.
       * @param {number} rowIndex
       * @param {any} values
       */
  setValues(rowIndex: number, values: any): void;
  /**
       * Function() : State
       * getState(rowIndex) : 카드 리스트에서 해당하는 state의 값을 가지오는 함수입니다.
       * @param {number} rowIndex
       */
  getState(rowIndex: number): GridState;
  /**
       * Function() : State
       * setState(rowIndex, state) : 카드 리스트에서 해당하는 state의 값을 설정하 함수입니다.
       * @param {number} rowIndex
       * @param {GridState} state
       */
  setState(rowIndex: number, state: GridState): void;
  /**
       * Function() : Read, Store (Promise)
       * readData() : 카드 리스트에서 Data를 Read에서 설정하는 Callback 함수입니다.
       * @param {Read} readCallback (선택)
       * @param {number} currentPage (선택)
       * @param {number} rowCountPerPage (선택)
       */
  readData(readCallback?: Read, currentPage?: number, rowCountPerPage?: number, clear?: boolean): Promise<any>;
  /**
       * Function() : Read, Store (Promise)
       * storeData() : 카드 리스트에서 Data의 결과를 DML처리 하려는 Callback 함수입니다.
       * @param {number} rowIndex (선택)
       * @param {Store} storeCallback (선택)
       */
  storeData(rowIndex?: number, storeCallback?: Store, removeRowsMode?: boolean): Promise<void>;
  /**
       * Function() : Read, Store
       * claerData() : 카드 리스트에서 전체 Row 수를 가지오는 함수입니다.
       */
  clearData(): void;
  /**
       * Function() : Selection
       * getSelection() : 카드 리스트에서 해당하는 Row의 index를 가지오는 함수입니다.
       */
  getSelection(): number;
  /**
       * Function() : Selection
       * setSelection(rowIndex) : 카드 리스트에서 해당하는 Row의 index를 설정하는 함수입니다.
       * @param {number} rowIndex
       */
  setSelection(rowIndex: number): void;
  // public getValue(rowIndex: number, columnName: string): any {
      //     // 데이터 및 rowindex 존재 체크 여부
      //     if (!this._isDataExists(rowIndex)) return;
      //     return this._data![rowIndex][columnName];
      // }
  searchData(startIndex: number, columnName: string, value: any, selectSearchedRow: boolean = true): ICell | null;
  /**
      * Function() : Check
      * setCheck(rowIndex, checked) : 카드 리스트에서 해당하는 Row를 check 설정하는 함수입니다.
      * @param {number} rowIndex
      * @param {boolean} checked
      */
  setCheck(rowIndex: number, checked: boolean, invokeEvent: boolean = true): void;
  /**
      * Function() : Check
      * getCheck(rowIndex) : 카드 리스트에서 해당하는 check된 Row를 가지오는 함수입니다.
      * @param {number} rowIndex
      */
  getCheck(rowIndex: number): boolean;
  /**
      * Function() : Check
      * getHeadCheck() : 카드 리스트에서 Header에 해당하는 check된 boolean 상태를 가지오는 함수입니다.
      */
  getHeadCheck(): boolean;
  /**
      * Function() : Check
      * getCheckedRows() : 카드 리스트에서 check된 Row들을 가지오는 함수입니다.
      */
  getCheckedRows(): any[];
  /**
      * Function() : Check
      * getCheckedIndexes : 카드 리스트에서 check된 index들을 가지오는 함수입니다.
      */
  getCheckedIndexes(): number[];
  /**
      * Function() : 포커스가 카드 리스트에 있는 지 확인여부 합수입니다
      * hasFocus() : boolean 
      */
  hasFocus(): boolean;
  /**
       * @internal
       * rowIndex에 checkPenRGB 세팅하고 저장
       */
  storeCheckPen(rowIndex: number, checkPenRGB: string): void;
  /**
       * @internal
       */
  storeMemo(rowIndex: number, memoCode: string | null): void;
  /**
       * @internal
       * _handleSelection : 해당 index 설정 내부에서 관리 함수
       * @param {number} dataIndex 
       * @param {number} oldIndex 
       */
  _handleSelection(dataIndex: number, oldIndex: number, keyMove: boolean = false, isDeletedRow?: boolean): void;
  /**
       * focusedIndex 기반으로 dom 포커스호출 
       */
  focus(): void;
  _handleItemClick(dataIndex: number): void;
  _handleItemDoubleClick(dataIndex: number): void;
  _handleMoveFocusByTab(shift: boolean): void;
  /**
       * @internal
       * _setCheck : 체크 설정 내부에서 관리 함수
       * @param {number} rowIndex 
       * @param {boolean} checked 
       * @param {boolean} onRender 
       */
  _setCheck(rowIndex: number, checked: boolean, onRender: boolean, invokeEvent: boolean = true): void;
  /**
       * @internal
       * _setheadCheck : 헤더 체크 설정 내부에서 관리 함수
       * @param {boolean} checked 
       */
  _setHeadCheck(checked: boolean): void;
  /**
       * @internal
       * _setSort : 오름차순 정렬 내부에서 관리 함수
       * @param {string} sortIndex 
       */
  _setSort(sortIndex: string): void;
  /**
       * @deprecated
       * _focus() : focus 포커스 함수 
       * (이후 이벤트 AfterChangeSelection, AfterDataChangeEventArgs)
       * (포커스 시간차 문제로 안에 같이 사용)
       * @param {number} dataIndex 
       * @param {number} oldIndex 
       * @param {boolean} keyMove 
       */
  _focus(dataIndex: number, oldIndex?: number, keyMove: boolean = false): void;
  /**
       * @internal
       * scroll() : virtualBox 스크롤 계산 함수 
       * @param {number} dataIndex
       */
  _scroll(dataIndex: number): void;
  /**
       * @internal
       * setEmptyBodyImgText() : 카드리스트 emptyBody 설정 함수
       * @param {string} data
       */
  _setEmptyBodyImgText(data: EmptySetBody): void;
  /**
      * Function() : 초기 함수 
      * 1. _initialize() :CardList interface 상태 내부에서 관리 함수
      * 2. _setState() : CardList interface 상태 내부에서 관리 함수
      * 3. state() : CardList interface 상태 내부에서 관리 함수
      */
  
      /**
       * @internal
       * _initialize() :CardList interface 상태 내부에서 관리 함수
       * @param {any} owner 
       */
  _initialize(owner: any, pageAuthority?: IPageAuthority, moduleCode?: string, fetch?: Fetch): void;
  /**
       * @internal
      */
  checkPossibleGridAction(behavior: 'appendable' | 'editable' | 'removable' | 'printable', invokedPublicMethodCall?: boolean): boolean;
  isPrivacyEnabled: any;
  isUsePrivacy: any;
  /**
       * 카드리스트에서는 개인정보 암호화 동작 정의를 하지 않는다.
       */
  getPrivacyBehavior: any;
  getPrivacyComponentHandler: any;
  updatePrivacy(rowIndex: number, columnName: string, updatePrivacyValue: string): void;
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
