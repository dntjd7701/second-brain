# OBTDialog

팝업형태의 창을 표시하는 컴포넌트입니다.

```tsx
import { OBTDialog, OBTDialogProps, OBTDialogMethods } from 'luna-orbit';

export interface OBTDialogProps {
  /**
   * - Dialog 오픈 여부를 지정합니다.
   * - true 열림 | false 닫힘
   */
  open?: boolean;

  /**
   * Dialog의 제목을 설정합니다.
   * @required 
   */
  title: string;

  /**
   * Dialog의 부제목을 설정합니다.
   */
  subTitle?: string;

  /**
   * 우측 상단 X 버튼(닫기)을 제외한 채 타이틀을 지정할때 설정합니다.
   * @default true
   */
  hasTitleCloseButton?: boolean;

  /**
   * Dialog의 크기 타입을 설정합니다.
   * @type {DialogType}
   * @see {@link DialogType }
   * @default "default"
   */
  type?: {DialogType};

  /**
   * Dialog의 하단의 버튼을 설정합니다.
   * @type {Array<IButton>}
   * @see {@link IButton }
   */
  buttons?: {Array<IButton>};

  /**
   * Dialog가 open 되었을 때 실행되는 함수 입니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onAfterOpen?: {function};

  /**
   * - OBTDialog를 사용할건지 OBTDialog2를 사용할건지 지정하는 속성입니다. 
   * - true : 기존의 OBTDialog를 사용합니다.
   * - false : 새롭게 개발된 OBTDialog2를 사용합니다.
   * @default true
   */
  useOldVersion?: boolean;

  /**
   */
  isResponsive?: boolean;

  /**
   */
  titleStyle?: any;

  /**
   */
  subTitleStyle?: any;

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

}

export interface OBTDialogMethods {
  /**
   */
  handleAfterOpen(): void;

  /**
   */
  handleButtonClicked(key: any): void;

  /**
   */
  handleClose(): void;

  /**
   */
  addEvent(): void;

  /**
   */
  removeEvent(): void;

  /**
   */
  handleMouseMove(e: MouseEvent): void;

}

// --- Referenced Types ---

export enum DialogType {

    /**
     *  1050px 720px
     */
    'big' = 'big',

    /**
     *  740px 620px
     */
    'default' = 'default',

    /**
     *  440px 520px
     */
    'small' = 'small',

}

```
