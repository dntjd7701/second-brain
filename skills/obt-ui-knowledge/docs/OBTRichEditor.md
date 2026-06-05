# OBTRichEditor

withApi() HOC 를 사용하면 Props 로 Api 를 사용할 수 있다.
api 가 Optional 로 선언되었기에 내부에서 ! 오퍼레이터를 사용해서 호출한다.
{@code this.props.api!.test();}

```tsx
import { OBTRichEditor, OBTRichEditorProps, OBTRichEditorMethods } from 'luna-orbit';

export interface OBTRichEditorProps {
  /**
   */
  valueType?: ValueTypeEnum;

  /**
   */
  extendTypes?: IExtendType[];

  /**
   */
  variables?: (string | IVariable)[];

  /**
   */
  colors?: string[];

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
  value: string;

  /**
   * 필수입력 여부
   * true로 설정시 OBTFormPanel, OBTConditionPanel등 컨테이너에서 필수적으로 값이 입력되어야하는 컴포넌트로 인식한다.
   * @default false
   */
  required: boolean;

  /**
   * 읽기전용(선택은 가능하지만 값은 변경불가) 여부
   * @default false
   */
  readonly: boolean;

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

  /**
   * 데이터 미 입력시 기본표시되는 문구
   */
  placeHolder?: string;

}

export interface OBTRichEditorMethods {
  /**
   */
  focus(): void;

  /**
   */
  setValue(value: string, valueType: ValueTypeEnum): void;

  /**
   */
  getValue(valueType: ValueTypeEnum): any;

  /**
   */
  insertLink(url: string, urlText: string): Promise<void>;

  /**
   */
  insertImage(url: string): Promise<void>;

  /**
   */
  insertDivider(): Promise<void>;

  /**
   */
  setStyle(style: { type: StyleTypeEnum; value?: any; }): Promise<void>;

}

// --- Referenced Types ---

enum ValueTypeEnum {
    'text' = 'text',
    'html' = 'html'
}

```
