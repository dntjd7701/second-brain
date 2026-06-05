# OBTExcelFormDialog

데이터 테이블을 엑셀 양식으로 만들 수 있는 컴포넌트입니다.

```tsx
import { OBTExcelFormDialog, OBTExcelFormDialogProps, OBTExcelFormDialogMethods } from 'luna-orbit';

export interface OBTExcelFormDialogProps {
  /**
   * 팝업 오픈 여부를 지정합니다.
   * @required 
   */
  open?: boolean;

  /**
   * 내려받아지는 엑셀파일의 이름을 설정할 수 있습니다.
   */
  fileName?: string;

  /**
   * 엑셀파일을 생성하기 위해 추가적인 옵션을 설정할 수 있습니다.
   * - sheetName : EXPORT 시에 시트 이름을 설정할 수 있습니다.
   * - onBeforeCreateExcelFile : 엑셀파일 생성 전 호출되는 callBack입니다.
   * @type {ExcelOption}
   * @see {@link ExcelOption }
   */
  option?: {ExcelOption};

  /**
   * EXCEL IMPORT, EXCEL 양식생성 시 필요한 컬럼의 정보를 받아옵니다.
   * @type {FormDataParam}
   * @see {@link FormDataParam }
   * @required 
   */
  formDataParam: {FormDataParam};

  /**
   * 양식만들기 팝업에서 제공하는 버튼 이외의 버튼을 추가할때 사용합니다.
   * @type {IOBTButton}
   * @see {@link IOBTButton }
   */
  optionalButton?: {IOBTButton};

  /**
   * 저장 버튼 클릭시에 호출되는 callBack 입니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onSave?: {function};

  /**
   * 닫기 버튼 클릭시에 호출되는 callBack 입니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onClose?: {function};

  /**
   * 양식만들기 버튼 클릭시에 호출되는 callBack 입니다.
   * @type {function}
   * @param e - 이벤트 인자입니다.
   */
  onCreate?: {function};

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

export interface OBTExcelFormDialogMethods {
  /**
   * 좌측 그리드 initialize (기본설정항목)
   */
  initializeGridL(): OBTDataGridInterface;

  /**
   * 우측 그리드 initialize (사용자설정항목)
   */
  initializeGridR(): OBTDataGridInterface;

  /**
   */
  isChanged(): boolean;

  /**
   */
  validateNotNullFields(): boolean;

  /**
   */
  handleUpButtonClick(): void;

  /**
   */
  handleDownButtonClick(): void;

  /**
   */
  handleRemoveItemButtonClick(): void;

  /**
   */
  handleAddItemButtonClick(): void;

  /**
   */
  handleCreateExcel(): Promise<void>;

  /**
   */
  handleNewWrite(): void;

  /**
   */
  handleNewWriteNotnull(): void;

  /**
   */
  handleSaveButtonClick(): void;

  /**
   */
  handleConfirmOkBtnClick(buttonKey: string): Promise<void>;

  /**
   */
  handleSaveConfirmCancelClick(): void;

  /**
   */
  handleCreateExcelConfirmCancelClick(): void;

  /**
   */
  handleClose(): void;

  /**
   */
  handleSplitButtonClick(__0: { target: any; event: any; key: any; }): void;

}

// --- Referenced Types ---

import { ExcelOption } from 'luna-orbit/Common/Excel';
export interface ExcelOption {
    sheetName?: string
    onBeforeCreateExcelFile?: ((workbook: Workbook) => Promise<void>)
}

import { FormDataParam } from 'luna-orbit/Common/Excel';
export interface FormDataParam {
    ajaxEbp?: any,
    fetch?: any,
    companyCode: string,
    menuCode: string,
    tableName: string,
    isUse?: boolean,
    formData?: FormData[],
    onAfterFormDataReceive?: (e: {
        coCd?: string,
        formData?: FormData[]
    }) => Promise<FormData[]>,
    validateAllRows?: boolean,
    onValidate?: (e: {
        excelData: any[],
        rowIndex: number,
        columnIndex: number,
        columnName?: string,
        formData?: PartialFormData,
        value: any,
        errorCode?: string,
        errorType?: string,
        errorDescription?: string
    }) => void
}

import { IOBTButton } from 'luna-orbit/OBTButton/OBTButton';
export interface IOBTButton extends CompositeProps.Default, CommonProps.labelText, CommonProps.disabled, Events.onClick, Events.onMouseLeave,
    Events.onFocus, Events.onBlur, Events.onMouseDown, Events.onClick, Events.onMouseMove, Events.onMouseUp, Events.onMouseEnter, Events.onKeyDown, Events.onKeyPress, Events.onKeyUp {
    /**
     * 버튼의 색 테마를 지정할 수 있습니다
     * (default : 기본 / skyblue : 하늘색 / blue : 파란색 / drawer : 예제 참고 / drawerImportant : 예제 참고)
     */
    theme?: ButtonTheme,

    /**
     * 버튼에 SVG 컴포넌트을 넣을 때 사용하는 속성
     * normal에 해당하는 SVG 컴포넌트 혹은 json 객체를 통해 이미지를 지정 가능 
     */
    icon?: Icon | any,

    /**
     *  컴포넌트에 이미지 URL을 넣을 때 사용하는 속성
     */
    imageUrl?: ImageUrl | string,

    /**
     * 버튼의 크기를 정할 수 있습니다.
     * (big : 큰버튼 / default : 기본버튼 / small : 작은버튼 / icon : 아이콘버튼(svg))
     */
    type?: ButtonType,

    /**
     * tooltip 설정
     */
    tooltip?: any,

    /**
     * imageUrl 지정한 버튼에서 마우스 오버했을때 백그라운드 처리를 할것인지 여부
     */
    useMouseOverBackground?: boolean,

    /**
     * imageUrl 을 사용할 때 들어갈 이미지에 클래스 네임을 부여할 수 있는 속성
     */
    imageTagClassName?: string

    /**
     * onClick 이벤트의 콜백이 비동기형태일 경우 (Promise를 리턴) 비동기 동작이 끝날때까지 재클릭을 막을지 여부 
     * @default false
     */
    asyncClickMode?: boolean,

    /** 
     * type = state 일 때 우측에 표시되는 카운트
     *
     */
    stateCount?: any;

    /** 
     * type = state 일 때 선택 여부
     */
    stateSelected?: boolean;

    tutorialTitle?: string;
    tutorialLabel?: string;
    tutorialOrder?: number;
}

```
