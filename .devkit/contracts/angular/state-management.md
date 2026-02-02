# State Management Contract

## Scope
This contract covers signal-based state, service-based shared state, RxJS operator patterns, and immutability requirements in Angular. It also defines state scoping and component communication rules for state management.

## Rules
- Services MUST expose observables rather than subjects.
- State services MUST be provided at an appropriate injector scope.
- Subscriptions to state service observables MUST NOT remain active beyond the component lifecycle.
- BehaviorSubject MAY be used for shared state in services as a legacy pattern.
- Signals MAY be preferred over BehaviorSubject for state management.
- Synchronous reactive state MUST be created using signals.
- Derived state MUST be implemented using computed signals.
- Effects MUST be used only for side effects triggered by signal changes.
- Effects MUST NOT be used for state orchestration.
- Observables MUST be converted to signals using toSignal() when signal-based state is required.
- Signals MAY be converted to observables using toObservable() when required.
- Reactive transformations MUST be implemented using operators chained with pipe().
- switchMap MUST be used for dependent sequential operations where cancellation of previous emissions is required.
- debounceTime SHOULD be used for user input streams to reduce unnecessary API calls.
- shareReplay MUST be used to share results of expensive observables with multiple subscribers.
- catchError MUST be used to handle errors within observable streams.
- switchMap, mergeMap, or concatMap MAY be chosen based on the required behaviour.
- Immutable update patterns MUST be used with OnPush change detection.
- Signals SHOULD be combined with OnPush change detection.
- Signals MUST be read in templates to enable automatic change detection.
- Signals SHOULD be used to enforce immutable state management.
- Readonly types SHOULD be used for immutable structures.
- Component-local state MUST be stored in component fields.
- Shared state across components MUST be managed using services.
- State SHOULD be passed via inputs for simple parent-child relationships.
- Outputs MUST be used for child-to-parent communication.
- State services MUST be scoped to the appropriate injector level.
- Either service-based state sharing or input and output bindings MAY be used.

## Prohibited patterns
- BehaviorSubject instances MUST NOT be exposed directly from services.
- Multiple instances of state services MUST NOT be created when shared state is required.
- Signal values MUST NOT be mutated directly.
- Signals with effects or computed logic MUST NOT be created outside an injection context.
- toSignal() MUST NOT be used without configuring appropriate cleanup behaviour.
- Nested subscriptions MUST NOT be used.
- Subscriptions MUST NOT be created inside other subscription callbacks.
- Observable chains MUST NOT omit error handling.
- subscribe MUST NOT be used when declarative operators can achieve the same result.
- Subscriptions created with subscribe() MUST NOT remain uncleared.
- Input properties MUST NOT be mutated.
- Objects used with OnPush change detection MUST NOT be mutated.
- Array and object inputs MUST NOT be mutated.
- Mutable state MUST NOT be shared between components.
- Global services MUST NOT be used for component-local state.
- Deeply nested prop drilling SHOULD NOT be used.
- State services MUST NOT be scoped inappropriately.

## Allowed deviations
- Observables MAY be used instead of signals for asynchronous or time-based streams.
- Immutability MAY be balanced against performance for very large objects.

## Cross-references
- .devkit/playbooks/angular/change-detection-reactivity.md
- .devkit/playbooks/angular/component-di-architecture.md
- .devkit/playbooks/angular/migrating-to-signals.playbook.md
- .devkit/playbooks/angular/implementing-rxjs-patterns.playbook.md
- .devkit/how-to/angular/reactive-state-with-signals.how-to.md
- .devkit/how-to/angular/rxjs-operator-patterns.how-to.md
- .devkit/checklists/angular/state-management-checklist.md