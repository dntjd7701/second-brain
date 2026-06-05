# OBTProgress

```tsx
import { OBTProgress, OBTProgressProps } from 'luna-orbit';

export interface OBTProgressProps {
  /**
   * @default default
로딩뷰의 원의 크기
   */
  type: Type;

  /**
   * @default true
풀 스크린 여부
   */
  fullScreen: boolean;

  /**
   * @default false
여닫 여부
   */
  open: boolean;

  /**
   * @default default
색상
   */
  states: States;

  /**
   * 취소 버튼 유무
   */
  hasCancelButton?: boolean;

  /**
   * 취소 버튼 클릭시 발생하는 함수
   */
  onCancelButtonClick?: (e: any) => void;

  /**
   * OBTAutoValueBinder와 연결키
   */
  id?: string;

  /**
   * 최상단 Element의 className
   */
  className?: string;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: number;

  /**
   * 라벨에 표시될 문구
   */
  labelText?: string;

  /**
   * 컴포넌트 넓이(width)
   */
  width?: string;

  /**
   * 컴포넌트 높이(height)
   */
  height?: string;

}


// --- Referenced Types ---

enum Type {
    'small' = 'small',
    'default' = 'default',
    'large' = 'large'
}

enum States {
    'default' = 'default',
    'error' = 'error',
    'warning' = 'warning'
}

```
