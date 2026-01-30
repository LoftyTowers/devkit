# State Management Checklist

## Scope
This checklist verifies state management patterns for Angular components and services, including signals, BehaviorSubject legacy state, RxJS operators, immutability, and scoping or communication choices. It applies to shared and component-local state implementations.

## Triggers

## Checklist
- Component-local state MUST be stored in component fields.
- Global services MUST NOT be used for component-local state.
- Synchronous reactive state MUST be created using signals.
- State services MUST be provided at an appropriate injector scope.
- Signals MAY be preferred over BehaviorSubject for state management.
- BehaviorSubject MAY be used for shared state in services as a legacy pattern.
- BehaviorSubject instances MUST NOT be exposed directly from services.
- Multiple instances of state services MUST NOT be created when shared state is required.
- Objects used with OnPush change detection MUST NOT be mutated.
- Input properties MUST NOT be mutated.
- Mutable state MUST NOT be shared between components.
- Outputs MUST be used for child-to-parent communication.
- Subscriptions created with subscribe() MUST NOT remain uncleared.
- catchError MUST be used to handle errors within observable streams.
- Nested subscriptions MUST NOT be used.
- Subscriptions MUST NOT be created inside other subscription callbacks.
- switchMap MUST be used for dependent sequential operations where cancellation of previous emissions is required.
- debounceTime SHOULD be used for user input streams to reduce unnecessary API calls.
- shareReplay MUST be used to share results of expensive observables with multiple subscribers.
- Reactive transformations MUST be implemented using operators chained with pipe().

## Cross-references
- .devkit/contracts/angular/state-management.contract.md
- .devkit/playbooks/angular/change-detection-reactivity.md
- .devkit/playbooks/angular/component-di-architecture.md
- .devkit/playbooks/angular/migrating-to-signals.playbook.md
- .devkit/playbooks/angular/implementing-rxjs-patterns.playbook.md
- .devkit/how-to/angular/reactive-state-with-signals.how-to.md
- .devkit/how-to/angular/rxjs-operator-patterns.how-to.md