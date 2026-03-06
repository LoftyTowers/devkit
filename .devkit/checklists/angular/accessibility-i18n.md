# Accessibility i18n

## Checklist

- [ ] Verify `package.json` includes `@angular/localize` and `tsconfig*.json` includes `types: ["@angular/localize"]` when the codebase uses `i18n` / `i18n-*` or `$localize`.
- [ ] Ensure `main.ts` contains `/// <reference types="@angular/localize" />` (or an equivalent, repo-agreed mechanism) for projects using Angular localisation features.
- [ ] Verify each locale listed in `projects.<project>.i18n.locales` references a translation file path that exists on disk.
- [ ] Ensure `ng extract-i18n` runs successfully in CI for projects using i18n markers and produces the expected source messages file output.
- [ ] Confirm CI builds localised variants using `ng build --localize` or the `localize` option in `angular.json`.
- [ ] Verify an E2E test asserts focus moves on route navigation completion (`NavigationEnd`) and does not remain on `document.body`.
- [ ] Ensure an E2E test asserts modal dialogs trap Tab focus while open and provide a keyboard-accessible exit path.
- [ ] Confirm CI runs automated accessibility testing against the rendered application and fails on detected violations.
