# Seo and server side rendering

## Scope
This contract governs Angular applications that use server-side rendering, static site generation (prerendering), or hybrid rendering.  
It enforces build configuration and runtime invariants that affect SSR/SSG output correctness and hydration stability.  
It applies to all Angular CLI application projects in this repository that ship public-facing routes.

## Rules
- MUST configure `outputMode` for each application build target as either `server` or `static`.  
  - Verification mechanism: Config validation (angular.json inspection in CI).
- MUST include `provideClientHydration()` in the provider list used to bootstrap the browser build and in the provider list used to bootstrap the server build.  
  - Verification mechanism: CI script / file-system check (search bootstrap configs for `provideClientHydration`).
- MUST keep `angularCompilerOptions.preserveWhitespaces` identical for server and browser builds when hydration is enabled.  
  - Verification mechanism: Config validation (tsconfig.app.json + tsconfig.server.json inspection in CI).
- MUST set `ngSkipHydration` as a static attribute with value `""` or `"true"` when used.  
  - Verification mechanism: Angular compiler option / runtime invariant (enable `strictTemplates` and set extended diagnostic `skipHydrationNotStatic` to `error`).
- MUST NOT apply `ngSkipHydration` to non-component host nodes.  
  - Verification mechanism: Angular runtime invariant (fail CI on `NG0504` during SSR/hydration smoke tests).
- MUST NOT reference the global `document` object in code that can execute during SSR or SSG; MUST inject and use `DOCUMENT` via DI instead.  
  - Verification mechanism: ESLint rule (custom or `no-restricted-globals`) enforced in CI.

## Prohibited patterns
- MUST NOT add `ngSkipHydration` to the root application component host node.  
  - Verification mechanism: CI script / file-system check (pattern search for root selector usage with `ngSkipHydration` and/or root component host binding).
- MUST NOT introduce DOM mutations that cause Angular hydration mismatch errors during client hydration.  
  - Verification mechanism: Angular runtime invariant (fail CI on hydration mismatch errors during SSR/hydration smoke tests).

## Allowed deviations
- MAY override `outputMode` at build time using `ng build --output-mode=<server|static>` if CI still produces the intended artefact type for deployment.
