# OBTGroupSelector

데이터 배열을 카드형태의 리스트로 렌더링합니다.
데이터를 제공되는 템플릿에 맞게 가공하는 처리를 해주거나 (onMapItem) 각 데이터의 렌더링 로직을 직접 작성해줍니다. (onRenderItem)  
전체 항목의 수가 주어진 영역에 담지못할 정도로 크면 리스트를 넘겨볼수 있게 끝단에 화살표 버튼이 추가됩니다.
렌더링된 항목은 단일항목을 선택하는 것이 가능합니다. (value) 선택한 항목은 하이라이팅됩니다.  
다른 항목을 클릭한다면 해당 항목의 키값이 onChange 콜백으로 전달됩니다.

```tsx
import { OBTGroupSelector, OBTGroupSelectorProps, OBTGroupSelectorMethods } from 'luna-orbit';

export interface OBTGroupSelectorProps {
  /**
   * 항목들의 정렬 방향을 지정하는 옵션입니다.
   */
  align?: AlignType;

  /**
   * 템플릿을 선택합니다.  
   * 템플릿을 지정하지 않으면 onRenderItem을 구현해서 직접 렌더링 로직을 구현할것을 요구합니다.
   */
  template?: TemplateType;

  /**
   * 컴포넌트에 주입할 리스트입니다.
   * @required 
   */
  list: any[];

  /**
   * 아이템의 키값에 해당하는 프로퍼티를 지정하는 옵션입니다.
   * @default "key"
   */
  itemKeyProperty: string;

  /**
   * 아이템의 너비를 지정하는 옵션입니다.
   * @default "183px"
   */
  itemWidth: string;

  /**
   * 아이템의 높이 지정를 지정하는 옵션입니다.
   * @default "70px"
   */
  itemHeight: string;

  /**
   * 템플릿 사용시 list props에 할당한 데이터를 템플릿 형식에 맞는 객체로 변환시키는 콜백함수입니다.
   * 인자로 전달되는 e.list를 변환헤 e.item에 할당하는 식으로 시용합니다.
   * @param e - 이벤트 객체
   * @param e.list - 매핑할 단일 객체
   * @param e.item - 매핑전략객체
   */
  onMapItem?: (e: MapItemEventArgs) => void;

  /**
   * 템플릿을 사용하지 않을 때, 리스트를 변환시켜 하나의 아이템 요소로 만드는 콜백함수입니다.
   * @param e - 이벤트 객체
   * @param e.list - 매핑할 단일 객체
   * @param e.component - 변환되는 JSX
   */
  onRenderItem?: (e: RenderItemEventArgs) => void;

  /**
   * 좌우 이동 버튼을 숨길지 말지 지정하는 옵션입니다.
   */
  autoHideButtons?: boolean;

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
   * 제어되는 컴포넌트의 value
   * value의 변경이 감지되면 onChange 이벤트가 호출된다.
   * @required 
   */
  value: string;

  /**
   */
  onChange: (e: ChangeEventArgs<string>) => void;

  /**
   * 활성화여부
   * @default false
   */
  disabled: boolean;

}

export interface OBTGroupSelectorMethods {
  /**
   */
  onRenderItem(list: any, onRenderItem: any, template: any, onDefault: any, onMapItem: any, value: any, mouseOverKey: string, itemKeyProperty: string): any;

  /**
   */
  onClickPrev(): void;

  /**
   */
  onClickNext(): void;

  /**
   */
  countItems(): any;

}

// --- Referenced Types ---

enum AlignType {
    /**
     * 수평
     */
    'horizontal' = 'horizontal',

    /**
     * 수직
     */
    'vertical' = 'vertical'
}

'default' = 'default'

```
