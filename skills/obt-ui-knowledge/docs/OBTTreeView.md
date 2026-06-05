# OBTTreeView

OBTTreeView는 tree형태의 view를 제공합니다.

```tsx
import { OBTTreeView, OBTTreeViewProps, OBTTreeViewMethods } from 'luna-orbit';

export interface OBTTreeViewProps {
  /**
   * 펼침 닫힘을 표시하는 이미지입니다.
   * @default default
   */
  type?: Type;

  /**
   * 트리뷰의 데이터소스로 사용할 객체 배열입니다.
   * @type {IList[]}
   */
  list: {IList[]};

  /**
   * 전체 요소들의 체크박스 표시 여부입니다.
   * @default default
   */
  checkBox?: boolean;

  /**
   * 맨 하위 요소들의 개수 표시 여부입니다.
   */
  childCount?: boolean;

  /**
   * 현재 선택된 아이템 입니다.
   */
  selectedItem?: any;

  /**
   * true일 때 textField(내용수정)가 활성화 됩니다.
   */
  editLabelText?: boolean;

  /**
   * 내용을 수정할 때 오른쪽 확인, 취소 버튼 표시여부 입니다.
   */
  editLabelTextButtonsVisible?: boolean;

  /**
   * 수정 모드 일 때 required 여부입니다.
   */
  editLabelTextRequired?: boolean;

  /**
   * textField(내용수정)의 툴팁 설정입니다.
   */
  editLabelTextTooltip?: any;

  /**
   * true일 때 drag를 통한 자리이동(정렬)이 활성화 됩니다.
   */
  editSort?: boolean;

  /**
   * 각 요소의 오른쪽에 나올 항목들을 지정할 수 있습니다.
   * 항목들은 선택된 상태에서 over될 시에 나타납니다.
   */
  images?: any[];

  /**
   * 부모 자식간의 체크상태 연관성에 관한 옵션입니다.
   * - asymmetric: 자식 체크박스가 true가 아니여도 부모 체크박스를 true로 할 수 있습니다.
   */
  checkBoxOption?: CheckBoxOption;

  /**
   * '데이터가 없을때 텍스트 커스텀',
   */
  emptyDataMsg?: string;

  /**
   * '데이터가 없을때 이미지 커스텀',
   * @default "데이터가 존재하지 않습니다."
   */
  emptyDataImage?: string | Element;

  /**
   * 텍스트가 길어져서 말줄임 처리 될 때 툴팁을 띄우는 옵션
   */
  useOverflowTooltip?: boolean;

  /**
   * 윈도윙을 사용할 것인지 여부입니다.  
   * true로 지정시 화면상에서 보여지지않는 항목은 렌더링에서 제외되어 성능이 향상됩니다.
   * @default true
   */
  useWindowing?: boolean;

  /**
   * checkBoxDisabled 처리된 자식 아이템의 체크여부는 부모의 체크상태에 영향을 받지 않도록 하는 옵션입니다.
   * @default false
   */
  useCheckDisabledPropagation?: boolean;

  /**
   * 사이드바의 체크펜, 메모 등으로 사용할 키를 지정합니다.
   */
  reservedColumnNames?: IReservedColumnNames;

  /**
   * item의 hasChildren을 사용할것인지 여부.
   * hasChildren은 나중에 추가된 옵션으로 기존 사용하고 있던 옵션과 충돌될수 있어서 추가
   */
  useHasChildren?: boolean;

  /**
   * 요소가 선택 될 때 발생하는 callback 함수 입니다.
   * @param e - 이벤트 인자
   * @param e.item - 선택된 아이템 객체
   */
  onAfterSelectChange?: (e: AfterSelectEventArgs) => void;

  /**
   * 해당 요소의 체크박스를 클릭할 때 발생하는 callback 함수입니다.
   * @param e - 이벤트 인자
   * @param e.items - 체크된 아이템 객체배열
   * @param e.checked - 체크여부
   */
  onCheckChanged?: (e: CheckedEventArgs) => void;

  /**
   * 해당 요소가 접히거나 펼쳐질 때 발생하는 callback 함수 입니다.
   * @param e - 이벤트 인자
   * @param e.item - 변경된 아이템 객체
   * @param e.collapsed - 접힘여부
   */
  onCollapseChanged?: (e: CollapseEventArgs) => void;

  /**
   * 데이터를 treeView 형식에 맞게 변환해 주기 위한 함수입니다.
   * @param e - 이벤트 인자
   * @param e.list
   * @param e.item
   */
  onMapItem?: (e: MapItemEventArgs) => void;

  /**
   * editLabelText의 상태가 true 일 때 수정된 사항을 반환해주는 함수입니다.
   * @param e - 이벤트 인자
   * @param e.item
   * @param e.labelText - 수정된 데이터
   */
  onEditLabelText?: (e: EditLabelTextArgs) => void;

  /**
   * editLabelText의 상태가 true 일 때 수정된 사항을 반환해주는 함수입니다.
   */
  onChangeLabelText?: (e: ChangeLabelTextArgs) => void;

  /**
   * editLabelText의 상태가 true 일 때 textField에서 포커스가 Blur 될 때 발생하는 함수입니다.
   */
  onEditLabelTextBlur?: () => void;

  /**
   * editSort가 true 일 때 자리 이동(정렬)이 일어날 경우 발생하는 함수입니다.
   */
  onEditSort?: (e: EditSortArgs) => void;

  /**
   * 요소에 마우스가 Enter 될때 호출되는 함수입니다.
   */
  onMouseEnter?: (e: OnMouseEnterArgs) => void;

  /**
   * 요소를 마우스가 더블 클릭 할때 호출되는 함수입니다.
   */
  onDoubleClick?: (e: OnMouseEnterArgs) => void;

  /**
   * 요소를 마우스가 클릭 할때 호출되는 함수입니다.
   */
  onMouseDown?: (e: OnMouseDownArgs) => void;

  /**
   * 드래그가 끝낫을 때 호출되는 함수입니다.
   */
  onDragEnd?: (end: boolean) => void;

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
   * 라벨에 표시될 문구
   */
  labelText?: string;

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

}

export interface OBTTreeViewMethods {
  /**
   */
  isCollapsed(collapsed: boolean): boolean;

  /**
   */
  search(value: string): { item: IList; labelText: string; scrollTop: number; }[];

  /**
   */
  scrollTop(y: number): void;

  /**
   */
  collapse(key: string, collapse: boolean, e: MouseEvent<Element, MouseEvent>): Promise<void>;

  /**
   */
  expand(key: string, expand: boolean): void;

  /**
   */
  getCheckedItems(): IList[];

}

// --- Referenced Types ---

export enum Type {
    /**
     * 화살표
     */
    'default' = 'default',
    /**
     * 폴더 
     */
    'folder' = 'folder',
    /**
     *  폴더와 같으나 최하위 항목도 디렉토리 아이콘으로 표시됨
     */
    'directory' = 'directory'
}

enum CheckBoxOption {
    'default' = 'default',
    'asymmetric' = 'asymmetric'
}

interface IReservedColumnNames {
    insertDateTime: string;
    insertIPAddress: string;
    insertUserId: string;
    modifiedIPAddress: string;
    modifyDateTime: string;
    modifyUserId: string;
}

```
