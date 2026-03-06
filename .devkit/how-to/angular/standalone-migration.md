
# Standalone migration

## Procedure: Migrate eagerly-loaded routes to lazy-loaded standalone routes
When to use: When converting an existing Angular application's eagerly-loaded component routes to lazy-loaded routes for improved initial bundle size.
### Steps:
1. Run the official migration schematic: `ng generate @angular/core:route-lazy-loading`
2. Optionally scope to a subdirectory: `ng generate @angular/core:route-lazy-loading --path src/app/sub-component`
3. The schematic will find all route definitions (`provideRouter`, `RouterModule.forRoot`, variables of type `Routes`), check for standalone eagerly-loaded components, and convert them to `loadComponent: () => import(...)` syntax.
4. Review the schematic output for any non-standalone components declared in NgModules; the schematic will list these. Consider converting them to standalone first, then re-running the migration.
### Evidence to capture:
- Build output showing reduced main bundle size (before/after comparison).
- Route configuration files confirming `loadComponent` / `loadChildren` usage.

## Procedure: Migrate constructor injection to inject() function
When to use: When adopting the angular.dev style guide recommendation to prefer `inject()` over constructor parameter injection.
### Steps:
1. Run the official migration schematic: `ng generate @angular/core:inject`
2. The schematic converts constructor-based injection to `inject()` field initializers across all classes.
3. Review converted files: confirm dependencies are declared as class fields using `inject()` (e.g. `private readonly http = inject(HttpClient);`).
4. Remove now-empty constructors if no other logic remains.
### Evidence to capture:
- Diff showing constructor parameters replaced by `inject()` field initializers.
- Passing test suite confirming no regressions.

