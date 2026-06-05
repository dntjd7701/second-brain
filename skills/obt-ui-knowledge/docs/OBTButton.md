# OBTButton

```tsx
import { OBTButton, OBTButtonProps, OBTButtonMethods } from 'luna-orbit';

export interface OBTButtonProps {
  /**
   * 버튼의 색 테마를 지정할 수 있습니다
   * (default : 기본 / skyblue : 하늘색 / blue : 파란색 / drawer : 예제 참고 / drawerImportant : 예제 참고)
   */
  theme?: ButtonTheme;

  /**
   * 버튼에 SVG 컴포넌트을 넣을 때 사용하는 속성
   * normal에 해당하는 SVG 컴포넌트 혹은 json 객체를 통해 이미지를 지정 가능
   */
  icon?: any;

  /**
   * 컴포넌트에 이미지 URL을 넣을 때 사용하는 속성
   */
  imageUrl?: string | ImageUrl;

  /**
   * 버튼의 크기를 정할 수 있습니다.
   * (big : 큰버튼 / default : 기본버튼 / small : 작은버튼 / icon : 아이콘버튼(svg))
   */
  type?: ButtonType;

  /**
   * tooltip 설정
   */
  tooltip?: any;

  /**
   * imageUrl 지정한 버튼에서 마우스 오버했을때 백그라운드 처리를 할것인지 여부
   */
  useMouseOverBackground?: boolean;

  /**
   * imageUrl 을 사용할 때 들어갈 이미지에 클래스 네임을 부여할 수 있는 속성
   */
  imageTagClassName?: string;

  /**
   * onClick 이벤트의 콜백이 비동기형태일 경우 (Promise를 리턴) 비동기 동작이 끝날때까지 재클릭을 막을지 여부
   * @default false
   */
  asyncClickMode?: boolean;

  /**
   * type = state 일 때 우측에 표시되는 카운트
   */
  stateCount?: any;

  /**
   * type = state 일 때 선택 여부
   */
  stateSelected?: boolean;

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
   * 라벨에 표시될 문구
   */
  labelText?: string;

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

  /**
   * Click 시 발생하는 Callback 함수
   */
  onClick?: (e: MouseEventArgs) => void;

  /**
   * MouseLeave 시 발생하는 Callback 함수
   */
  onMouseLeave?: (e: MouseEventArgs) => void;

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

  /**
   * MouseDown 시 발생하는 Callback 함수
   */
  onMouseDown?: (e: MouseEventArgs) => void;

  /**
   * MouseMove 시 발생하는 Callback 함수
   */
  onMouseMove?: (e: MouseEventArgs) => void;

  /**
   * MouseUp 시 발생하는 Callback 함수
   */
  onMouseUp?: (e: MouseEventArgs) => void;

  /**
   * MouseEnter 시 발생하는 Callback 함수
   */
  onMouseEnter?: (e: MouseEventArgs) => void;

  /**
   * KeyDown 시 발생하는 Callback 함수
   */
  onKeyDown?: (e: KeyEventArgs) => void;

  /**
   * KeyPress 시 발생하는 Callback 함수
   */
  onKeyPress?: (e: KeyEventArgs) => void;

  /**
   * KeyUp 시 발생하는 Callback 함수
   */
  onKeyUp?: (e: KeyEventArgs) => void;

}

export interface OBTButtonMethods {
  /**
   */
  click(): void;

}

// --- Referenced Types ---

export enum ButtonTheme {
    'default' = 'default',
    'blue' = 'blue',
    'skyBlue' = 'skyBlue',
    'drawer' = 'drawer',
    'drawerImportant' = 'drawerImportant',
    'statePositive1' = 'statePositive1',
    'statePositive2' = 'statePositive2',
    'statePositive3' = 'statePositive3',
    'stateProgress' = 'stateProgress',
    'stateNegative1' = 'stateNegative1',
    'stateNegative2' = 'stateNegative2',
    'statePending1' = 'statePending1',
    'statePending2' = 'statePending2',
    'stateNeutral' = 'stateNeutral',
}

export interface ImageUrl {
    normal: string,
    over?: string,
    press?: string,
    disabled?: string
}

export enum ButtonType {
    'big' = 'big',
    'default' = 'default',
    'small' = 'small',
    'icon' = 'icon',
    'state' = 'state',
    'smallState' = 'smallState'
}

```
