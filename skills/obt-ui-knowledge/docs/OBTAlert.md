# OBTAlert

하나의 버튼을 가지고 있는 Alert을 제공하는 컴포넌트 입니다.

```tsx
import { OBTAlert, OBTAlertProps, OBTAlertMethods } from 'luna-orbit';

export interface OBTAlertProps {
  /**
   * type에 따른 아이콘
   * - default | success | warning | error | question
   * @type {OBTAlert.Type}
   * @see {@link OBTAlert.Type }
   * @default default
   */
  type: {OBTAlert.Type};

  /**
   * 상단 타이틀을 지정합니다.
   * 문자열이나 JSX를 지정할 수 있습니다.
   * @type {string | JSX}
   */
  title?: {string | JSX};

  /**
   * 표시되는 메세지를 지정합니다.
   * 문자열이나 JSX를 지정할 수 있습니다.
   * @type {string | JSX}
   */
  labelText?: {string | JSX};

  /**
   * 버튼 텍스트를 지정할 수 있습니다. 
   * 기본값은 '확인'입니다.
   * @type {string}
   * @default 확인
   */
  buttonLabelText?: {string};

  /**
   * 컴포넌트를 닫아야 하는 경우에 발생하는 이벤트입니다.
   * case
   * 1. 확인 버튼 클릭
   * 2. Enter 키 입력
   * 3. Esc 키 입력
   * 4. 컴포넌트 외부 영역 클릭
   * @param e 이벤트 인자
   */
  onClose?: (e: EventArgs) => void;

  /**
   * 확인 버튼 및 엔터 버튼 클릭 시 자동으로 닫힐지에 대한 여부를 지정합니다.
   * @type {boolean}
   * @default true
   */
  autoClose?: {boolean};

  /**
   * OBTAutoValueBinder와 연결키
   */
  id?: string;

  /**
   * 최상단 Element의 className
   */
  className?: string;

}

export interface OBTAlertMethods {
  /**
   */
  handleClick(event: MouseEventArgs): void;

  /**
   */
  handleKeyDown(e: KeyboardEvent<HTMLDivElement>): void;

  /**
   */
  handleOnKeyUp(event: KeyboardEvent<HTMLDivElement>): void;

}

// --- Referenced Types ---

export enum Type {
    'default' = 'default',
    'success' = 'success',
    'warning' = 'warning',
    'error' = 'error',
    'question' = 'question'
}

```
