# OBTLoading

OBTLoading
Prop : { className }

```tsx
import { OBTLoading, OBTLoadingProps } from 'luna-orbit';

export interface OBTLoadingProps {
  /**
   * 로딩바 컴포넌트에 표시할 텍스트
   */
  labelText?: any;

  /**
   * 원 안의 퍼센테이지 값을 지정합니다.
   */
  value?: string;

  /**
   * 로딩뷰의 타입
   * small | default | large
   */
  type: Type;

  /**
   * 풀스크린 여부
   */
  fullScreen: boolean;

  /**
   * 로딩바의 열림 여부
   */
  open: boolean;

  /**
   * default, large 타입일때 
   * overlay dimmed 처리 여부
   */
  useDimmedBackground?: boolean;

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

export enum Type {
    'small' = 'small',
    'default' = 'default',
    'large' = 'large'
}

```
