# Component communication and lifecycle

## Context
Component communication is the set of rules for how data enters a component and how events leave it. Angular supports this via inputs (data in), outputs (events out), and explicit two-way bindings for values that a child component updates as part of its UI behaviour.

Lifecycle and queries define *when* component code can safely read input values, access projected content, access the component's own view children, and run teardown. Angular provides lifecycle hooks and `DestroyRef` to align work with creation and destruction.

Service-based communication covers shared state and cross-cutting event dispatch that is not owned by a single component instance. Angular's dependency injection system exists to share services (including state and event handling) across components.

## Guidance
- Organise parent-to-child data flow through inputs and child-to-parent notifications through outputs.
- Prefer `model()` for values that a child component is expected to update and keep in sync with a parent via `[(...)]` bindings.
- Avoid pushing state into child components via queries; treat queries as a way to *reference* children (components, directives, DOM nodes), not as a state synchronisation channel.
- Avoid writing state into parent or ancestor components from a child; keep a single source of truth for shared state.
- Use services for state shared across multiple components or pages, and for event handling/dispatch that is not tied to a specific component instance.
- Prefer root-provided services (`providedIn: 'root'`) when consumers need one shared instance across the app, and prefer component-level providers when consumers need isolated instances.
- Use query functions (`viewChild`, `contentChild`, etc.) and treat query results as potentially `undefined` unless you use `.required(...)`.
- For decorator-based queries, access view query results in `ngAfterViewInit` and content query results in `ngAfterContentInit`, and use `{ static: true }` only when the target is always present and you need results earlier.
- Keep lifecycle hooks small and named for the work they do (push complex logic into well-named methods), and implement lifecycle hook interfaces to catch hook name mistakes.
- Prefer `DestroyRef.onDestroy(...)` when you want to keep setup and teardown close together, and prefer `takeUntilDestroyed()` for cleanup of RxJS subscriptions.
- Prefer `AsyncPipe` for template consumption of `Observable`/`Promise` values to get automatic unsubscription on destroy and on source replacement.
- Prefer `toSignal(...)` to consume RxJS streams inside signal-based component logic, and avoid calling it repeatedly for the same stream.
- Choose output names that are camelCase, avoid `on` prefixes, and avoid collisions with DOM events; remember that Angular custom events do not bubble.

## Trade-offs
- Inputs/outputs keep component APIs explicit and type-checked at build time (including required input enforcement), but require more template wiring as the number of components and bindings grows.
- `model()`-based two-way binding reduces boilerplate for "editable value" components, but creates a bidirectional update path that needs strict ownership and a single source of truth.
- Singleton services make it easy to share state and dispatch events across many components, but also share lifetimes and state across all consumers; isolate via component-level providers when that sharing is not desired.
- Queries enable imperative integration with child instances and DOM references, but writing state across component boundaries via queries produces brittle coupling and can trigger change detection errors such as `ExpressionChangedAfterItHasBeenChecked`.
- Manual subscriptions with `takeUntilDestroyed` support imperative side effects, but require you to stay inside an injection context or pass `DestroyRef` explicitly; template binding with `AsyncPipe` avoids most of this work automatically.

## Decision criteria
- Choose inputs/outputs when the relationship is parent/child and you need a clear, local API boundary in templates.
- Choose `model()` and `[(...)]` when the child component's core job is to modify a value (for example, a custom control) and the parent needs that value synchronised.
- Choose a service when state or events must be shared across siblings, distant parts of the tree, or multiple routes/pages.
- Choose queries when you need a reference to a child component/directive/`ElementRef` for imperative operations, and treat the query result as optional unless enforced with `.required(...)`.
- Choose `DestroyRef` callbacks when teardown is tightly coupled to setup code, and choose `takeUntilDestroyed` when teardown is tied to RxJS subscriptions.

## Preferences
- PREFERENCE — JUSTIFIED: Prefer the function-based APIs (`input`, `output`, query functions, and `model`) over decorator-based APIs in new code.
- PREFERENCE — JUSTIFIED: Prefer `DestroyRef.onDestroy(...)` over a single large `ngOnDestroy` method when teardown needs to stay next to setup code.
- PREFERENCE — JUSTIFIED: Prefer `outputFromObservable` / `outputToObservable` when integrating outputs with RxJS, instead of treating outputs as general-purpose RxJS streams.
