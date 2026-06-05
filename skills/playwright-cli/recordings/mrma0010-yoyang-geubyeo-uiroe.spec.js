import { test, expect } from '@playwright/test';

test.use({
  ignoreHTTPSErrors: true
});

test('test', async ({ page }) => {
  await page.goto('http://localhost:3000/#/login?logout=Y');
  await page.getByRole('textbox', { name: '아이디를 입력하세요' }).click();
  await page.getByRole('textbox', { name: '아이디를 입력하세요' }).fill('');
  await page.getByRole('textbox', { name: '아이디를 입력하세요' }).press('CapsLock');
  await page.getByRole('textbox', { name: '아이디를 입력하세요' }).fill('peacegrace7701');
  await page.getByRole('textbox', { name: '아이디를 입력하세요' }).press('Enter');
  await page.getByRole('textbox', { name: '비밀번호를 입력하세요' }).click();
  await page.getByRole('textbox', { name: '비밀번호를 입력하세요' }).fill('1');
  await page.getByRole('button', { name: '로그인' }).click();
  await page.locator('li:nth-child(14) > .module-name').first().click();
  await page.getByText('처방등록').click();
  await page.getByRole('button').filter({ hasText: /^$/ }).nth(4).click();
  await page.getByText('정형외과').nth(3).click();
  await page.locator('.OBTDropDownList2_dropDownItem__3eJUv').first().click();
  await page.locator('.OBTDropDownList2_dropDownItem__3eJUv').first().click();
  await page.getByRole('button', { name: '조회', exact: true }).click();
  await page.getByRole('button', { name: '전체' }).click();
  await page.getByRole('button', { name: 'SET SLIP' }).click();
  await page.getByRole('button', { name: '부위' }).click();
  await page.getByRole('button', { name: '가슴' }).dblclick();
  await page.getByRole('button', { name: '적용' }).click();
});