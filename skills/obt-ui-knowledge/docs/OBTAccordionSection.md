# OBTAccordionSection

아코디언 하위에 아코디언 섹션을 표시하는 컴포넌트입니다.

```tsx
import { OBTAccordionSection, OBTAccordionSectionProps } from 'luna-orbit';

export interface OBTAccordionSectionProps {
  /**
   * 섹션의 타이틀 우측에 버튼을 표시할 수 있습니다.
   * @type {JSX.Element}
   */
  button?: {JSX.Element};

  /**
   * 섹션 타이틀 우측에 상태를 표시할 수 있습니다.
   * @type {IStateLabel}
   * @see {@link IStateLabel }
   */
  state?: {IStateLabel};

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
   * 라벨에 표시될 문구
   */
  labelText?: string;

}


// --- Referenced Types ---

import { IStateLabel } from 'luna-orbit/OBTAccordion/OBTAccordion';
export interface IStateLabel {
    /**
     * 표시할 텍스트를 지정합니다.
     * @required
     */
    labelText?: string,
    /**
     * stateLabel의 색을 지정합니다.(HEX)
     * @required
     */
    color?: string
}

```
