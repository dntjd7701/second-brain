# OBTBasicColorPicker

```tsx
import { OBTBasicColorPicker, OBTBasicColorPickerProps } from 'luna-orbit';

export interface OBTBasicColorPickerProps {
  /**
   */
  color: any;

  /**
   */
  hex?: string;

  /**
   */
  rgb?: IRGB;

  /**
   */
  type?: MainType;

  /**
   */
  onChange: (e: any) => void;

  /**
   */
  onButtonClick?: (e: EventArgs) => void;

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

}


// --- Referenced Types ---

interface IRGB {
    r: number,
    g: number,
    b: number,
    a: number
}

enum MainType {
    'basic' = 'basic',
    'popUp' = 'popUp'
}

```
