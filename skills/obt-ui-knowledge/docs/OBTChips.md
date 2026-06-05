# OBTChips

데이터 소스를 칩의 형태로 표시하는 컴포넌트입니다. 
개별 Chip 항목은 x버튼 클릭으로 삭제할 수 있고 드래그앤드랍으로 요소를 추가할 수도 있습니다.

```tsx
import { OBTChips, OBTChipsProps, OBTChipsMethods } from 'luna-orbit';

export interface OBTChipsProps {
  /**
   * 컴포넌트의 기본 데이터 List를 지정합니다.
   */
  list: any[];

  /**
   * 컴포넌트 Chip 요소 안에 들어가는 형식으로 Mapping 지정합니다.
   */
  onMapItem: (e: RenderItemEventArgs) => void;

  /**
   * 컴포넌트에서 버튼 클릭시 발생하는 Callback 함수입니다.
   */
  onRemoveItem?: (e: ChangeEventArgs) => void;

  /**
   * 컴포넌트에서 Drop 발생하는 Callback 함수입니다.
   */
  onDropItem?: (e: ChangeEventArgs<any>) => void;

  /**
   * chip을 드래그하여 순서를 변경할 수 있습니다.
   */
  onItemIndexChanged?: (e: { target: any; dragStartItem: any; dragStartItemIndex: number; dragEndItemIndex: number; }) => void;

  /**
   * 클릭이벤트
   */
  onClick?: (e: { target: any; index: number; item: any; e: MouseEvent<Element, MouseEvent>; }) => void;

  /**
   * 드래그를 통해 chip의 순서 변경이 가능하도록 하는 옵션입니다.  
   * onItemIndexChanged를 통해 받아오는 드래그 시작 index 끝 index로 데이터의 처리가 추가적으로 필요합니다.
   * @default false
   */
  useDragAndDrop?: boolean;

  /**
   * required 스타일을 chip에 할지 background에 할지 지정할수 있는 옵션입니다.
   * @type {RequiredMode}
   * @default "chip"
   */
  requiredMode?: {RequiredMode};

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
   * 필수입력 여부
   * true로 설정시 OBTFormPanel, OBTConditionPanel등 컨테이너에서 필수적으로 값이 입력되어야하는 컴포넌트로 인식한다.
   * @default false
   */
  required: boolean;

}

export interface OBTChipsMethods {
  /**
   */
  validate(): boolean;

}

// --- Referenced Types ---

enum RequiredMode {
    /**
     * chip요소에 필수값 색상처리
     */
    'chip' = 'chip',
    /**
     * 배경에 필수값 색상처리
     */
    'background' = 'background',
}

```
