# OBTTreeViewItem

```tsx
import { OBTTreeViewItem, OBTTreeViewItemProps, OBTTreeViewItemMethods } from 'luna-orbit';

export interface OBTTreeViewItemProps {
  /**
   */
  item: IList;

  /**
   */
  selectedItem?: IList;

  /**
   */
  editLabelText?: boolean;

  /**
   */
  editSort?: boolean;

  /**
   */
  disabled?: boolean;

  /**
   */
  checkBox?: boolean;

  /**
   */
  type?: Type;

  /**
   */
  rootWidth?: string;

  /**
   */
  imagesWidth: string;

  /**
   */
  childCount?: boolean;

  /**
   */
  images?: any[];

  /**
   */
  dragging?: boolean;

  /**
   */
  draggingKey?: string;

  /**
   */
  useOverflowTooltip?: boolean;

  /**
   */
  useWindowing?: boolean;

  /**
   */
  hasChildren?: boolean;

  /**
   * item의 hasChildren을 사용할것인지 여부.
   * hasChildren은 나중에 추가된 옵션으로 기존 사용하고 있던 옵션과 충돌될수 있어서 추가
   */
  useHasChildren?: boolean;

  /**
   */
  onMouseEnter: (item: IList, e: MouseEvent<Element, MouseEvent>) => void;

  /**
   */
  onDragStart: (item: IList, e: DragEvent<Element>) => void;

  /**
   */
  onDragEnter: (item: IList, e: DragEvent<Element>) => void;

  /**
   */
  onDragOver: (item: IList, e: DragEvent<Element>) => void;

  /**
   */
  onDragEnd: (item: IList, e: DragEvent<Element>) => void;

  /**
   */
  onMouseDown: (item: IList, e: MouseEvent<Element, MouseEvent>) => void;

  /**
   */
  onCheckBoxClicked: (item: IList) => void;

  /**
   */
  onToggleCollapse: (item: IList, e: MouseEvent<Element, MouseEvent>) => void;

  /**
   */
  onDoubleClick: (item: IList, e: MouseEvent<Element, MouseEvent>) => void;

  /**
   */
  onTextFieldBlur: () => void;

  /**
   */
  onGetEditor: (item: IList) => any;

}

export interface OBTTreeViewItemMethods {
  /**
   */
  isCollapsed(collapsed: boolean): boolean;

  /**
   */
  getButton(onChange: (e: any) => void, checked: boolean, disabled: boolean, visible: boolean): Element;

  /**
   */
  getExpander(collapsed: boolean, disabled: boolean, onClick: (e: MouseEvent<Element, MouseEvent>) => void): Element;

  /**
   */
  imageUrl(image: any, normal: any, open: any): any;

  /**
   */
  getImageUrl(image: string | IimageUrl, collapsed: boolean, disabled: boolean, onClick: (e: MouseEvent<Element, MouseEvent>) => void): Element;

  /**
   */
  getImageUrlState(imageUrl: any): any;

  /**
   */
  icon(icon: any, normal: any, open: any): any;

  /**
   */
  getIcon(icons: any, collapsed: boolean, disabled: boolean, onClick: (e: MouseEvent<Element, MouseEvent>) => void): Element;

  /**
   */
  getIconState(icon: any): any;

  /**
   */
  renderExpander(item: IList): Element;

}

// --- Referenced Types ---

import { IList } from 'luna-orbit/OBTTreeView/OBTTreeView';
export interface IList {
    /**
     * 키로 사용되는 값입니다.
     * @required
     */
    key: string,
    index?: number[],
    /**
     * 항목의 내용입니다.
     * @required
     */
    labelText: string | JSX.Element,
    /**
     * 편집모드로 진입시 에디터에 표시될 내용입니다. 
     * (lableText로 JSX 지정시 편집모드를 사용한다면 필수 설정)
     */
    editorValue: string | any,
    parentKey?: string,
    /**
     * 이미지, 혹은 상황에 맞는 아이콘(이미지)를 지정할 수 있습니다.
     */
    imageUrl?: string | IimageUrl,
    /**
     * 아이콘, 혹은 상황에 맞는 아이콘(이미지)를 지정할 수 있습니다.
     */
    icon?: any | Iicon,
    /**
     * 펼침 접힘여부입니다.
     */
    collapsed?: boolean,
    /**
     * 체크된 상태인지 야부입니다.
     */
    checked?: boolean,
    /**
     * 이 요소를 표시할지 여부입니다.
     */
    visible?: boolean,
    /**
     * 체크박스를 표시할지 여부입니다.
     */
    checkBoxVisible?: boolean,
    /**
     * 이 요소의 비활성화 여부입니다.
     */
    disabled?: boolean,
    /**
     * 이 요소의 체크박스 비활성화 여부입니다.
     */
    checkBoxDisabled?: boolean,
    visibleCollapsedImage?: boolean,
    /**
     * 이 요소의 자식 IList 배열입니다.
     */
    children?: IList[],
    /**
     * 자식요소의 갯수 표시여부입니다.
     */
    childCount?: boolean,
    originalItem?: any,

    tooltip?: any,
    style?: any,
    _childrenCount?: number,
    isHovered?: boolean,
    // children과 상관없이 expander를 노출시키기를 원할때 사용하는 옵션
    hasChildren?: boolean,
}

import { Type } from 'luna-orbit/OBTTreeView/OBTTreeView';
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

```
