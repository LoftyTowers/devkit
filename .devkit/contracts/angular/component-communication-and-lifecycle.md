# Component communication and lifecycle

## Scope
This contract governs how components and directives declare inputs, outputs, and two-way bindings.  
This contract governs how components and directives declare and consume view/content queries.  
This contract governs lifecycle hook declarations and destruction-time cleanup for subscriptions and callbacks.

## Rules
- Components and directives MUST declare inputs using the signal-based `input()` or `model()` APIs.  
  - Verification mechanism: ESLint rule (custom) banning `@Input` usage outside an allowlist.
- Components and directives MUST declare outputs using `output()` or `outputFromObservable()`.  
  - Verification mechanism: ESLint rule (custom) banning `@Output` + `EventEmitter` usage outside an allowlist.
- Components and directives MUST declare view/content queries using `viewChild`/`viewChildren`/`contentChild`/`contentChildren`.  
  - Verification mechanism: ESLint rule (custom) banning `@ViewChild`/`@ViewChildren`/`@ContentChild`/`@ContentChildren` outside an allowlist.
- Class fields initialised by `input`, `model`, `output`, and query functions MUST be marked `readonly`.  
  - Verification mechanism: ESLint rule (custom) requiring `readonly` on those member declarations.
- Classes that declare lifecycle hook methods MUST implement the corresponding lifecycle hook interfaces.  
  - Verification mechanism: ESLint rule (custom) that enforces `implements OnInit/OnDestroy/AfterViewInit/...` when `ngOnInit/ngOnDestroy/ngAfterViewInit/...` methods exist.
- RxJS pipelines that are subscribed to in components and directives MUST include `takeUntilDestroyed()`.  
  - Verification mechanism: ESLint rule (custom) requiring `takeUntilDestroyed` in any observable chain that ends with `.subscribe()` inside components/directives.
- Output names MUST be camelCase and MUST NOT start with `on`.  
  - Verification mechanism: ESLint naming rule (custom) applied to `output()` members and `@Output()` members.

## Prohibited patterns
- Templates MUST NOT rely on Angular component outputs bubbling through the DOM.  
  - Verification mechanism: ESLint rule (custom) banning patterns that assume bubbling (project-specific allowlist for known-safe wrappers).
- Component inputs MUST NOT be aliased via `alias` unless the alias exists to preserve backwards compatibility or to avoid collisions with native DOM properties.  
  - Verification mechanism: ESLint rule (custom) banning `input(..., { alias: ... })` and `@Input({ alias: ... })` unless allowlisted.
- Component outputs MUST NOT be aliased via `alias` unless the alias exists to preserve backwards compatibility or to avoid collisions with native DOM events.  
  - Verification mechanism: ESLint rule (custom) banning `output({ alias: ... })` and `@Output('...')` unless allowlisted.
- Output names MUST NOT collide with standard DOM element event names.  
  - Verification mechanism: ESLint rule (custom) that checks declared output names against a DOM event name list.

## Allowed deviations
- Components and directives MAY declare inputs using the decorator-based `@Input` API when the codebase is not migrated.
- Components and directives MAY declare outputs using the decorator-based `@Output` + `EventEmitter` API when the codebase is not migrated.
- Components and directives MAY declare queries using decorator-based query APIs (`@ViewChild`, `@ContentChild`, etc.) when the codebase is not migrated.
- Components and directives MAY use input/output aliasing to preserve backwards compatibility during renames or to avoid collisions.
