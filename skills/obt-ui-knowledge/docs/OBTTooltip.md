# OBTTooltip

OBTTooltip은 요약된 정보를 좀 더 상세히 표현하기 위해 사용됩니다.

```tsx
import { OBTTooltip, OBTTooltipProps } from 'luna-orbit';

export interface OBTTooltipProps {
  /**
   * 값이 true 이면, tooltip이 띄워집니다. 기본으로 부모 요소에 마우스 오버했을 때나 포커스가 잡혔을 때 tooltip이 열리게 됩니다.
   * @type {boolean}
   */
  value?: {boolean};

  /**
   * 라벨에 표시될 문구를 지정합니다.
   * @type {any | string}
   * @required 
   */
  labelText?: {any | string};

  /**
   * 컴포넌트를 띄울 위치를 지정합니다.
   * @type {PositionType}
   * @see {@link PositionType }
   * @default top
   */
  position?: {PositionType};

  /**
   * 컴포넌트의 정렬 상태를 지정합니다. (position 내에서 anchor 와 툴팁의 정렬을 지정)
   * @type {AlignType}
   * @see {@link AlignType }
   * @default center
   */
  align?: {AlignType};

  /**
   * 툴팁의 배경색에 대한 테마를 지정합니다
   * @type {TooltipTheme}
   * @see {@link TooltipTheme }
   * @default default
   */
  theme?: {TooltipTheme};

  /**
   * 컴포넌트에 focus 됐을 때 tooltip을 유지 시킬지 지정 합니다
   * @type {boolean}
   */
  focusValue?: {boolean};

  /**
   * @default true
툴팁 고정 버튼 노출 유무를 지정합니다.
   */
  useFixButton?: boolean;

  /**
   */
  useNormalLineHeight?: boolean;

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
   * Focus 가 발생한 경우 발생하는 Callback 함수
   */
  onFocus?: (e: FocusEventArgs) => void;

  /**
   * Focus 를 잃은 경우 발생하는 Callback 함수
   */
  onBlur?: (e: EventArgs) => void;

  /**
   */
  onActivate?: (e: EventArgs) => void;

  /**
   */
  onDeactivate?: (e: EventArgs) => void;

  /**
   * Click 시 발생하는 Callback 함수
   */
  onClick?: (e: MouseEventArgs) => void;

  /**
   */
  onDblClick?: (e: MouseEventArgs) => void;

  /**
   * MouseDown 시 발생하는 Callback 함수
   */
  onMouseDown?: (e: MouseEventArgs) => void;

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


// --- Referenced Types ---

import { PositionType } from 'luna-orbit/OBTFloatingPanel/OBTFloatingPanel';
export enum PositionType {
    'top' = 'top',
    'left' = 'left',
    'right' = 'right',
    'bottom' = 'bottom'
}

import { AlignType } from 'luna-orbit/OBTFloatingPanel/OBTFloatingPanel';
export enum AlignType {
    'near' = 'near',
    'center' = 'center',
    'far' = 'far'
}

export enum TooltipTheme {
    'blue' = 'blue',
    'black' = 'black',
    'red' = 'red',
    'orange' = 'orange',
    'green' = 'green',
    'default' = 'default',
    'required' = 'required'
}

```
