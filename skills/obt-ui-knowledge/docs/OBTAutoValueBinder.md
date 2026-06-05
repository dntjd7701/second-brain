# OBTAutoValueBinder

컴포넌트의 ID와 state의 property명을 매핑하여 제어되는 컴포넌트로 자동 처리하는 컴포넌트입니다.

```tsx
import { OBTAutoValueBinder, OBTAutoValueBinderProps, OBTAutoValueBinderMethods } from 'luna-orbit';

export interface OBTAutoValueBinderProps {
  /**
   * state 소유자의 reference입니다.
   * 주로 OBTCardListInterface, OBTDataGridInterface의 instance를 지정합니다. (=this)
   * @type {any}
   * @required 
   */
  owner: {any};

  /**
   * OBTAutoValueBinder가 사용할 state 루트를 지정합니다. 
   *  "."을 통해 Path 를 구성할 수 있습니다. 
   * ex) state = { condition:  { ... } } 인경우, stateRoot={"condition"}
   * @type {string}
   */
  stateRoot?: {string};

  /**
   * OBTAutoValueBinder 하위의 컴포넌트에서 입력된 값이 변경될 때 발생하는 Callback입니다.
   * @param e
   * @returns 
   */
  onChange?: (e: ChangeEventArgs<any>) => void;

  /**
   */
  onValidate?: (e: ValidateEventArgs<any>) => void;

}

export interface OBTAutoValueBinderMethods {
  /**
   */
  refresh(): void;

}
```
