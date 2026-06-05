# OBTReferencePanel

참고박스를 사용하여 특정 내용에 대해 참고사항으로 정의할 수 있는 컴포넌트입니다.

```tsx
import { OBTReferencePanel, OBTReferencePanelProps } from 'luna-orbit';

export interface OBTReferencePanelProps {
  /**
   * 열림 | 닫힘 버튼 사용 여부를 정의하는 속성입니다.
   * @default false
   */
  button: boolean;

  /**
   * 제목을 정의하는 속성입니다.
   */
  title: string;

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
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: boolean;

  /**
   */
  onChange: (e: ChangeEventArgs<boolean>) => void;

}

```
