# OBTNumberField

```tsx
import { OBTNumberField, OBTNumberFieldProps, OBTNumberFieldMethods } from 'luna-orbit';

export interface OBTNumberFieldProps {
  /**
   * value 값이 없을 때 화면에 보여지는 value값을 정의하는 속성입니다.
   */
  allowEmpty: boolean;

  /**
   * 최대입력가능 길이를 정의하는 속성입니다.
   */
  maxLength?: number;

  /**
   * 틀팁에 대한 설정 속성입니다.
   */
  tooltip?: any;

  /**
   * 인풋 내 숫자 정렬에 관련된 속성입니다.
   */
  align?: AlignType;

  /**
   * 컴포넌트 입력필드에서 value 값이 없을 때 화면에 보여지는 value값을 정의하는 속성입니다. 해당옵션 사용시 allowEmpty보다 우선됩니다.
   */
  nonValueDisplayType?: NonValueDisplayType;

  /**
   * 포커스시 가상 키패드 사용자 지정 옵션
   */
  inputMode?: InputModeEnum;

  /**
   * sFormat 공통 소숫점 자리수 지정 옵션
   */
  erpDecimalType?: ErpDecimalType;

  /**
   * (0 반올림, 1 절사, 2 절상)
   */
  lastCutType?: LastCutType;

  /**
   * 데이터가 string 으로 관리되는 옵션.
   */
  useDecimal?: boolean;

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
   * 읽기전용(선택은 가능하지만 값은 변경불가) 여부
   * @default false
   */
  readonly: boolean;

  /**
   * 필수입력 여부
   * true로 설정시 OBTFormPanel, OBTConditionPanel등 컨테이너에서 필수적으로 값이 입력되어야하는 컴포넌트로 인식한다.
   * @default false
   */
  required: boolean;

  /**
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: string | number | Decimal;

  /**
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

  /**
   */
  onChange: (e: ChangeEventArgs<string | number | Decimal>) => void;

  /**
   * 데이터 미 입력시 기본표시되는 문구
   */
  placeHolder?: string;

  /**
   */
  onValidate?: (e: ValidateEventArgs<string | number | Decimal>) => void;

  /**
   * MouseDown 시 발생하는 Callback 함수
   */
  onMouseDown?: (e: MouseEventArgs) => void;

  /**
   * Click 시 발생하는 Callback 함수
   */
  onClick?: (e: MouseEventArgs) => void;

  /**
   * MouseMove 시 발생하는 Callback 함수
   */
  onMouseMove?: (e: MouseEventArgs) => void;

  /**
   * MouseUp 시 발생하는 Callback 함수
   */
  onMouseUp?: (e: MouseEventArgs) => void;

  /**
   * MouseLeave 시 발생하는 Callback 함수
   */
  onMouseLeave?: (e: MouseEventArgs) => void;

  /**
   * MouseEnter 시 발생하는 Callback 함수
   */
  onMouseEnter?: (e: MouseEventArgs) => void;

  /**
   * KeyDown 시 발생하는 Callback 함수
   */
  onKeyDown?: (e: KeyEventArgs) => void;

  /**
   * KeyPress 시 발생하는 Callback 함수
   */
  onKeyPress?: (e: KeyEventArgs) => void;

  /**
   * KeyUp 시 발생하는 Callback 함수
   */
  onKeyUp?: (e: KeyEventArgs) => void;

}

export interface OBTNumberFieldMethods {
  /**
   * 컴포넌트에 포커스를 준다
   */
  focus(isLast: boolean): void;

  /**
   * 값이 비어있는지를 확인하는 함수
   * 비어있다면 true, 입력된 상태라면 false를 반환
   */
  isEmpty(): boolean;

  /**
   */
  validate(): boolean;

  /**
   */
  getValue(): any;

}

// --- Referenced Types ---

enum AlignType {
    'left' = 'left',
    'center' = 'center',
    'right' = 'right'
}

enum NonValueDisplayType {
    'default' = 'default',
    'empty' = 'empty',
    'zero' = 'zero',
}

enum InputModeEnum {
    // 가상 키보드를 사용하지 않습니다. 키보드를 직접 구현
    'none' = 'none',
    // 기본값 제공
    'text' = 'text',
    // 숫자형 키보드 (소수점 제공)
    'decimal' = 'decimal',
    // 숫자형 키보드 (소수잠 제공X)
    'numeric' = 'numeric',
    // 전화번호 입력 키보드 (* # + 제공)
    'tel' = 'tel',
    // 검색에 적합한 키보드. 기본 키보드와 차이: return 대신 go 버튼
    'search' = 'search',
    // 이메일에 적합한 키보드 (@ . 제공)
    'email' = 'email',
    // 기본 키보드에 .com 등을 제공하여 url입력에 적합한 키보드 
    'url' = 'url'
}

import { ErpDecimalType } from 'luna-orbit/Common/DecimalUtil';
export enum ErpDecimalType {
    /**
     * 수량소수점자리수
     */
    'sFormat02' = 'sFormat02',
    /**
    * 원화단가소수점자리수
    */
    'sFormat03' = 'sFormat03',
    /**
     * 외화단가소수점자리수
     */
    'sFormat04' = 'sFormat04',
    /**
     * 비율소숫점자리수
     */
    'sFormat05' = 'sFormat05',
    /**
     * 금액소숫점자리수
     */
    'sFormat06' = 'sFormat06',
    /**
    * 외화소숫점자리수
    */
    'sFormat07' = 'sFormat07',
    /**
     * 환율소숫점자리수
     */
    'sFormat08' = 'sFormat08'
}

import { LastCutType } from 'luna-orbit/Common/DecimalUtil';
export enum LastCutType {
    /**
     * 반올림
     */
    "round" = '0',

    /**
     * 절사
     */
    "trunc" = '1',

    /**
     * 절상
     */
    "ceil" = '2',
}

```
