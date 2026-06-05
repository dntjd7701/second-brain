# OBTAccordion2

OBTAccordion 컴포넌트의 문제점을 보완한 아코디언 컴포넌트입니다.

```tsx
import { OBTAccordion2, OBTAccordion2Props } from 'luna-orbit';

export interface OBTAccordion2Props {
  /**
   * - 컴포넌트의 열리고 닫힘의 설정입니다. 
   * - true : 아코디언을 펼칩니다.
   * - false : 아코디언을 닫습니다.
   */
  value: boolean;

  /**
   * 아코디언이 접히거나 펼쳐지는 경우 발생하는 Callback 함수입니다.
   * @param e - 이벤트 인자입니다.
   */
  onChange?: (e: ChangeEventArgs<boolean>) => void;

  /**
   * 아코디언의 타이틀에 표시되는 문구입니다.
   */
  labelText?: string;

  /**
   * 아코디언 타이틀의 크기 타입을 지정합니다.
   * @type {AccordionType}
   * @see {@link AccordionType }
   * @default "default"
   */
  type?: {AccordionType};

  /**
   * 아코디언에 버튼 사용시 구분선 사용여부를 지정합니다.
   * @default true
   */
  useSeparator?: boolean;

  /**
   * children을 조건부 렌더링 할 것이냐에 대한 여부를 지정합니다. 
   * - 기존의 방법처럼(OBTAccordion) 아코디언이 접혀있을 때 children을 null.
   * - 하지만, 기존 OBTAccordion 에서 해당 방식으로 인해 데이터그리드 이슈등이 발생하였고 이를 개선한 것이 OBTAccordion2 입니다.
   * @default false
   */
  useChildrenConditionalRendering?: boolean;

  /**
   * 아코디언 타이틀 좌측 아이콘을 지정합니다.
   * @type {JSX.Element}
   */
  imageUrl?: {JSX.Element};

  /**
   * 아코디언 우측에 버튼을 넣을때 element를 구성합니다.
   * @type {JSX.Element}
   */
  button?: {JSX.Element};

  /**
   * 아코디언이 펼쳐져 있는 경우 표시할 imageUrl 입니다.
   * @type {JSX.Element}
   */
  expandedImageUrl?: {JSX.Element};

  /**
   * 아코디언이 접힌 경우 표시할 imageUrl 입니다.
   * @type {JSX.Element}
   */
  collapsedImageUrl?: {JSX.Element};

  /**
   * 우측에 상태 라벨을 표시할 수 있습니다.
   * @type {IStateLabel}
   * @see {@link IStateLabel }
   */
  stateLabel?: {IStateLabel};

  /**
   * key를 지정합니다.
   */
  key?: string | number;

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

}


// --- Referenced Types ---

enum AccordionType {
    /**
     * 기본 사이즈입니다. height 18px
     */
    'default' = 'default',
    /**
     * 큰 사이즈입니다. height 22px
     */
    'large' = 'large'
}

export interface IStateLabel {
    /**
     * 표시할 텍스트를 지정합니다.
     * @required
     */
    labelText?: string,
    /**
     * stateLabel의 색을 지정합니다.(HEX)
     * @required
     */
    color?: string
}

```
