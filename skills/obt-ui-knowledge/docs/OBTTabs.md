# OBTTabs

공통에서 제공하는 OBTTab의 부모 컴포넌트입니다.

```tsx
import { OBTTabs, OBTTabsProps } from 'luna-orbit';

export interface OBTTabsProps {
  /**
   * 자식 요소인 OBTTab 콤포넌트의 선택된 상태가 변경되기 전 발생하는 Callback 함수입니다.
   * @type {function}
   * @param e - 이벤트 인자
   */
  onBeforeChange?: {function};

  /**
   * 요소의 하위 컴포넌트인 OBTTab의 정렬 위치를 지정합니다.
   * @type {Align}
   * @see {@link Align }
   * @default "left"
   */
  align?: {Align};

  /**
   * 요소의 하위 컴포넌트인 OBTTab의 크기 타입을 지정합니다.
   * @type {TabType}
   * @see {@link TabType }
   * @default "default"
   */
  type?: {TabType};

  /**
   */
  children?: any;

  /**
   * 현재 선택된 탭의 포커스 스타일을 변경할 수 있습니다.
   */
  selectedItemStyle?: { color: string; borderBottomColor: string; };

  /**
   * @deprecated DOM 구조 파악에 대한 이슈로 폐기 되었습니다.
탭을 숨기거나 보일지에 대한 여부를 지정합니다.
default = false
   */
  hideTabs?: boolean;

  /**
   */
  tutorialTitle?: string;

  /**
   */
  tutorialLabel?: string;

  /**
   */
  tutorialOrder?: number;

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
   * 활성화여부
   * @default false
   */
  disabled: boolean;

  /**
   */
  onChange: (e: ChangeEventArgs<string>) => void;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: string;

}


// --- Referenced Types ---

enum Align {
    'left' = 'left',
    'center' = 'center',
    'right' = 'right'
}

enum TabType {
    'default' = 'default',
    'small' = 'small'
}

```
