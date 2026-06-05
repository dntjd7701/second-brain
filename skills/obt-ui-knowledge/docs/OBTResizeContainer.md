# OBTResizeContainer

```tsx
import { OBTResizeContainer, OBTResizeContainerProps, OBTResizeContainerMethods } from 'luna-orbit';

export interface OBTResizeContainerProps {
  /**
   * resize 될때마다 호출되는 콜백입니다.
   */
  onResize: OBTResizeSensorSensorCallback;

  /**
   * css-element-queries ResizeSensor를 사용합니다.
   * 특별한 케이스가 아니라면 사용할 이유가 없습니다.
   */
  useResizeSensor?: boolean;

  /**
   */
  children?: React.ReactNode;

}

export interface OBTResizeContainerMethods {
  /**
   */
  refresh(): void;

}
```
