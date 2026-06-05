# OBTDialog2

팝업형태의 창을 표시하는 컴포넌트입니다.

```tsx
import { OBTDialog2, OBTDialog2Props, OBTDialog2Methods } from 'luna-orbit';

export interface OBTDialog2Props {
  /**
   * true일때 Dialog가 열립니다.
   */
  open?: boolean;

  /**
   * Dialog의 제목을 설정합니다.
   */
  title: string;

  /**
   * Dialog의 부제목을 설정합니다.
   */
  subTitle?: string;

  /**
   * 우측 상단 X 버튼(닫기)을 제외한 채 타이틀을 지정할때 설정합니다.
   */
  hasTitleCloseButton?: boolean;

  /**
   * Dialog의 크기 타입을 설정합니다.
   */
  type?: DialogType;

  /**
   * Dialog의 하단의 버튼을 설정합니다.
   */
  buttons?: IButton[];

  /**
   * Dialog가 open 되었을 때 실행되는 함수 입니다.
   */
  onAfterOpen?: (e: any) => void;

  /**
   */
  draggable?: boolean;

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
   */
  relatedScenarioIds?: string[];

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

export interface OBTDialog2Methods {
  /**
   */
  setDialogPosition(): void;

  /**
   */
  focus(): void;

  /**
   */
  blur(): void;

  /**
   */
  handleResize(): void;

  /**
   */
  handleMouseDown(e: MouseEvent<HTMLDivElement, MouseEvent>): void;

  /**
   */
  handleAfterOpen(): void;

  /**
   */
  handleButtonClicked(key: string): void;

  /**
   */
  getDefaultHeight(): string;

  /**
   */
  getDefaultWidth(): string;

  /**
   */
  renderPropButton(): any;

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
