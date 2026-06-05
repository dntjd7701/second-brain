# OBTYearCalendar

```tsx
import { OBTYearCalendar, OBTYearCalendarProps, OBTYearCalendarMethods } from 'luna-orbit';

export interface OBTYearCalendarProps {
  /**
   */
  max?: string;

  /**
   */
  min?: string;

  /**
   */
  value: string;

  /**
   */
  onChange: (event: any, value: number) => void;

}

export interface OBTYearCalendarMethods {
  /**
   */
  addYear(add: number): void;

  /**
   */
  getTableElement(props: any, state: any): Element[];

  /**
   * 년 버튼이 눌렸을 때 호출됩니다.
   */
  onClickYear(event: any, selectYear: number): void;

}
```
