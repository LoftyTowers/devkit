# Directives pipes animations

## Checklist
- [ ] Verify ESLint is configured to enforce directive selectors via `@angular-eslint/directive-selector` with `type: "attribute"` and the approved prefix/style.
- [ ] Confirm `ng lint` reports zero violations for directive selectors in `@Directive({ selector: ... })` declarations.
- [ ] Verify ESLint is configured to enforce host bindings via `@angular-eslint/prefer-host-metadata-property`.
- [ ] Ensure no `@HostBinding` or `@HostListener` decorators exist in directive code paths (lint clean).
- [ ] Confirm no template contains more than one shorthand structural directive (`*`) on a single element.
- [ ] Verify ESLint is configured to enforce `@angular-eslint/use-pipe-transform-interface` for custom pipes.
- [ ] Ensure no custom pipe class is missing `implements PipeTransform` (lint clean).
- [ ] Verify ESLint is configured to fail on impure pipes via `@angular-eslint/no-pipe-impure`.
- [ ] Confirm the codebase has zero occurrences of `@Pipe({ pure: false })` (lint clean).
- [ ] Verify ESLint is configured to enforce a pipe prefix via `@angular-eslint/pipe-prefix` and the configured prefix list.
- [ ] Ensure ESLint is configured to block `@angular/animations` imports via `@typescript-eslint/no-restricted-imports` (or equivalent), and `ng lint` is clean.
- [ ] Confirm CI fails if any component-scoped stylesheet contains `::view-transition-*` selectors, and passes when they exist only in global stylesheets. 
