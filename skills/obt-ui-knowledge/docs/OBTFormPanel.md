# OBTFormPanel

Input 컴포넌트를 테이블 형태로 배치하는 패널입니다.

```tsx
import { OBTFormPanel, OBTFormPanelProps, OBTFormPanelMethods } from 'luna-orbit';

export interface OBTFormPanelProps {
  /**
   * @type {JSX.Element | string}
   */
  children?: {JSX.Element | string};

  /**
   * validate 사용으로 필수입력 툴팁을 띄울 때 툴팁에 대한 설정을 변경할 수 있습니다.
   * value | labelText | position ...
   * @type {IOBTTooltip}
   * @see {@link IOBTTooltip }
   */
  requiredTooltip?: {IOBTTooltip};

  /**
   * 라벨 영역에 들어갈 텍스트의 정렬을 지정할 수 있습니다.
   * @type {labelTextAlignType}
   * @see {@link labelTextAlignType }
   */
  labelTextAlign?: {labelTextAlignType};

  /**
   * FormPanel 내 컴포넌트가 수정된 경우 호출됩니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onChange?: {function};

  /**
   */
  onMoveFocusByTab?: (e: MoveFocusByTabEventArgs) => void;

  /**
   * 카테고리를 지정하면 라벨 좌측에 카테고리를 표시할 수 있습니다. 
   * 카테고리는 단일 문자열로, 혹은 문자열 배열로 여러개 지정할 수 있습니다.
   * @type {ICategory[]}
   */
  categories?: {ICategory[]};

  /**
   * showReferenceFromTooltip 을 th 헤더에 지정하면 툴팁을 우측 컨텐츠 하단에 표시할 수 있습니다.
   */
  showReferenceFromTooltip?: boolean;

  /**
   */
  tutorialLabel?: string;

  /**
   */
  tutorialTitle?: string;

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

  /**
   * 컨텍스트로 전달된 권한(일반적으로 로그인 유저의 권한정보)을 사용할것인지 여부
   * @default true
   */
  usePageAuthority?: boolean;

  /**
   * 컨텍스트로 넘어오는 pageAuthority를 바라보는것이 디폴트
   * 변경을 원할 경우 사용하는 옵션
   */
  pageAuthority?: IPageAuthority;

}

export interface OBTFormPanelMethods {
  /**
   * 컴포넌트에 포커스를 줄 때 사용하는 내장함수입니다.
   */
  focus(isLast: boolean): void;

  /**
   */
  isEmpty(): boolean;

  /**
   * 패널 내 컴포넌트의 validation 체크 결과를 리턴합니다.
   */
  validate(showMessage: boolean): boolean;

}

// --- Referenced Types ---

enum labelTextAlignType {
    'left' = 'left',
    'center' = 'center',
    'right' = 'right'
}

import { IPageAuthority } from 'luna-orbit/OBTPageContainer/OBTPageContainer';
export interface IPageAuthority {
    /**
     * 조회권한입니다.
     */
    selectAuthType: 'NO' | 'G' | 'C' | 'B' | 'D' | 'U',
    /**
     * 수정권한입니다.
     */
    modifyAuthYn: "Y" | "N",
    /**
     * 삭제권한입니다.
     */
    deleteAuthYn: "Y" | "N",
    /**
     * 인쇄권한입니다.
     */
    printAuthYn: "Y" | "N",
}

```
