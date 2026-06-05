# OBTExcelImportDialog

엑셀 import 팝업 컴포넌트입니다.

```tsx
import { OBTExcelImportDialog, OBTExcelImportDialogMethods } from 'luna-orbit';

export interface OBTExcelImportDialogMethods {
  /**
   */
  initializeGrid(): OBTDataGridInterface;

  /**
   */
  handleDialogAfterOpen(): void;

  /**
   */
  openFile(e: { menuCode: string; tableName: string; fetch?: any; formData?: FormData[]; onAfterFormDataReceive?: (e: { coCd?: string; formData?: FormData[]; }) => Promise<FormData[]>; useValidation?: boolean; onValidate?: (e: { ...; }) => void; onError?: (e: { ...; }) => void; }): Promise<any>;

}
```
