# OBTAccordionGroup

각 OBTAccordion을 감싸는 부모 컴포넌트입니다.

```tsx
import { OBTAccordionGroup, OBTAccordionGroupProps, OBTAccordionGroupMethods } from 'luna-orbit';

export interface OBTAccordionGroupProps {
  /**
   * 펼쳐질 아코디언의 index 를 지정합니다.
   * @type {number | number[]}
   */
  value?: {number | number[]};

  /**
   * 펼쳐진 아코디언의 index 가 변경될 경우 호출되는 Callback 입니다.
   * @param e - 이벤트 인자입니다.
   */
  onChange?: (e: ChangeEventArgs<number>) => void;

  /**
   * - 다수 아코디언을 각기 다르게 펼칠 수 있습니다.
   * - 단, uncontrolled 형태만 지원합니다.
   * - true : 아코디언 별로 각기 다르게 모두 펼칠 수 있습니다. 
   * - false : 하나의 아코디언만 펼칠 수 있습니다. 하나의 아코디언을 펼치면 다른 아코디언은 자동으로 접히게 됩니다.
   * @default false
   */
  useMultipleExpand?: boolean;

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

export interface OBTAccordionGroupMethods {
  /**
   */
  getOpenedAccordionKeys(): any[];

}
```
