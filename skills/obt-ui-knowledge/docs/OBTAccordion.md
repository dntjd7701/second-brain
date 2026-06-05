# OBTAccordion

항목을 접고 펼칠 수 있는 아코디언 패널입니다.

```tsx
import { OBTAccordion, OBTAccordionProps } from 'luna-orbit';

export interface OBTAccordionProps {
  /**
   * 아코디언 타이틀의 크기 타입을 지정합니다.
   * @type {AccordionType}
   * @see {@link AccordionType }
   * @default "default"
   */
  type?: {AccordionType};

  /**
   * - 컴포넌트의 열리고 닫힘의 설정입니다. 
   * - true : 아코디언을 펼칩니다.
   * - false : 아코디언을 닫습니다.
   */
  value?: boolean;

  /**
   * 아코디언이 접히거나 펼쳐지는 경우 발생하는 Callback 함수입니다.
   * @param e - 이벤트 인자입니다.
   */
  onChange?: (e: ChangeEventArgs<boolean>) => void;

  /**
   * 아코디언 우측에 버튼을 넣을때 element를 구성합니다.
   * @type {JSX.Element}
   */
  button?: {JSX.Element};

  /**
   * 아코디언 타이틀 좌측 아이콘을 지정합니다.
   * @type {JSX.Element}
   */
  imageUrl?: {JSX.Element};

  /**
   * 아코디언이 접힌 경우 표시할 imageUrl 입니다.
   * @type {JSX.Element}
   */
  collapsedImageUrl?: {JSX.Element};

  /**
   * 아코디언이 펼쳐져 있는 경우 표시할 imageUrl 입니다.
   * @type {JSX.Element}
   */
  expandedImageUrl?: {JSX.Element};

  /**
   * 우측에 상태 라벨을 표시할 수 있습니다.
   * @type {IStateLabel}
   * @see {@link IStateLabel }
   */
  state?: {IStateLabel};

  /**
   * 아코디언에 버튼 사용시 구분선 사용여부를 지정합니다.
   * @default true
   */
  useSeparator?: boolean;

  /**
   * - 새롭게 제작된 OBTAccordion2 컴포넌트로 대체할 때 사용되는 속성입니다. 
   * - true : OBTAccordion 사용 
   * - false : OBTAccordion2 사용
   * @default true
   */
  useOldVersion?: boolean;

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

  /**
   * 라벨에 표시될 문구
   */
  labelText?: string;

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

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
