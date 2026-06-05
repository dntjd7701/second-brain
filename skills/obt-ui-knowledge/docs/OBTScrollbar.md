# OBTScrollbar

```tsx
import { OBTScrollbar, OBTScrollbarProps, OBTScrollbarMethods } from 'luna-orbit';

export interface OBTScrollbarProps {
  /**
   * 스크롤을 움직이면 발생하는 Callback 함수입니다.
   */
  onScroll?: (e: EventArgs) => void;

  /**
   * 스크롤의 프레임의 설정값을 가지오는 Callback 함수입니다.
   */
  onScrollFrame?: (e: ChangeEventArgs<object>) => void;

  /**
   * @default true
true (스크롤 보임) | false (스크롤 숨김)
   */
  visible?: boolean;

  /**
   * 스크롤바 두께
   */
  type?: ThumbType;

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

export interface OBTScrollbarMethods {
  /**
   * 맨 위로 스크롤
   */
  scrollToTop(): void;

  /**
   * 맨 아래로 스크롤
   */
  scrollToBottom(): void;

  /**
   * 왼쪽으로 스크롤
   */
  scrollToLeft(): void;

  /**
   * 오른쪽으로 스크롤
   */
  scrollToRight(): void;

}

// --- Referenced Types ---

export enum ThumbType {
    'default' = 'default',
    'big' = 'big'
}

```
