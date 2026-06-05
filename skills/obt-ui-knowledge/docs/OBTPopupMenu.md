# OBTPopupMenu

메뉴 링크이동 팝업으로 만들어진 컴포넌트입니다.

```tsx
import { OBTPopupMenu, OBTPopupMenuProps } from 'luna-orbit';

export interface OBTPopupMenuProps {
  /**
   * emr테마 팝업의 list입니다.
   * @see {@link MenuGroup }
   * @type {MenuGroup[]}
   */
  list?: {MenuGroup[]};

  /**
   * 팝업 열림 닫힘 여부를 지정합니다.
   * @default false
   */
  open: boolean;

  /**
   * 기본으로 제공하는 anchor의 라벨을 변경할 수 있습니다.
   */
  labelText: string;

  /**
   * 기본으로 제공하는 anchor의 아이콘을 변경할 수 있습니다.
   */
  icon?: string;

  /**
   * anchor 영역 Node를 직접 구성할 수 있습니다.
   */
  anchorNode: Element;

  /**
   * popup 영역에 적용시킬 옵션들입니다.
   */
  popupOption?: PopupOptions;

  /**
   * 팝업 내 리스트의 클릭시 발생하는 이벤트입니다.
   * @type {function}
   * @see {@link MenuClickEventArgs }
   * @param e - 리스트 클릭 이벤트 인자입니다.
   * @param groupKey - 리스트 블럭, 즉 그룹의 key입니다.
   * @param itemKey - 각 아이템 key입니다.
   * @param index - list의 index 입니다. 동일한 groupKey내에서의 Index입니다.
   * @param url - 각 아이템의 url입니다.
   */
  onMenuClick: {function};

  /**
   * 최상단 Element의 className
   */
  className?: string;

  /**
   * 컴포넌트 넓이(width)
   */
  width?: string;

}


// --- Referenced Types ---

interface PopupOptions {
    openType?: OpenType,
    align?: Align,
    position?: Position | String,
    hideDivider?: boolean,
    hideIcon?: boolean
    popupNode?: JSX.Element | null,
    className?: string
}

```
