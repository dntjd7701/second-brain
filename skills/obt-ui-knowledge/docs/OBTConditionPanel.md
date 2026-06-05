# OBTConditionPanel

조회조건 패널 컴포넌트입니다. 
children 으로 OBTConditionItem 컴포넌트를 두어 조회조건을 추가합니다.

```tsx
import { OBTConditionPanel, OBTConditionPanelProps, OBTConditionPanelMethods } from 'luna-orbit';

export interface OBTConditionPanelProps {
  /**
   * 추가조회조건(optional) 영역을 펼침 | 감춤 처리할 수 있습니다.
   */
  collapsed?: boolean;

  /**
   */
  pageContainer?: any;

  /**
   */
  children?: any;

  /**
   * 컨디션패널의 타입을 지정합니다. 
   * default | small
   * @type {DisplayType}
   * @default "default"
   */
  type?: {DisplayType};

  /**
   * 추가조회조건 영역이 펼쳐질 경우에 영역을 차지할지 위로 띄울지 지정 가능합니다. 
   * true 영역 띄움 | false 영역 차지
   * @default false
   */
  useFloatingOptionalPanel?: boolean;

  /**
   * required요소가 비었을 때 나타나는 tooltip을 사용자가 원하는 방식으로 지정할 수 있습니다.
   * @type {IOBTTooltip}
   */
  requiredTooltip?: {IOBTTooltip};

  /**
   * 초기화버튼 사용여부를 지정할 수 있습니다.
   * @default false
   */
  useResetButton?: boolean;

  /**
   * 추가조회조건영역의 접힘 여부의 변경 이벤트입니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onCollapseChanged?: {function};

  /**
   * 조회버튼 클릭 이벤트입니다.
   * 검색조건 중 필수항목의 입력여부와 관계없이 호출되며, 파라메터의 e.validated로 필수항목의 입력여부를 확인할 수 있습니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onSearch?: {function};

  /**
   * 검색 조건 하위 컴포넌트의 change가 이루어지면 호출되는 이벤트입니다. 
   * 이전 조건을 clear할 때 주로 사용합니다.
   * @param e - 이벤트 인자입니다.
   * @returns 
   */
  onChange?: (e: ConditionPanelChangeEventArgs) => void | Promise<void>;

  /**
   * 하위 컴포넌트 선택이 변결될때 호출되는 이벤트입니다.
   * @param e - 이벤트 인자입니다.
   */
  onAfterSelectChange?: (e: AfterSelectChangeEventArgs) => void;

  /**
   * - 커스터마이징 기능 사용여부를 지정하는 속성입니다.
   * - 검색조건의 위치와 순서를 사용자가 변경할 수 있습니다.
   * - 해당 기능은 OBTConditionPanel 의 id 와 모든 OBTConditionItem 의 id 가 있는 경우 활성화 되며, useCustomize 를 true 로 지정하더라도, id 가 충족되지 않으면 활성화 되지 않습니다.
   */
  useCustomize?: boolean;

  /**
   * useResetButton true 일때 초기화버튼 클릭 이벤트입니다.
   * @param e - 이벤트 인자입니다.
   * @returns 
   */
  onResetButtonClick?: (e: MouseEventArgs) => void;

  /**
   */
  fixedLayout?: boolean;

  /**
   */
  labelWidth?: number;

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
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

}

export interface OBTConditionPanelMethods {
  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(isLast: boolean): void;

  /**
   * 값이 비어있는지를 확인하는 함수
   * 비어있다면 true, 입력된 상태라면 false를 반환
   */
  isEmpty(): boolean;

  /**
   */
  validate(): boolean;

  /**
   */
  search(): void;

}

// --- Referenced Types ---

export enum DisplayType {
    'default' = 'default',
    'small' = 'small'
}

```
