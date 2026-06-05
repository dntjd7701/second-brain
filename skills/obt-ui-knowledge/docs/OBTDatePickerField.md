# OBTDatePickerField

```tsx
import { OBTDatePickerField, OBTDatePickerFieldProps, OBTDatePickerFieldMethods } from 'luna-orbit';

export interface OBTDatePickerFieldProps {
  /**
   * 날짜 피커의 타입입니다. 
   * single, period
   * date, yearMonth, year
   */
  type: Type;

  /**
   * 입력 가능한 날짜에 대한 범위의 최대(끝) 날짜를 지정하는 속성입니다.
   */
  max?: any;

  /**
   * 입력 가능한 날짜에 대한 범위의 최소(시작) 날짜를 지정하는 속성입니다.
   */
  min?: any;

  /**
   * periodDate의 week type 사용 여부
   */
  isWeek: boolean;

  /**
   * input을 custom element로 쓸 때 사용합니다.
   */
  customInputElement?: any;

  /**
   * Date Dialog들의 정렬을 지정합니다.
   */
  align?: AlignType;

  /**
   * Date Dialog들의 위치를 지정합니다.
   */
  position?: PositionType;

  /**
   * periodPicker의 상단 버튼들의 사용여부를 지정하는 속성입니다.
   */
  useControlButton?: boolean;

  /**
   * periodPicker의 왼쪽 하단의 라벨 부분을 custom element로 쓸 때 사용합니다.
   */
  customLabel?: (from?: string, to?: string, onResetFrom?: () => void, onResetTo?: () => void) => any;

  /**
   * 단축키 사용 여부
   */
  useShortCut: boolean;

  /**
   * periodPicker의 확인 버튼을 눌렀을때 발생하는 callback 함수 입니다..
   */
  onConfirm?: () => void;

  /**
   * periodPicker의 취소 버튼을 눌렀을때 발생하는 callback 함수 입니다.
   */
  onCancel?: () => void;

  /**
   * dateButton을 클릭할 때 발생하는 callback 함수 입니다.
   */
  onDateButtonClick?: (e: EventArgs) => void;

  /**
   * 상태 ( disabled, readonly, required ) 를 가진 경우라도 기본 스타일을 유지합니다.
   */
  useStatelessStyle?: boolean;

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
  value: string;

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
  onChange: (e: ChangeEventArgs<string>) => void;

}

export interface OBTDatePickerFieldMethods {
  /**
   * dialog 및 span에 들어갈 date 형식으로 바꿔줍니다.
   */
  changeDate(value: any, length: number, format: string): string;

  /**
   */
  focus(): void;

  /**
   */
  isInvalidChecked(value: any, format: Format): any;

}

// --- Referenced Types ---

enum Type {
    'singleDate' = 'singleDate',
    'periodDate' = 'periodDate',
    'singleYearMonth' = 'singleYearMonth',
    'periodYearMonth' = 'periodYearMonth',
    'singleYear' = 'singleYear'
}

import { AlignType } from 'luna-orbit/OBTFloatingPanel/OBTFloatingPanel';
export enum AlignType {
    'near' = 'near',
    'center' = 'center',
    'far' = 'far'
}

import { PositionType } from 'luna-orbit/OBTFloatingPanel/OBTFloatingPanel';
export enum PositionType {
    'top' = 'top',
    'left' = 'left',
    'right' = 'right',
    'bottom' = 'bottom'
}

```
