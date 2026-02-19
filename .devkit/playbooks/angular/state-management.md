# State management

## Context

State management in Angular spans a spectrum from simple component signals to full Redux-pattern stores. The choice of mechanism depends on the scope of shared state, complexity of side effects, and team scale. Angular signals (introduced in v16+) provide a synchronous, granular reactivity primitive that complements or replaces RxJS-based patterns for many use cases.  NgRx Store provides a structured Redux-like approach for large-scale global state with time-travel debugging.  NgRx SignalStore (from `@ngrx/signals`) offers a signal-native, lower-boilerplate alternative for both local and global state.

## Guidance

### NgRx Store architecture

- Structure each feature state consistently: `state.ts` (interface + initial state), `actions.ts`, `reducers.ts`, `effects.ts`, `selectors.ts`.
- Treat actions as unique events, not commands; name them after what happened, not what should happen.
- Keep reducers small and focused; each `on()` handler addresses exactly one state transition.
- Compose selectors from smaller selectors; rely on `createSelector` memoization to avoid redundant recomputation.
- Separate data-fetching services from effects; effects orchestrate, services execute HTTP calls.


### SignalStore patterns

- Use `signalState` for lightweight, component-scoped or service-scoped state with minimal ceremony.
- Use `signalStore` with `withState`, `withComputed`, `withMethods`, and `withHooks` for structured feature-level state.
- Use `patchState` for all state mutations inside `signalStore` methods to enforce immutable updates.
- Extend SignalStore with `signalStoreFeature` for reusable cross-cutting concerns (loading status, pagination, entity management).
- Use `rxMethod` from `@ngrx/signals/rxjs-interop` to bridge RxJS streams into SignalStore methods when stream semantics are needed.


### Service-based state with BehaviorSubject

- Encapsulate a `BehaviorSubject` as `private readonly`; expose only the `.asObservable()` stream publicly.
- Treat the service as the single source of truth for its domain; components read via `async` pipe or `toSignal`, never via direct `.getValue()` in templates.
- Prefer migrating to `signal()` + `asReadonly()` for new service state; keep `BehaviorSubject` only for inherently stream-like data (websockets, polling, router events).
- Expose public state as `readonly` signals via `asReadonly()` when using signal-based service state.


### RxJS operator selection

- Use `switchMap` for search/autocomplete scenarios where only the latest request matters.
- Use `concatMap` when sequential ordering of inner subscriptions is required.
- Use `exhaustMap` for form submission or login where duplicate concurrent requests must be suppressed.
- Pair `debounceTime` with `distinctUntilChanged` on user-input streams to minimise redundant emissions.
- Apply `shareReplay({ refCount: true, bufferSize: 1 })` to share expensive computations across multiple subscribers while allowing cleanup when all subscribers unsubscribe.
- Use `retry` or `retryWhen` with back-off for transient HTTP failures in effects; avoid infinite retry loops. NO PRIMARY SUPPORT — SECONDARY ONLY.


### Signal–RxJS interop

- Use `toSignal()` to convert an Observable into a signal for template consumption; provide `initialValue` or use `requireSync: true` for `BehaviorSubject` sources.
- Use `toObservable()` to feed a signal value into an RxJS pipeline when stream operators (e.g., `switchMap`, `debounceTime`) are needed.
- Prefer `rxResource` / `resource` over `toSignal` wrapping HTTP calls where the resource lifecycle (loading, error, refresh) matters.
- Avoid calling `toSignal()` repeatedly for the same Observable; reuse the returned signal to prevent redundant subscriptions.
- Avoid calling `toSignal()` outside an injection context. If needed, pass an explicit `Injector` option.


### State immutability

- Prefer the spread operator or `structuredClone` for state updates; avoid in-place mutations.

```
- Leverage TypeScript `Readonly<T>` and `ReadonlyArray<T>` at the interface level for compile-time immutability enforcement. NO AUTHORITATIVE SUPPORT FOUND (TypeScript best practice, not Angular-specific).
```

- PREFERENCE — JUSTIFIED: Use custom equality functions on signals holding complex objects to prevent unnecessary re-renders when semantically identical values are produced. Justified by Angular's default `Object.is()` referential check.
- Avoid deep-mutating signal values in service-based state; returning the same object reference from `update()` will not notify consumers.
- Ensure signal `update()` calls return new object references (not the same object) to trigger change detection.
- Avoid in-place mutation in signal `update()` callbacks (e.g., `push`, `splice`, direct property assignment).
- Ensure signal updates return new object references so consumers are notified.


### Local vs global state strategy

- Start with component-level signals for purely local UI state (modal open/closed, form input, local toggle).
- Promote to a service with signals when two or more components in the same feature share the same state.
- Graduate to NgRx Store or SignalStore (provided at root) only when the application requires cross-feature state sharing, complex side-effect orchestration, or time-travel debugging.
- Consider purely local UI state (modal visibility, form scratch values) for component-level signals, not global store.
- Organise shared feature state in a service or feature-scoped SignalStore rather than duplicating across components.
- Justify global store slices by cross-feature consumption or debugging requirements.


## Trade-offs

- NgRx Store adds significant boilerplate (actions, reducers, effects, selectors) but provides strong auditability, time-travel debugging via Redux DevTools, and enforced unidirectional data flow.
- SignalStore reduces boilerplate substantially compared to NgRx Store but lacks built-in Redux DevTools integration and the action-log audit trail.
- Service-based BehaviorSubject state requires manual subscription management and risks memory leaks; signals eliminate this concern but lack stream operators natively.
- `shareReplay({ refCount: false })` caches indefinitely and can cause memory leaks outside singleton services.
- `toSignal()` subscribes immediately and holds the subscription until the injection context is destroyed; this may cause unintended long-lived subscriptions if used carelessly.


## Decision criteria

- Choose NgRx Store when: the application is large-scale, multiple teams contribute, time-travel debugging is required, or strict action audit logging is a compliance requirement.
- Choose NgRx SignalStore when: the team wants structured state management with lower boilerplate, the project uses Angular 17+ signals throughout, and Redux DevTools are not a hard requirement.
- Choose service + signals when: state is shared within a single feature, side effects are straightforward HTTP calls, and no cross-feature state coordination is needed.
- Choose raw component signals when: state is purely local to one component and has no external consumers.


## Preferences

- PREFERENCE — JUSTIFIED: Prefer `signalStore` over new NgRx Store feature slices for greenfield features in Angular 17+ projects. Justified by reduced boilerplate and native signal integration.
- PREFERENCE — JUSTIFIED: Prefer `toSignal` over the `async` pipe for new component code to eliminate subscription lifecycle concerns. Justified by Angular's official RxJS interop documentation.
- PREFERENCE — JUSTIFIED: Prefer `createActionGroup` over individual `createAction` calls to co-locate related actions and reduce file sprawl. Justified by NgRx official API.
