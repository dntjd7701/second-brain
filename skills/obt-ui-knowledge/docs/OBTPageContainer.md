# OBTPageContainer

페이지 개발시 최상단 HOC입니다.

```tsx
import { OBTPageContainer, OBTPageContainerMethods } from 'luna-orbit';

export interface OBTPageContainerMethods {
  /**
   */
  setLastFocusedGrid(grid: OBTDataGridInterface | OBTListGridInterface | OBTCardListInterface): void;

  /**
   */
  getLastFocusedGrid(): OBTDataGridInterface | OBTListGridInterface | OBTCardListInterface;

  /**
   */
  getTypedPageContainer(pageContainerFunctions: any): IPageContainerFunctions;

  /**
   */
  getTypedUtil(util: any): IUtil;

  /**
   */
  handleDebugger(e: MessageEvent<any>): void;

  /**
   * 권한(PageAuthority)
   */
  getPageAuthority(): IPageAuthority;

  /**
   */
  setPageAuthority(pageAuthority: Partial<IPageAuthority>): void;

  /**
   * 메인버튼변경 함수 
   * REMARK: 수정시 주의사항
   * 이 함수를 호출할때마다 전체렌더링을 일으켜선 안된다.
   * 메뉴단 코딩에 따라 무한렌더링을 일으킬수 있다.
   */
  setMainButtons(mainButtons: IMainButton[]): Promise<void>;

  /**
   */
  getMainButtons(): IMainButton[];

  /**
   */
  showMainButtonTooltip(key: string): void;

  /**
   */
  hideMainButtonTooltip(): void;

  /**
   */
  setUseOneAiDataAnalysis(use: boolean): void;

  /**
   */
  isUseOneAiDataAnalysis(): boolean;

  /**
   * 닫기 핸들러
   */
  setCloseHandler(handler: (e: { close: () => void; }) => boolean): void;

  /**
   */
  getCloseHandler(): any;

  /**
   * 삭제 핸들러
   */
  setDeleteHandler(handler: (e: { target: string; }) => void): void;

  /**
   */
  getDeleteHandler(): any;

  /**
   * 인쇄 핸들러
   */
  setPrintHandler(handler: (e: { target: string; }) => void): void;

  /**
   */
  getPrintHandler(): any;

  /**
   * 활성 핸들러
   */
  setActivateHandler(handler: () => void): void;

  /**
   */
  getActivateHandler(): any;

  /**
   */
  updateHoliday(year: string): Promise<void>;

  /**
   * 모듈코드가 ERP계열인지 여부 리턴
   */
  isERPModule(moduleCode: string, menuFuncType: string): boolean;

  /**
   * 오류보고가 필요한 오류가 발생했을 경우 호출됨.
   * fatalError 가 호출된 경우 모든 오류가 표시가 무시됨.
   */
  fatalError(error: string): Promise<void>;

  /**
   * 내장 로딩바 컨트롤
   */
  showLoading(labelText: any, option: { key?: string; lock?: boolean; type?: Type; }): Promise<void>;

  /**
   * 내장 로딩바 컨트롤
   */
  hideLoading(option: { clearAll?: boolean; key?: string; }): Promise<void>;

  /**
   */
  suspendLoading(): Promise<void>;

  /**
   */
  resumeLoading(): Promise<void>;

  /**
   */
  showProgress(options: IShowProgressOptions): Promise<void>;

  /**
   */
  setProgress(options: ISetProgressOptions): void;

  /**
   */
  hideProgress(): Promise<void>;

  /**
   */
  reload(): void;

  /**
   */
  availableOnlineManual(): boolean;

  /**
   */
  getUseOnlineManual(): boolean;

  /**
   */
  startAutoTutorial(forceFromStart: boolean): Promise<void>;

  /**
   */
  hasTutorialProgress(): boolean;

  /**
   */
  startScenarioTutorial(scenarioId: string | string[]): Promise<void>;

  /**
   */
  registerScenarioTutorial(config: IScenarioConfig): Promise<void>;

  /**
   */
  startAutoTutorialFlow(steps: IAutoTutorialStep[], forceFromStart: boolean, onSkipped: () => void): void;

  /**
   */
  isPrivacyEnabled(): Promise<boolean>;

  /**
   */
  getPrivacyOptions(): Promise<{ privacyEnabled?: boolean; resident?: PrivacyBehaviorEnum; foreign?: PrivacyBehaviorEnum; passport?: PrivacyBehaviorEnum; driver?: PrivacyBehaviorEnum; credit?: PrivacyBehaviorEnum; account?: PrivacyBehaviorEnum; }>;

  /**
   */
  showDialog(createDialogCallback: (close: (result?: any) => void) => any): Promise<any>;

  /**
   */
  isUseMultiLang(): boolean;

  /**
   */
  getMultiLangInfo(): IMultiLangInfo;

  /**
   */
  langCode(): any;

  /**
   * 닫기이벤트 핸들러
   */
  onClose(type: any): boolean;

  /**
   */
  close(force: boolean): void;

  /**
   */
  showPrintDialog(e: { askMasking?: boolean; askReadAllPages?: boolean; }): Promise<{ cancel: boolean; useMasking?: boolean; readAllPages?: boolean; }>;

  /**
   */
  getMenuInfo(): Promise<{ menu: { menuCode: string; pageCode: string; label: string; originLabel: string; }; uiVersion: { version: string; desc?: string; }; blVersion: { version: string; desc?: string; relatedVersions: { pageCode: string; version: string; desc?: string; }[]; }; user: { ...; }; auth: { ...; }; privacy: { ...; }; }>;

  /**
   */
  setLocalStorage(code: string, value: string): void;

  /**
   */
  getLocalStorage(code: string, defaultValue: string): any;

  /**
   */
  removeLocalStorage(code: string): void;

  /**
   */
  setModalInstance(type: string, instance: any): void;

  /**
   */
  getModalInstance(type: string): any;

  /**
   */
  clearModalInstance(type: string, instance: any): void;

  /**
   */
  openCalculator(): void;

  /**
   */
  showPrivacyDownloadReasonDialog(parameters: ParameterForGw094A02): Promise<boolean>;

  /**
   */
  usePrivacyDownloadReason(): Promise<boolean>;

}
```
