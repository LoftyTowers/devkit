# Accessibility i18n

## Scope
This contract governs mechanically verifiable accessibility and internationalisation controls in Angular projects.  
It covers Angular CLI i18n setup, locale configuration, and localised builds.  
It covers route-change focus management, modal focus trapping, and automated accessibility regression checks in CI.

## Rules
- Projects that use `i18n` / `i18n-*` template markers or `$localize` MUST include `@angular/localize` and its type definitions.  
  Verification mechanism: CI file check for `package.json` dependency + `tsconfig*.json` `types: ["@angular/localize"]` + `main.ts` triple-slash reference; Angular CLI build invariant (localised build errors when `@angular/localize` is missing).
- Projects that configure `i18n.locales` in `angular.json` MUST map each locale to a translation file path that exists on disk.  
  Verification mechanism: Config validation (`angular.json` inspection) + CI file-system check for each referenced translation file.
- Projects that build localised variants MUST enable Angular CLI localisation via `ng build --localize` or via the `localize` option in `angular.json`.  
  Verification mechanism: CI script runs `ng build --localize` (or validates `angular.json` build configuration) and fails on non-zero exit.
- Projects that use Angular i18n markers MUST extract messages using `ng extract-i18n`.  
  Verification mechanism: CI script runs `ng extract-i18n` and fails on non-zero exit (Angular CLI invariant).
- Applications that use Angular Router MUST move focus after navigation using `NavigationEnd` and MUST NOT leave focus on the `body` element after a route change.  
  Verification mechanism: E2E test (Playwright/Cypress/Webdriver) that navigates between routes and asserts `document.activeElement` is a main-content target (and is not `document.body`).
- Modal dialog containers MUST trap Tab-key focus while open.  
  Verification mechanism: E2E test that opens the modal, presses Tab through focusable elements, and asserts focus does not escape the modal container; template lint or file check for `cdkTrapFocus` on modal root for designated modal components.
- CI MUST run automated accessibility testing against the rendered application.  
  Verification mechanism: CI script runs an automated accessibility test runner (for example, Lighthouse CI or an axe-core runner) and fails the build on detected violations.

## Prohibited patterns
- Projects MUST NOT use ARIA `role` and `aria-*` attributes in a way that conflicts with ARIA-in-HTML conformance requirements.  
  Verification mechanism: CI script runs automated accessibility testing (and/or a dedicated ARIA conformance check) and fails on violations.

## Allowed deviations
- Projects MAY add `@angular/localize` with `--use-at-runtime` when `$localize` must be used at runtime.  
  Verification mechanism: Config validation of the `ng add` invocation in tooling scripts and/or `package.json` dependency placement, plus TypeScript type check (tsconfig `types`).
