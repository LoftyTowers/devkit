# Performance optimization

## Checklist

- [ ] Verify every component has `changeDetection: ChangeDetectionStrategy.OnPush` by running `ng lint` with `@angular-eslint/prefer-on-push-component-change-detection` set to `"error"`.[^3][^29]

- [ ] Verify `angular.json` schematics configure `changeDetection: "OnPush"` for `@schematics/angular:component`.[^29]

- [ ] Verify every `@for` block includes a `track` expression referencing a unique identifier — confirm by successful `ng build`.[^4]

- [ ] Verify no `@for` block uses `track $index` on a dynamically mutated collection — inspect templates via search or custom lint rule.[^4]

- [ ] Verify production configuration in `angular.json` has `"aot": true` (default since Angular 9).[^6]

- [ ] Verify `angular.json` production configuration contains a `budgets` array with `initial` type thresholds defined.[^9]

- [ ] Verify `ng build --configuration production` completes without budget-exceeded errors.[^9]

- [ ] Verify `"sideEffects": false` is declared in `src/app/package.json` (or equivalent).[^14]

- [ ] Verify all feature routes use `loadComponent` or `loadChildren` — confirm by inspecting the route configuration or running `ng generate @angular/core:route-lazy-loading --dry-run`.[^12]

- [ ] Verify a preloading strategy is configured via `withPreloading()` or `preloadingStrategy` in the router configuration.[^27][^30]

- [ ] Verify no `@defer` block wraps content that is visible in the initial viewport with `on immediate` or `on timer` triggers.[^10]

- [ ] Verify `@defer` blocks for below-the-fold components include `@placeholder` and `@loading` sub-blocks.[^10]

- [ ] Verify `angularCompilerOptions` includes `"strictTemplates": true` in `tsconfig.json`.[^7]

- [ ] Verify `zone.js` is removed from `polyfills` in `angular.json` if using zoneless change detection.[^2]

- [ ] Verify no code references `NgZone.onMicrotaskEmpty`, `NgZone.onUnstable`, `NgZone.isStable`, or `NgZone.onStable` in zoneless applications.[^2]

- [ ] Verify every manual `.subscribe()` call on a long-lived observable is paired with `takeUntilDestroyed()`, `AsyncPipe`, or explicit `unsubscribe()` in a destroy hook.[^20][^21][^19]

- [ ] Verify `setTimeout` and `setInterval` calls in components are cleared in `ngOnDestroy`.[^31][^20]

- [ ] Verify event listeners attached to `window`, `document`, or other global objects are removed in `ngOnDestroy`.[^20]

- [ ] Verify virtual scrolling is implemented for any list rendering more than ~100 items — confirm `cdk-virtual-scroll-viewport` with `itemSize` and explicit height.[^16][^17]

- [ ] Confirm `ng build --configuration production` produces separate chunk files for each lazy-loaded route.[^12]