# OBTColorPicker

```tsx
import { OBTColorPicker, OBTColorPickerProps } from 'luna-orbit';

export interface OBTColorPickerProps {
  /**
   * colorPicker의 사용 형태
   * basic: 다른 색 선택하기 버튼 클릭 시 dialog가 열림
   * pupUp: 다른 색 선택하기 버튼 클릭 시 컴포넌트만 바뀜(보통 dialog에 둘다 넣기 위해 dialog 씌워서 사용)
   */
  type?: MainType;

  /**
   * 하단의 다른색 선택 버튼을 클릭 시 발생 하는 함수
   */
  onButtonClick?: (e: EventArgs) => void;

  /**
   * Dialog 가 닫힌경우 호출
   */
  onDialogClosed?: () => void;

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
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: any;

  /**
   */
  onChange: (e: ChangeEventArgs<any>) => void;

}


// --- Referenced Types ---

enum MainType {
    'basic' = 'basic',
    /**
     *  dialog에 넣어 사용
     */
    'popUp' = 'popUp'
}

```
