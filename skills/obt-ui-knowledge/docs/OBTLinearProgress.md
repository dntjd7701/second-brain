# OBTLinearProgress

```tsx
import { OBTLinearProgress, OBTLinearProgressProps } from 'luna-orbit';

export interface OBTLinearProgressProps {
  /**
   */
  type: Type;

  /**
   */
  value: number;

  /**
   */
  labelText?: any;

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


// --- Referenced Types ---

enum Type {
    'error' = 'error',
    'default' = 'default',
    'warning' = 'warning'
}

```
