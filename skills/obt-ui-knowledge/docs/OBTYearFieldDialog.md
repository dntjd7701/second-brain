# OBTYearFieldDialog

```tsx
import { OBTYearFieldDialog, OBTYearFieldDialogProps, OBTYearFieldDialogMethods } from 'luna-orbit';

export interface OBTYearFieldDialogProps {
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
  align: AlignType;

  /**
   */
  position: PositionType;

  /**
   */
  required?: boolean;

  /**
   */
  onKeyDown?: (event: KeyboardEvent<HTMLDivElement>) => void;

  /**
   */
  onAccept: (event: any, value: any) => void;

  /**
   */
  customLabel?: (from?: string, to?: string, onResetFrom?: () => void, onResetTo?: () => void) => any;

  /**
   */
  anchorEl?: any;

  /**
   */
  usePortal?: boolean;

}

export interface OBTYearFieldDialogMethods {
  /**
   */
  show(focus: boolean): void;

  /**
   */
  dismiss(): void;

  /**
   */
  focus(): void;

  /**
   */
  containsFocus(): boolean;

}

// --- Referenced Types ---

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
