# OBTCardListInterface

OBTCardList 컴포넌트에 전달되어 대부분의 기능을 수행하는 객체입니다.

```tsx
import { OBTCardListInterface, OBTCardListInterfaceMethods } from 'luna-orbit';

export interface OBTCardListInterfaceMethods {
  /**
   */
  setModuleCode(moduleCode: string, force: boolean): void;

  /**
   */
  setFetch(fetch: Fetch, force: boolean): void;

  /**
   */
  setPageAuthority(pageAuthority: IPageAuthority): void;

  /**
   * 메모 키를 생성하는 콜백 함수입니다.
   */
  getMemoKey(e: { rowIndex: number; cardList: OBTCardListInterface; }): string;

  /**
   * CardList 초기값 세팅
   * setHeaderCheckVisible(visible) : 카드리스트에 체크리스트 보여주기 여부 속성입니다.
   */
  setHeaderCheckVisible(visible: boolean): OBTCardListInterface;

  /**
   */
  setCheckable(checkable: boolean, showHeaderCheck: boolean): OBTCardListInterface;

  /**
   * CardList 초기값 세팅
   * setSort(value, sortList) : 카드리스트에 SortList (상단 드랍다운리스트) 정렬 여부 속성입니다.
   */
  setSort(index: string, sortList: IDropList[], options: { displayType?: DisplayType; comparer?: (sortItem: IDropList, a: any, b: any) => number; }): OBTCardListInterface;

  /**
   * Function() : Row
   * getRowCount() : 카드 리스트에서 전체 Row 수를 가지오는 함수입니다.
   */
  getRowCount(): number;

  /**
   * Function() : Row
   * getRowIndexes() : 카드 리스트에서 Row에 해당하는 index들을 가지오는 함수입니다.
   */
  getRowIndexes(options: { checkedOnly?: boolean; states?: GridState[]; }): number[];

  /**
   */
  setGridOption(options: { dataAdapter: IDataAdapter; appendable?: boolean; cardListTemplate?: ICardListTemplate; listHeight?: number; onRenderItem?: onRenderItem; ... 14 more ...; reservedColumnNames?: { ...; }; }): Promise<void>;

  /**
   */
  refresh(): Promise<void>;

  /**
   * Function() : Row
   * getRows() : 카드 리스트에서 Row에 해당하는 Row데이터를 가지오는 함수입니다.
   */
  getRows(options: { checkedOnly?: boolean; states?: GridState[]; }): any[];

  /**
   * Function() : Row
   * gerRow(rowIndex) : 카드 리스트에서 해당하는 Row를 가지오는 함수입니다.
   */
  getRow(rowIndex: number): any;

  /**
   * Function() : Row
   * addRow() : 카드 리스트에서 해당하는 Row를 추가하는 함수입니다.
   */
  addRow(rowIndex: number): void;

  /**
   * Function() : Row
   * removeRow(rowIndex) : 카드 리스트에서 해당하는 Row를 제거하는 함수입니다.
   */
  removeRow(rowIndex: number): void;

  /**
   * Function() : Row
   * removeRows(rowIndexes) : 카드 리스트에서 원하는 Rows를 제거하는 함수입니다.
   */
  removeRows(rowIndexes: number[]): void;

  /**
   * Function() : Value
   * getValues(rowIndex) : 카드 리스트에서 해당하는 Row의 values의 값을 가지오는 함수입니다.
   */
  getValues(rowIndex: number): any;

  /**
   * Function() : Value
   * getValue(rowIndex, columnName) : 카드 리스트에서 해당하는 Row의 column에 맞는 value 값을 가지오는 함수입니다.
   */
  getValue(rowIndex: number, columnName: string): any;

  /**
   * Function() : Value
   * setValue(rowIndex, columnName, value) : 카드 리스트에서 해당하는 Row의 column에 맞는 value 값을 설정하는 함수입니다.
   */
  setValue(rowIndex: number, columnName: string, value: any): void;

  /**
   * Function() : Value
   * setValues(rowIndex, values) : 카드 리스트에서 해당하는 Row의 values의 값을 설정하는 함수입니다.
   */
  setValues(rowIndex: number, values: any): void;

  /**
   * Function() : State
   * getState(rowIndex) : 카드 리스트에서 해당하는 state의 값을 가지오는 함수입니다.
   */
  getState(rowIndex: number): GridState;

  /**
   * Function() : State
   * setState(rowIndex, state) : 카드 리스트에서 해당하는 state의 값을 설정하 함수입니다.
   */
  setState(rowIndex: number, state: GridState): void;

  /**
   * Function() : Read, Store (Promise)
   * readData() : 카드 리스트에서 Data를 Read에서 설정하는 Callback 함수입니다.
   */
  readData(readCallback: Read, currentPage: number, rowCountPerPage: number, clear: boolean): Promise<any>;

  /**
   * Function() : Read, Store (Promise)
   * storeData() : 카드 리스트에서 Data의 결과를 DML처리 하려는 Callback 함수입니다.
   */
  storeData(rowIndex: number, storeCallback: Store, removeRowsMode: boolean): Promise<void>;

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
   */
  setSelection(rowIndex: number): void;

  /**
   */
  searchData(startIndex: number, columnName: string, value: any, selectSearchedRow: boolean): ICell;

  /**
   * Function() : Check
   * setCheck(rowIndex, checked) : 카드 리스트에서 해당하는 Row를 check 설정하는 함수입니다.
   */
  setCheck(rowIndex: number, checked: boolean, invokeEvent: boolean): void;

  /**
   * Function() : Check
   * getCheck(rowIndex) : 카드 리스트에서 해당하는 check된 Row를 가지오는 함수입니다.
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
   * focusedIndex 기반으로 dom 포커스호출
   */
  focus(): void;

  /**
   */
  _handleItemClick(dataIndex: number): void;

  /**
   */
  _handleItemDoubleClick(dataIndex: number): void;

  /**
   */
  _handleMoveFocusByTab(shift: boolean): void;

  /**
   */
  _focus(dataIndex: number, oldIndex: number, keyMove: boolean): void;

  /**
   */
  isPrivacyEnabled(): boolean;

  /**
   */
  isUsePrivacy(columnName: string): boolean;

  /**
   * 카드리스트에서는 개인정보 암호화 동작 정의를 하지 않는다.
   */
  getPrivacyBehavior(columnName: string): any;

  /**
   */
  getPrivacyComponentHandler(columnName: string, e: GetPrivacyEventArgs): Promise<void>;

  /**
   */
  updatePrivacy(rowIndex: number, columnName: string, updatePrivacyValue: string): void;

}
```
