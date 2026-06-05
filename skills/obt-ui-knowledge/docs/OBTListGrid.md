# OBTListGrid

```tsx
import { OBTListGrid, OBTListGridProps, OBTListGridMethods } from 'luna-orbit';

export interface OBTListGridProps {
  /**
   * 리얼그리드와의 연결을 담당하는 인터페이스
   */
  interface: OBTListGridInterface;

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
   */
  onChange: (e: ChangeEventArgs<TypeList>) => void;

}

export interface OBTListGridMethods {
  /**
   */
  handleReorderMouseUp(e: MouseEvent): void;

  /**
   */
  handleMouseDown(e: MouseEvent<Element, MouseEvent>): void;

  /**
   */
  handleMouseUp(e: MouseEvent<Element, MouseEvent>): void;

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
   */
  handleDocumentMouseMove(e: MouseEvent): void;

  /**
   */
  focus(): void;

  /**
   */
  refresh(): void;

  /**
   */
  handleFunctionButtonClick(functionButton: IActionButton, e: MouseEvent<Element, MouseEvent>): void;

  /**
   */
  handleFocus(): void;

  /**
   */
  handleBlur(): void;

}

// --- Referenced Types ---

import OBTListGridInterface from 'luna-orbit/OBTListGrid/OBTListGridInterface';
class OBTListGridInterface {
  ImageLabelTemplate: any;
  // static fields
  
      // public static GridType = GridType
  ColumnType: any;
  ROW_MOVE_COLUMN_NAME: any;
  /** @internal */
  _gridElementId: string;
  /** 
       * @internal
       * 이미지 라벨 컬럼의 경우, 컬럼의 값에 매핑되는 이미지 정보를 캐싱하는 필드 
       *  */
      // private _imageDataByTextValue: IImageDataByTextValue[] = [];
  
      // Accessors
  
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
       */
  get unmanagedGridOptions(): any;
  /**
       * 리얼그리드의 gridview
       */
  get gridView(): any;
  /**
       * provider
       */
  get provider(): any;
  /**
       * 리얼그리드의 프로바이더
       */
  get realGridProvider(): any;
  set currentPage(currentPage: number);
  /**
       * 현재페이지
       */
  get currentPage(): any;
  /**
       * 페이지갯수
       */
  get pageCount(): any;
  /**
       * 그리드의 보여줄 로우 갯수
       */
  get rowCountPerPage(): any;
  /**
      * 페이징의 총 데이터 갯수
      */
  get totalCount(): any;
  /**
       * 퀵아이콘 리스트
       */
  get actionButtons(): any;
  /**
       * before
       * checkable 그리드에서 행이 체크상태가 변경된 이전에 발생하는 이벤트
       * [BeforeCheckEventArgs]
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
       * [DoubleClickedEventArgs]
       */
  onDoublelClicked: any;
  /**
       * 데이터 셀을 클릭했을때 발생하는 이벤트
       * [DataCellDblClickedEventArgs]
       */
  onClicked: any;
  /**
       * 헤더의 컬럼 너비가 바뀌고나서 호출됨
       */
  onColumnWidthChanged: any;
  /**
       * 마우스 오버시 툴팁을 보여주기전 발생
       * [DataCellDblClickedEventArgs]
       */
      // public readonly onShowTooltip = new ChaningEvent<((e: Events.ShowTooltipEventArgs) => string)>();
  
      /**
       * useTooltip 사용시 마우스 오버 이벤트 발생
       */
  onMouseHover: any;
  /**
       * showHeaderTooltip 사용시 헤더 마우스 오버시에 이벤트 발생
       */
  onShowHeaderTooltip: any;
  /**
       * 그리드에서 마우스가 벗어날때 호출
       */
  onMouseLeave: any;
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
       * rowSelectMode에서 엔터 입력이 들어왔을때 호출되는 이벤트
       * [SelectByEnterEventArgs]
       */
  onSelectByEnter: any;
  /**
       * 드래그를 시작하면 발생하는 이벤트
       * cancle = true drag가 취소된다. 
       * [InnerDragStartEventArgs]
       */
  onInnerDragStart: any;
  /**
       * 드래그 상태에서 마우스버튼을 놓으면 발생하는 이벤트
       * cancle = true drag가 취소된다. 
       * [InnerDropEventArgs]
       */
  onInnerDrop: any;
  /**
       * 컬럼 이미지버튼을 클릭했을 때 호출된다.
       */
  onImageButtonClicked: any;
  /**
       * 스크롤이 발생할 경우 호출된다.
       */
  onScroll: any;
  /**
       * 소팅
       */
  onSorting: any;
  /**
       * link타입 컬럼 클릭 이벤트
       */
  onLinkableCellClicked: any;
  /**
       * link타입 컬럼 클릭 이벤트
       */
  onEditCommit: any;
  gridImageLabelProcessor: any;
  /**
       * 
       * @param id 그리드의 아이디 한 페이지 내에서는 유일해야한다.
       * @param options 그리드의 전역옵션
       */
  constructor(id: string, options?: GridGlobalOption);
  /**
       * 그리드 초기화
       * @ignore
       */
  _initialize(owner: any): void;
  /**
       * 그리드 옵션의 디스플레이 옵션
       * @param option 
       */
  setDisplayOptions(option: IGridDisplayOption): OBTListGridInterface;
  /**
       * @internal
       * 이미지 컬럼 만들기
       * 데이터를 이미지 url로 해석한다.
       */
  makeImageColumn(defaultRealGridColumn: any, column: IColumn): any;
  /**
       * @internal
       * 이미지버튼 컬럼 만들기
       */
  makeButtonColumn(defaultRealGridColumn: any, column: IColumn): any;
  /**
       * @internal
       * checkImage 컬럼 만들기
       */
  makecheckImageColumn(defaultRealGridColumn: any, column: IColumn): any;
  /**
      * 특정 인덱스의 특정 컬럼이 수정 가능한지 여부를 리턴한다.
      * 컬럼세팅에 수정가능 여부가 지정되어있지 않으면 그리드 레벨의 수정가능 여부를 본다. 
       * @param targetColumn 
       * @param rowIndex 
       * @param columnName 
       */
  isColumnEditable(targetColumn: IColumn, rowIndex: number): boolean;
  //region public method
  
      /**
       * 포커스 스타일
       * @param use 포커스스타일 사용여부
       */
  setFocusStyle(use: boolean): OBTListGridInterface;
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
  setGridOption(options: GridGlobalOption, initialize: boolean = false): void;
  setEmptySet(emptySet: {
        emptyDataImage?: JSX.Element,
        emptyDataMsg?: string,
        emptySearchImage?: JSX.Element,
        emptySearchMsg?: string,
    }): void;
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
    }, merge: boolean = false): OBTListGridInterface;
  /**
       * 그리드 전체 컬럼에 대해 공통적으로 헤더 스타일 적용
       * 다국어 처리가 되면서 헤더글자수가 많아짐에 따라 헤더의 말줄임처리를 컬럼 각각에 적용시키기 번거로움으로 인해 해당 옵션 사용하여 전반적인 헤더 스타일세팅 가능하도록 추가함.   
       * @param option 
       * @param merge 
       * @returns 
       */
  setHeaderStyles(option: {
        textWrap?: 'normal' | 'explicit' | 'ellipse'
    }, merge: boolean = false): OBTListGridInterface;
  /**
       * 그리드 좌측에 인덱스여부 설정
       * @param visible 
       */
  setIndicator(visible: boolean): OBTListGridInterface;
  /**
       * 그리드 옵션 푸터 설정
       * @param visible 
       * @param footerCount  
       */
  setFooter(visible: boolean, footerCount?: number): void;
  /**
       * 체크모드 설정
       * @param checkable 
       */
  setCheckable(checkable: boolean, showHeaderCheck: boolean): OBTListGridInterface;
  /**
       * 특정행 체크박스 비활성화 설정
       * @param checkableExpression 
       */
  setCheckableExpression(checkableExpression: string): OBTListGridInterface;
  /**
       * IColumn배열을 받아 필드에 할당하고 그리드뷰와 데이터프로바이더에 세팅한다.
       * fluent api
       */
  setColumns(columns: IColumn[] | null): OBTListGridInterface;
  /**
       * index를 기반으로 컬럼을 제거한다.
       * fluent api
       * @param index 
       */
  removeColumn(index: number): OBTListGridInterface;
  /**
       * 컬럼을 추가한다.
       * @param index 
       * @param columns 
       */
  addColumn(index: number, ...columns: IColumn[]): OBTListGridInterface;
  /**
       * 선택한 행의 로우를 삭제한다.
       * 여러개의 로우를 한번에 삭제할때는 removeRows를 사용
       * @param rowIndex 
       */
  removeRow(rowIndex: number): void;
  /**
       * 여러건의 로우를 한번에 삭제한다. 
       * @param rowIndexes 
       */
  removeRows(rowIndexes: number[]): Promise<void>;
  /**
       * 프로바이더 세팅
       * @param provider 
       */
  setProvider(provider: IDataProvider | null): OBTListGridInterface;
  /**
       * 컬럼의 폭을 데이터에 따라 자동으로 조절한다.
       * @param columnName? 적용할 컬럼이름
       * @param maxWidth?
       * @param minWidth?
       */
  fitColumnWidth(option?: { columnName?: string, maxWidth?: number, minWidth?: number, visibleOnly?: boolean }): void;
  /**
       * 그리드에 바인딩된 데이터의 길이를 리턴한다.
       * @returns 데이터의 길이(count)
       */
  getRowCount(): number;
  /**
       * 체크된 것이나 특정 GridState인 행의 인덱스 배열을 가져온다. 
       * [GridState]
       * @param options 가져오는 기준이되는 옵션
       */
  getRowIndexes(options?: { checkedOnly?: boolean }): number[];
  /**
       * 체크된 것이나 특정 GridState인 행의 데이터 배열을 가져온다.
       * @param options 가져오는 기준이 되는 옵션
       */
  getRows(options?: { checkedOnly?: boolean }): any[];
  /**
       * 파라미터로 준 인덱스의 행 데이터를 가져온다.
       * @param rowIndex 행의 인덱스
       * @returns 데이터
       */
  getRow(rowIndex: number): any;
  /**
       * 파라미터로 준 인덱스의 행 데이터를 가져온다.
       * @param rowIndex 행의 인덱스
       * @returns 데이터
       */
  getValues(rowIndex: number): any;
  /**
       * 특정 셀의 데이터를 가져온다 
       * @param rowIndex 가져올 데이터의 행
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       */
  getValue(rowIndex: number, columnName: string): any;
  /**
       * 그리드에 세팅된 IColumn을 컬럼이름으로 검색해 가져온다.
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       * @returns 이름으로 찾은 IColumn이나 undefined
       */
  getColumnByName(columnName: string): IColumn | undefined;
  /**
       * unmanaged result 리얼그리드의 컬럼정보를 이름으로 가져온다.
       * @param columnName 가져올 데이터의 컬럼이름 IColumn.name 속성과 매핑
       * @returns 리얼그리드에서 관리되는 컬럼 속성
       */
  getRealGridColumnByName(columnName: string): any | null;
  /**
       * IColumn을 기반으로 그리드에 컬럼을 세팅한다.
       * @param column 
       */
  setColumn(column: IColumn): void;
  /**
       * 리얼그리드 내부에 아이콘 식으로 사용할 이미지 리스트를 등록한다. 
       * @param columnName
       * @param iconPathList
       */
  registerColumnImageList(columnName: string, iconPathList: string[]): void;
  /**
       * 특정 인덱스 체크처리
       * @param rowIndex 
       * @param checked 
       */
  setCheck(rowIndex: number, checked: boolean): void;
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
       * 그리드의 데이터행을 모두 체크한다.
       * @param checked 
       */
  checkAll(checked?: boolean): void;
  /**
       * 그리드에서 체크된 로우를 가져온다.
       */
  getCheckedRows(): any[];
  /**
       * 체크한 인덱스 가져오기
       */
  getCheckedIndexes(): number[];
  /**
       * @deprecated
       * 선택된 로우의 인덱스를 가져온다.
       */
  getFocusedIndex(): number;
  /**
       * 선택된 로우의 인덱스를 가져온다.
       */
  getSelectedIndex(): number;
  /**
       * @deprecated
       * '선택된 컬럼의 이름을 가져온다.'
       */
  getFocusedColumnName(): string;
  /**
       * '선택된 컬럼의 이름을 가져온다.'
       */
  getSelectedColumnName(): string;
  /**
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
       * TODO: 인덱스 단위로는 움직이는데, 컬럼단위로는 이동이 안된다.
       * @param rowIndex 
       * @param columnName 
       */
  setSelection(rowIndex: number, columnName?: string): void;
  /**
       * 현재 선택된 데이터
       * @returns { rowIndex: 선택되어있는 인덱스, columnName: 선택되어있는 컬럼이름}
       */
  getSelection(): any;
  /**
       * 그리드뷰에 포커스를 준다.
       */
  focus(): void;
  /**
       * 데이터 검색
       * @param startIndex 검색시 시작 인덱스
       * @param columnNamesForSearch 
       * @param value 
       * @param partialMatch 
       */
  searchData(startIndex: number, columnNamesForSearch: string[] | null, value: string, selectSearchedCell: boolean, partialMatch: boolean): ICell | null;
  /**
       *  actionButtons 세팅
       * @param actionButtons 
       */
  setActionButtons(actionButtons: IActionButton[] | null): OBTListGridInterface;
  /**
       * 데이터를 읽어 그리드에 바인딩한다.
       * @param currentPage
       * @param rowCountPerPage
       * @param readCallback 
       * @param readPageCallback
       */
  readData(currentPageOrOptions?: number | IReadDataOptions, rowCountPerPage?: number, readCallback?: Read, readPageCallback?: ReadPage): Promise<any>;
  /**
       * 그룹컬럼을 제외하고 순수 컬럼만을 가져온다.
       */
  getFlatColumns(visibleOnly: boolean): IColumn[];
  /**
       * 엑셀 익스포트
       * @link http://help.realgrid.com/api/types/GridExportOptions/
       * @param exportOption 리얼그리드의 GridView.exportGrid 함수의 옵션
       */
  exportExcel(exportOption?: any): void;
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
       * 특정 컬럼 보여지는지 여부 지정.
       * 보여지지 않는다고해서 required, unique의 유효성 체크가 무시되는것은 아님
       * @param columnName 
       * @param isVisible 
       */
  setColumnVisible(columnName: string, isVisible: boolean): void;
  /**
       * 그리드에 설정되어 있는 컬럼의 특정 속성 정보를 변경한다.
       * @param columnName 
       * @param property 
       * @param value 
       */
  setColumnProperty(columnName: string, property: string, value: any): void;
  /**
       * 
       * @param rowIndex 
       * @param height 
       * @param refresh 
       */
  setRowHeight(rowIndex: number, height: number, refresh: boolean = true): void;
  /**
       * 지정한 행 높이를 표시되는 데이터에 맞게 변경한다.
       * (* displayOptions.eachRowResizable: true로 지정되어 있어야 한다. multiLine인 경우 textWrap: “explicit”로 지정 )
       * @param itemIndex 
       * @param maxHeight 
       * @param textOnly 
       * @param refresh 
       */
  fitRowHeight(itemIndex: number, maxHeight: number, textOnly: boolean = true, refresh: boolean = true): void;
  /**
       * 모든 행의 높이를 표시되는 데이터에 맞게 변경한다.
       * (* displayOptions.eachRowResizable: true로 지정되어 있어야 한다. multiLine인 경우 textWrap: “explicit”로 지정 )
       * * 데이터 행의 수가 많은 경우 브라우져에서 응답없음이 발생할 수 있으므로 주의해서 사용한다.* 
       * @param maxHeight 
       * @param textOnly 
       */
  fitRowHeightAll(maxHeight: number, textOnly?: boolean): void;
  addCellRenderers(value: any): void;
  /**
       * 그리드에 설정되어 있는 행의 특정 속성 정보를 변경한다.
       * @param property 
       * @param value 
       */
  setRowProperty(property: string, value: any): void;
  /**
       * 특정 컬럼의 데이터에 대한 집계값을 리턴한다.
       * @param columnName 컬럼이름
       * @param expression 지정되어있는 표현식중 하나
       */
  getSummary(columnName: string, expression: 'sum' | 'avg' | 'min' | 'max' | 'count'): number;
  /**
       * 그리드 클리어
       */
  clearData(): void;
  /**
       * 그리드뷰 refresh
       */
  refresh(refresh: boolean = true): void;
  /**
       * 행을 변경하는 인터페이스
       * @param oldIndex 변경 전 행
       * @param newIndex 옮긴 후 행
       */
  moveRow(oldIndex: number, newIndex: number): void;
  /**
       * 리얼그리드 onShowTooltip 이벤트 콜백
       */
      // private handleOnShowTooltip(grid: any, index: any, value: string): string {
      //     if (!this.columns) {
      //         throw new Error("OBTListGridInterface.handleOnShowTooltip: columns can't be null");
      //     }
  
      //     const targetColumn = this.getColumnByName(index.column);
  
      //     let resultTooltipText: string = "";
      //     if (targetColumn) {
      //         const eventArgs = new Events.ShowTooltipEventArgs(
      //             this,
      //             index.column,
      //             index.itemIndex,
      //             this.getRow(index.itemIndex),
      //             ""
      //         );
  
      //         this.invokeEvent<Events.ShowTooltipEventArgs>(
      //             this.onShowTooltip,
      //             eventArgs);
  
      //         resultTooltipText = eventArgs.tooltipText;
      //     }
  
      //     return resultTooltipText;
      // }
  
      /**
       * @internal
       * 리얼그리드 onShowTooltip 이벤트 콜백
       */
  handleMouseHover(grid: any, index: any, value: string): string;
  handleMouseLeave(): void;
  /**
       * @internal
       * 리얼그리드 onInnerDragStart 이벤트 콜백
       * false를 지정하면 드래그가 취소된다.
       */
  handleInnerDragStart(grid: any, dragCells: any): boolean;
  /**
       * @internal
       * 리얼그리드 onInnerDrop 이벤트 콜백
       */
  handleInnerDrop(grid: any, dropIndex: any, dragCells: any): void;
  _invokeColumnWidthChangedWhenResize(): void;
  // internal public 내부적으로 쓰이는 목적의 public 메소드들
  
      /**
       * @ignore
       */
  _handleFocus(): void;
  /**
       * @ignore
       */
  _handleBlur(wrapperRef: any): void;
}

```
