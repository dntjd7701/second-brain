# OBTGanttChart

withApi() HOC 를 사용하면 Props 로 Api 를 사용할 수 있다.
api 가 Optional 로 선언되었기에 내부에서 ! 오퍼레이터를 사용해서 호출한다.
{@code this.props.api!.test();}

```tsx
import { OBTGanttChart, OBTGanttChartProps, OBTGanttChartMethods } from 'luna-orbit';

export interface OBTGanttChartProps {
  /**
   */
  title?: Element;

  /**
   */
  items?: IItem[];

  /**
   */
  today?: Date;

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
   */
  onChange: (e: ChangeEventArgs<any>) => void;

}

export interface OBTGanttChartMethods {
  /**
   */
  focus(): void;

  /**
   */
  handleMouseMove(e: any): void;

}
```
