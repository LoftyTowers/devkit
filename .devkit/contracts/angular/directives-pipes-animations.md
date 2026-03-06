# Directives pipes animations

## Scope
Governs how the codebase defines and verifies custom directives, custom pipes, and animation APIs.
Covers directive and pipe selectors/names, pipe purity, and approved animation primitives.
Covers route view-transition styling placement requirements.

## Rules
- MUST use a camelCase attribute selector with the configured application prefix for every custom directive. Verification mechanism: `@angular-eslint/directive-selector` (ESLint).
- MUST use the `host` metadata property for directive host bindings/listeners instead of `@HostBinding` and `@HostListener`. Verification mechanism: `@angular-eslint/prefer-host-metadata-property` (ESLint).
- MUST NOT apply more than one structural directive using the shorthand asterisk (`*`) syntax on the same element. Verification mechanism: Angular template compiler invariant (AOT/JIT template parse).
- MUST implement `PipeTransform` for every custom pipe class. Verification mechanism: `@angular-eslint/use-pipe-transform-interface` (ESLint).
- MUST NOT declare impure pipes by setting `pure: false` in `@Pipe` metadata. Verification mechanism: `@angular-eslint/no-pipe-impure` (ESLint).
- MUST enforce an application-specific prefix for custom pipe names. Verification mechanism: `@angular-eslint/pipe-prefix` (ESLint).
- MUST NOT import from `@angular/animations`. Verification mechanism: `@typescript-eslint/no-restricted-imports` (ESLint) or `no-restricted-imports` (ESLint).
- MUST define CSS targeting view-transition pseudo-elements (for example `::view-transition-old(...)` / `::view-transition-new(...)`) only in global stylesheets. Verification mechanism: CI script / file-system check that fails on matches in component-scoped style files.

## Prohibited patterns
(none)

## Allowed deviations
(none)
