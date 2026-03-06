# Error handling and logging

## Scope
Governs how the codebase captures runtime faults, HTTP failures, and retries.
Governs how the codebase emits client-side logs and monitoring events.
Governs stack trace preservation and safe, user-facing error messages.

## Rules
- MUST provide a dependency-injection mapping for Angular's global error handler to a project-owned implementation.
  - Verification mechanism: CI script / file-system check that inspects the application bootstrap providers (for `ErrorHandler` mapping); or custom ESLint rule that enforces a provider entry in the bootstrap file.

- MUST NOT throw non-`Error` values.
  - Verification mechanism: `@typescript-eslint/no-throw-literal`.

- MUST NOT call `console.*` in application source files.
  - Verification mechanism: ESLint `no-console` (scoped to `src/**` via overrides if needed).

- MUST enable TypeScript `useUnknownInCatchVariables`.
  - Verification mechanism: CI config validation (tsconfig.json inspection) that fails when the option is missing or false.

- MUST NOT perform API calls using `fetch` or `XMLHttpRequest` in application source files.
  - Verification mechanism: ESLint `no-restricted-globals` (ban `fetch` and `XMLHttpRequest`) or ESLint `no-restricted-syntax` (ban `CallExpression` on `fetch`).


## Prohibited patterns
- MUST NOT import error monitoring SDK packages outside a single approved integration module/library.
  - Verification mechanism: ESLint `no-restricted-imports` (restricted paths/packages) or Nx module boundaries rules.

- MUST NOT assign to `window.onerror` or `window.onunhandledrejection` in application source files.
  - Verification mechanism: ESLint `no-restricted-properties` (restrict `window.onerror` / `window.onunhandledrejection`) or ESLint `no-restricted-syntax`.


## Allowed deviations
- MAY allow `console.*` in test files only under explicit ESLint overrides scoped to `**/*.spec.ts` and `src/test.ts`.

- MAY allow direct monitoring SDK imports in the single approved integration module/library only.
