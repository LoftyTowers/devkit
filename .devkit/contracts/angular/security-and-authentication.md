# Security and authentication

## Scope
This contract governs security-sensitive Angular framework APIs and Angular configuration that directly affect protection against XSS and CSRF.  
It applies to all TypeScript, templates, and Angular configuration committed to this repository.  
It excludes server-side authentication, authorisation, and HTTP header configuration that lives outside this repository.

## Rules
- Application code MUST NOT import `HttpClientModule` from `@angular/common/http`.  
  - Verification mechanism: ESLint `no-restricted-imports` (or custom ESLint rule) blocking `HttpClientModule` imports.
- Application code MUST NOT import `HttpClientXsrfModule` from `@angular/common/http`.  
  - Verification mechanism: ESLint `no-restricted-imports` (or custom ESLint rule) blocking `HttpClientXsrfModule` imports.
- Production build configuration MUST set `"aot": true` in `angular.json`.  
  - Verification mechanism: Config validation (CI script inspecting `angular.json` for `aot: true` under the production build target).
- Application code MUST NOT call any `DomSanitizer.bypassSecurityTrust*` method outside `src/app/security/trusted-values.ts` and `src/app/security/trusted-values/**/*.ts`.  
  - Verification mechanism: ESLint `no-restricted-properties` (or custom ESLint rule) banning `bypassSecurityTrustHtml|Script|Style|Url|ResourceUrl` outside the allowlisted file paths.

## Prohibited patterns
- Application code MUST NOT call `withNoXsrfProtection()` in any `provideHttpClient(...)` configuration.  
  - Verification mechanism: ESLint `no-restricted-imports` or custom AST rule — detect `withNoXsrfProtection()` usage within `provideHttpClient()` calls.

## Allowed deviations
(none)
