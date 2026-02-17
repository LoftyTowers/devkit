# Performance optimization

## Procedure: Enable OnPush globally via schematics

### When to use
When setting up a new project or enforcing OnPush as the default for all generated components.

### Preconditions
- Angular CLI project with `angular.json` present.
- `@angular-eslint` installed.

### Steps
1. Open `angular.json` and add or update the `schematics` property under your project:
   ```json
   "schematics": {
     "@schematics/angular:component": {
       "changeDetection": "OnPush"
     }
   }
   ```
2. Add the angular-eslint rule to your ESLint configuration:
   ```json
   {
     "rules": {
       "@angular-eslint/prefer-on-push-component-change-detection": ["error"]
     }
   }
   ```
3. Run `ng lint` to identify existing components missing `OnPush`.
4. Update each flagged component to add `changeDetection: ChangeDetectionStrategy.OnPush`.

### Validation
- `ng lint` passes with zero `prefer-on-push-component-change-detection` errors.
- Newly generated components via `ng generate component` include `changeDetection: ChangeDetectionStrategy.OnPush` in their decorator.

***

## Procedure: Enable zoneless change detection

### When to use
When adopting zoneless mode on Angular v20+ (experimental) or v21+ (stable) to eliminate ZoneJS overhead.

### Preconditions
- All application components are `OnPush`-compatible or use signals / `AsyncPipe` / `markForCheck` for state change notification.
- No code references `NgZone.onMicrotaskEmpty`, `NgZone.onUnstable`, `NgZone.isStable`, or `NgZone.onStable`.

### Steps
1. Add `provideZonelessChangeDetection()` (v21+) or `provideExperimentalZonelessChangeDetection()` (v20) to the application bootstrap providers:
   ```typescript
   bootstrapApplication(AppComponent, {
     providers: [provideZonelessChangeDetection()]
   });
   ```
2. Remove `zone.js` from the `polyfills` array in `angular.json` under both `build` and `test` targets.
3. Remove `zone.js/testing` from the `test` target polyfills.
4. Run `npm uninstall zone.js`.
5. Replace any `NgZone.onStable` or `NgZone.onMicrotaskEmpty` usage with `afterNextRender` or `afterRender`.
6. For SSR, wrap async tasks that must complete before serialisation in `PendingTasks.run()`.

### Validation
- `ng build --configuration production` succeeds without `zone.js` in the output bundle.
- `ng test` passes with `provideZonelessChangeDetection()` in `TestBed` configuration.
- Run `provideCheckNoChangesConfig({exhaustive: true, interval: 500})` (v21+) or `provideExperimentalCheckNoChangesForDebug({interval: 500})` (v20) in development mode and confirm no `ExpressionChangedAfterItHasBeenCheckedError` is thrown.

***

## Procedure: Configure route lazy loading with preloading

### When to use
When splitting an application into lazy-loaded feature chunks and configuring a preloading strategy.

### Preconditions
- Feature components are standalone or wrapped in feature route configurations.
- `provideRouter` or `RouterModule.forRoot` is configured at the application root.

### Steps
1. Define lazy routes using `loadComponent` or `loadChildren`:
   ```typescript
   export const routes: Routes = [
     {
       path: 'dashboard',
       loadComponent: () =>
         import('./dashboard/dashboard.component').then(m => m.DashboardComponent)
     },
     {
       path: 'admin',
       loadChildren: () =>
         import('./admin/admin.routes').then(m => m.ADMIN_ROUTES)
     }
   ];
   ```
2. Configure preloading strategy at bootstrap:
   ```typescript
   bootstrapApplication(AppComponent, {
     providers: [
       provideRouter(routes, withPreloading(PreloadAllModules))
     ]
   });
   ```
3. For selective preloading, implement `PreloadingStrategy` and filter by route `data` property.
4. Run the migration schematic to convert existing eager routes:
   ```bash
   ng generate @angular/core:route-lazy-loading
   ```

### Validation
- `ng build --configuration production` produces separate chunk files for each lazy route.
- Browser DevTools Network tab confirms lazy chunks load on navigation (or on preload, depending on strategy).

***

## Procedure: Implement @defer for below-the-fold content

### When to use
When heavy standalone components are not visible in the initial viewport and can be loaded on demand.

### Preconditions
- Target components are standalone.
- Target components are not directly referenced outside `@defer` blocks in the same file.

### Steps
1. Wrap the target component in a `@defer` block with the appropriate trigger:
   ```html
   @defer (on viewport; prefetch on idle) {
     <heavy-chart-component />
   } @placeholder (minimum 200ms) {
     <div class="chart-skeleton"></div>
   } @loading (after 100ms; minimum 500ms) {
     <spinner />
   } @error {
     <p>Failed to load chart</p>
   }
   ```
2. Remove the static import of the deferred component from the host component's `imports` array — Angular handles the dynamic import automatically.

### Validation
- `ng build --configuration production` produces a separate chunk for the deferred component.
- Browser DevTools Network tab confirms the chunk loads only when the trigger fires.

***

## Procedure: Add virtual scrolling for large lists

### When to use
When rendering lists exceeding ~100 items that cause perceptible scroll jank or slow initial render.

### Preconditions
- `@angular/cdk` is installed.

### Steps
1. Import `ScrollingModule` (or `CdkVirtualScrollViewport` + `CdkVirtualFor` if standalone):
   ```typescript
   import { ScrollingModule } from '@angular/cdk/scrolling';
   ```
2. Wrap the list in `dk-virtual-scroll-viewport>` with `itemSize` and a fixed CSS height:
   ```html
   dk-virtual-scroll-viewport itemSize="48" style="height: 400px">
     <div *cdkVirtualFor="let item of items">{{ item.name }}</div>
   </cdk-virtual-scroll-viewport>
   ```
3. Replace `*ngFor` (or `@for`) with `*cdkVirtualFor` inside the viewport.

### Validation
- Scroll the list and confirm via Chrome DevTools Elements panel that only a subset of DOM nodes is rendered at any time.
- Performance profiler shows no long frames during scrolling.

***

## Procedure: Configure bundle budgets

### When to use
When establishing or updating bundle size guardrails in CI.

### Preconditions
- Angular CLI project with `angular.json`.

### Steps
1. Open `angular.json` and locate the production configuration under `architect > build > configurations > production`.
2. Add or update the `budgets` array:
   ```json
   "budgets": [
     {
       "type": "initial",
       "maximumWarning": "250kb",
       "maximumError": "500kb"
     },
     {
       "type": "anyComponentStyle",
       "maximumWarning": "4kb",
       "maximumError": "8kb"
     }
   ]
   ```
3. Run `ng build --configuration production`.

### Validation
- Build succeeds if within budget; build fails with `Budget exceeded` error if thresholds are violated.
- CI pipeline gates merge on budget pass.

***

## Procedure: Set up takeUntilDestroyed for subscription management

### When to use
When subscribing to long-lived observables in component classes (non-template usage).

### Preconditions
- Angular 16+ with `@angular/core/rxjs-interop` available.

### Steps
1. Import `takeUntilDestroyed` from `@angular/core/rxjs-interop`.
2. In the constructor (injection context), pipe the observable through `takeUntilDestroyed()`:
   ```typescript
   import { takeUntilDestroyed } from '@angular/core/rxjs-interop';

   @Component({...})
   export class MyComponent {
     constructor() {
       this.someService.data$
         .pipe(takeUntilDestroyed())
         .subscribe(data => this.handleData(data));
     }
   }
   ```
3. If subscribing outside the constructor, inject `DestroyRef` and pass it explicitly:
   ```typescript
   private destroyRef = inject(DestroyRef);

   ngOnInit() {
     this.someService.data$
       .pipe(takeUntilDestroyed(this.destroyRef))
       .subscribe(data => this.handleData(data));
   }
   ```

### Validation
- Component destruction triggers observable completion — verify in unit tests by spying on subscription teardown.
- Chrome DevTools Memory panel shows no retained subscriptions after component navigation.

***