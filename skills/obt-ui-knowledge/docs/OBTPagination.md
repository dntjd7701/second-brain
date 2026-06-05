# OBTPagination

```tsx
import { OBTPagination, OBTPaginationProps } from 'luna-orbit';

export interface OBTPaginationProps {
  /**
   * 현재페이지
   */
  currentPage: number;

  /**
   * 페이지갯수
   */
  pageCount: number;

  /**
   * 페이지단위
   */
  pagingBlock: number;

  /**
   * row갯수
   */
  rowCountPerPage: number;

  /**
   * 총 row갯수
   */
  totalCount: number;

  /**
   * 총갯수 visible 여부
   */
  isPageTotalCountText: boolean;

  /**
   * 우측 리스트 갯수 드롭다운 표시여부
   */
  useCountDropDownList?: boolean;

  /**
   * 리스트 갯수 드롭다운을 커스텀할 수 있습니다. 지정하지 않을시에는 기본적으로 10단위로 10-50까지 제공합니다.
   */
  customCountDropDownList?: ICustomCountDropDownList[];

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

```
