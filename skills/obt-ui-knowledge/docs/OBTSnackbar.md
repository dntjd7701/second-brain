# OBTSnackbar

snackbar를 제공하는 컴포넌트 입니다.

```tsx
import { OBTSnackbar, OBTSnackbarProps } from 'luna-orbit';

export interface OBTSnackbarProps {
  /**
   * Snackbar의 타입을 지정합니다.
   * - success | warning | error | info
   * @type {Type}
   * @see {@link Type }
   * @default info
   */
  type: {Type};

  /**
   * OBTSnackbar가 열려있는지 닫혀있는지 설정합니다.
   * @type {boolean}
   */
  open?: {boolean};

  /**
   * OBTSnackbar가 적용되는 범위를 화면가득 채울지 특정영역만 채울지를 설정합니다.
   * @type {boolean}
   * @default true
   */
  fullScreen?: {boolean};

  /**
   * OBTSnackbar 가 특정영역에 열릴때, Wrapper 의 스타일을 지정할 수 있습니다.
   * @type {React.CSSProperties}
   */
  wrapperStyle?: {React.CSSProperties};

  /**
   * 입력된 값이 변경될 때 발생하는 Callback 함수입니다.
   * @param e 이벤트 인자
   */
  onChange?: (e: ChangeEventArgs) => void;

  /**
   * OBTAutoValueBinder와 연결키
   */
  id?: string;

  /**
   * 최상단 Element의 className
   */
  className?: string;

  /**
   * 라벨에 표시될 문구
   */
  labelText?: string;

}


// --- Referenced Types ---

enum Type {
    'success' = 'success',
    'warning' = 'warning',
    'error' = 'error',
    'info' = 'info'
}

```
