
# Standalone components

## Scope
Governs the use of standalone components, directives, and pipes as the default authoring model. Enforceable via CLI defaults, schematic flags, and decorator inspection.

## Rules
- New components, directives, and pipes MUST be generated as standalone (the Angular CLI default from v17+).
  - Evidence: Angular CLI defaults to standalone generation; the `app.config.ts` file is "Only generated when using the `--standalone` option" (which is the default). Enforceable by verifying absence of `standalone: false` in schematics config.
- Standalone components MUST declare their template dependencies in their own `imports` array.
  - Evidence: "Standalone components specify their dependencies directly instead of getting them through `NgModule`s." Verifiable by decorator metadata inspection.
- Routed standalone components MUST be lazy-loaded using `loadComponent` (single component) or `loadChildren` (child route set).
  - Evidence: Angular provides an official migration schematic (`@angular/core:route-lazy-loading`) that converts eagerly-loaded standalone routes to lazy-loaded routes. Verifiable by route config inspection for absence of `component:` on feature routes.

## Prohibited patterns
- MUST NOT create new `NgModule` declarations for new feature code unless wrapping a third-party module-based library.

## Allowed deviations
- MAY use `NgModule` imports inside a standalone component's `imports` array when consuming module-based third-party libraries.

