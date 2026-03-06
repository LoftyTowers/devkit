# Performance optimization

## Context

Performance optimization in Angular spans change detection efficiency, bundle size management, rendering strategies, and resource lifecycle. Decisions in this area directly affect Time to Interactive, Largest Contentful Paint, and long-term memory stability. The guidance below applies to Angular applications using the modern standalone component model with signals-based reactivity as the primary state management approach.

## Guidance

- Prefer signals (`signal()`, `computed()`, `linkedSignal()`) over manual `ChangeDetectorRef.markForCheck()` calls for notifying Angular of state changes. Signals provide granular reactivity and are the recommended path toward zoneless change detection.

- Prefer `AsyncPipe` (or `toSignal()`) in templates over manual `.subscribe()` calls in component classes. `AsyncPipe` automatically manages subscription lifecycle and triggers `markForCheck` on `OnPush` components.

- Organise lazy-loaded routes by feature area. Use `loadComponent` for single standalone components and `loadChildren` pointing to a routes file for feature areas with child routes.

- Separate above-the-fold content from deferred content. Use `@defer` blocks with appropriate triggers (`on viewport`, `on interaction`, `on hover`) for below-the-fold or conditionally displayed heavy components.

- Prefer `@defer (on interaction; prefetch on idle)` for components that are likely to be needed soon but not immediately visible — this prefetches resources while the browser is idle and renders on user interaction.

- Avoid nested `@defer` blocks with identical triggers to prevent cascading network requests.

- Prefer `providedIn: 'root'` for services to enable tree-shaking of unused injectables.

- Prefer deep imports (`import { debounceTime } from 'rxjs'`) over namespace imports to improve tree-shaking effectiveness.

- Consider `withPreloading(PreloadAllModules)` for applications with a small number of lazy-loaded routes. For applications with many routes, implement a custom `PreloadingStrategy` that selectively preloads based on route metadata or link visibility.

- Structure `@for` track expressions to reference a stable unique identifier (database ID, UUID). Avoid referencing derived or computed values that change between renders.

- Avoid `@defer (on immediate)` on content that is visible in the initial viewport — this triggers loading immediately after render and offers no lazy-loading benefit while introducing layout shift risk.

## Trade-offs

- `OnPush` reduces change detection cycles but requires immutable data patterns or explicit notification via signals / `markForCheck`. Mutable object mutations without reference changes silently prevent template updates.

- Zoneless eliminates ZoneJS overhead (payload + patching cost) but requires all state mutations to use Angular-aware notification mechanisms (signals, `AsyncPipe`, `markForCheck`). Existing code relying on ZoneJS implicit change detection will break.

- `@defer` reduces initial bundle size but introduces network latency at trigger time. Aggressive deferral of above-the-fold content degrades LCP and increases CLS.

- `PreloadAllModules` eliminates navigation latency for all routes but increases total bandwidth consumption on initial page load.

- Virtual scrolling (`cdk-virtual-scroll-viewport`) dramatically reduces DOM node count for large lists but requires fixed or predictable item heights and adds complexity for accessibility (screen reader item count).

- `track $index` is simpler but causes full DOM recreation on any insertion, deletion, or reorder — suitable only for static display lists.

## Decision criteria

- Use `@defer (on viewport)` when the deferred component is below the fold and the user may or may not scroll to it.

- Use `@defer (on idle; prefetch on idle)` when the component is needed soon after initial render but not visible in the initial viewport.

- Use `@defer (on interaction)` when the component is revealed by explicit user action (tab click, accordion expand).

- Use `PreloadAllModules` when the application has fewer than ~10 lazy-loaded route chunks. Switch to a custom `PreloadingStrategy` when the route count exceeds this threshold.

- Use virtual scrolling when rendering more than ~100 items in a scrollable list or when items contain non-trivial component trees.

- Adopt zoneless (`provideZonelessChangeDetection()`) for new applications on Angular v21+. For existing applications on older versions, use `provideExperimentalZonelessChangeDetection()` and validate with `provideExperimentalCheckNoChangesForDebug`.

## Preferences

- PREFERENCE — JUSTIFIED: Configure Angular CLI schematics in `angular.json` to generate all new components with `changeDetection: ChangeDetectionStrategy.OnPush` by default. This prevents accidental use of `Default` strategy on newly generated components.

- PREFERENCE — JUSTIFIED: Use `takeUntilDestroyed()` from `@angular/core/rxjs-interop` over manual `Subject` + `takeUntil` + `ngOnDestroy` patterns for subscription cleanup. The operator is more concise, less error-prone, and directly tied to the injection context lifecycle.

- PREFERENCE — JUSTIFIED: Use `source-map-explorer` or `webpack-bundle-analyzer` in CI to audit bundle composition after each merge to `main`. This catches accidental dependency bloat before deployment. NO PRIMARY SUPPORT — SECONDARY ONLY.
