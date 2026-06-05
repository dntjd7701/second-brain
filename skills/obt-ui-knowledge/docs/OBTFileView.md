# OBTFileView

파일을 전달받아 화면에 렌더링하는 기능을 합니다.

```tsx
import { OBTFileView, OBTFileViewProps, OBTFileViewMethods } from 'luna-orbit';

export interface OBTFileViewProps {
  /**
   * 파일에 대한 정의입니다.
   * @required 
   */
  file: IFile;

  /**
   * 옵션 설정 객체입니다.
   */
  option?: Option;

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

export interface OBTFileViewMethods {
  /**
   */
  getPreviewCollapseState(): boolean;

  /**
   */
  setPreviewCollapse(collapse: boolean): void;

  /**
   */
  getViewerCollapseState(): boolean;

  /**
   */
  setViewerCollapse(collapse: boolean): void;

  /**
   */
  getZoomPercentage(): string;

  /**
   */
  setZoomPercentage(percentage: string): void;

}

// --- Referenced Types ---

interface IFile {
    /**
     * 파일이름 
     */
    name: string,
    /**
     * 파일 확장자
     */
    extension: string,
    /**
     * 보여지는 확장자
     */
    displayExtension: string,
    /**
     * 파일을 가져올 url
     * url과 blob둘중 하나만 설정합니다.
     */
    url?: string,
    /**
     * 파일 blob
     * url과 blob둘중 하나만 설정합니다.
     */
    blob?: Blob
}

interface Option {
    /**
     * 파일을 렌더링할때 보여지는 비율에 대한 타입입니다.
     */
    viewType?: ViewType,
    /**
     * 컴포넌트를 다이얼로그 형태로 렌더링할지 여부입니다.
     */
    viewDialog?: boolean,
    /**
     * viewDialogOption.title - 다이얼로그의 타이틀 문자열
     * viewDialogOption.subTitle - 다이얼로그의 서브타이틀 문자열
     * viewDialogOption.height - 다이얼로그의 높이
     */
    viewDialogOption?: any,
    /**
     * 비밀번호가 걸려있는 파일을 열때 사용자에게 물어볼 프롬프트창 문구를 지정합니다. 
     * [처음 물어볼 문구, 사용자가 비밀번호를 틀리게 입력했을 경우 보여줄 문구]
     */
    passwordPromptText?: string[],
    /**
     * 미리보기영역의 접힘상태를 제어합니다.
     * @default false
     */
    previewCollapse?: boolean,
    /**
     * 전체뷰어의 접힘상태를 제어합니다.
     * @default false
     */
    viewerCollapse?: boolean,
    zoomPercentage?: string,
    useNewWindow?: boolean,
    /**
     * [인쇄] 버튼을 통한 인쇄기능을 사용할지 여부입니다.
     * @default true
     */
    usePrint?: boolean,
    onClick?: (e: Events.EventArgs) => void,
}

```
