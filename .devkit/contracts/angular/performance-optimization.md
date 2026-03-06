# Performance optimization

## Scope

Rules governing Angular application performance including change detection strategy, lazy loading, code splitting, AOT compilation, iteration tracking, bundle budgets, virtual scrolling, and subscription lifecycle management.

## Rules

- Every component MUST set `changeDetection: ChangeDetectionStrategy.OnPush` unless it acts as a dynamic host for user-provided components via `ViewContainerRef.createComponent`.
  **Verification mechanism:** angular-eslint rule `@angular-eslint/prefer-on-push-component-change-detection` set to `"error"`.

- The `@for` block MUST include a `track` expression; the expression MUST reference a property that uniquely identifies each item (e.g. `item.id`).
  **Verification mechanism:** Angular compiler error — compilation fails if `track` is omitted from any `@for` block.

- The `@for` block MUST NOT use `track $index` on collections that are added to, removed from, or reordered at runtime.
  **Verification mechanism:** Custom ESLint rule or code-review CI script scanning templates for `track $index` on non-static collections.

- Production builds MUST use AOT compilation (`"aot": true` in `angular.json`).
  **Verification mechanism:** Angular CLI default (`aot: true` since Angular 9); CI script inspecting `angular.json` build configuration.

- The `angular.json` production configuration MUST define `budgets` for at least the `initial` bundle type with explicit `maximumWarning` and `maximumError` thresholds.
  **Verification mechanism:** `ng build --configuration production` fails when budget thresholds are exceeded; CI script validating presence of `budgets` array in `angular.json`.

- Components inside `@defer` blocks MUST be standalone; non-standalone components MUST NOT be placed inside `@defer` blocks.
  **Verification mechanism:** Angular compiler error — non-standalone components in `@defer` are eagerly loaded and the compiler warns.

- Route definitions for feature areas MUST use `loadComponent` (standalone) or `loadChildren` (route config / module) for lazy loading; feature components MUST NOT be eagerly imported in the root route configuration.
  **Verification mechanism:** Migration schematic `ng generate @angular/core:route-lazy-loading` detects eagerly loaded standalone routes; Nx module boundary rules can enforce import constraints.

- Application source code MUST declare `"sideEffects": false` in the application-level `package.json` (e.g. `src/app/package.json`) to enable advanced tree-shaking.
  **Verification mechanism:** CI file-system check confirming `sideEffects` field exists and equals `false`.

- Zoneless applications MUST NOT reference `NgZone.onMicrotaskEmpty`, `NgZone.onUnstable`, `NgZone.isStable`, or `NgZone.onStable`.
  **Verification mechanism:** Custom ESLint rule or `grep`-based CI script scanning for prohibited `NgZone` observable references.

- Zoneless applications MUST remove `zone.js` and `zone.js/testing` from the `polyfills` array in both `build` and `test` targets of `angular.json`.
  **Verification mechanism:** CI script inspecting `angular.json` polyfills entries for `zone.js`.

- The `angularCompilerOptions` in `tsconfig.json` MUST set `"strictTemplates": true`.
  **Verification mechanism:** TypeScript / Angular compiler option check in `tsconfig.json`.

- The `dk-virtual-scroll-viewport>` element MUST have an explicit `itemSize` attribute and an explicit CSS `height`.
  **Verification mechanism:** Angular runtime error if `itemSize` is missing; CSS lint or code review for height.

## Prohibited patterns

- MUST NOT use `ChangeDetectionStrategy.Default` on application components (library host components excluded per Scope).

- MUST NOT use `*ngFor` without `trackBy` in legacy templates; prefer `@for` with `track` in new code.

- MUST NOT place components visible in the initial viewport inside `@defer` blocks with `on immediate`, `on timer`, or `on viewport` triggers — this degrades CLS.

- MUST NOT use barrel re-exports with wildcard imports (`import * as`) for application code — this prevents effective tree-shaking.

- MUST NOT subscribe to long-lived observables without an unsubscription mechanism (`takeUntilDestroyed`, `AsyncPipe`, or explicit `unsubscribe`).

## Allowed deviations

- MAY use `ChangeDetectionStrategy.Default` on library components that host user-provided components via `ViewContainerRef.createComponent`.

- MAY use `track $index` for collections that are guaranteed static and never mutated after initial assignment.

- MAY use `track item` (identity tracking) when no unique property exists, with the understanding that this degrades re-render performance.

- MAY omit `@defer` for components that are small and always visible above the fold.
