# Migrating To Signals Playbook

## Scope
This playbook covers migrating service-based shared state from BehaviorSubject to signal-based state in Angular. It includes immutability expectations and interoperability with observables.

## Core guidance

## Rules & patterns
- BehaviorSubject MAY be used for shared state in services as a legacy pattern.
- Signals MAY be preferred over BehaviorSubject for state management.
- Observables MUST be converted to signals using toSignal() when signal-based state is required.
- Synchronous reactive state MUST be created using signals.
- Derived state MUST be implemented using computed signals.
- Immutable update patterns MUST be used with OnPush change detection.
- Signals SHOULD be used to enforce immutable state management.
- Readonly types SHOULD be used for immutable structures.
- Immutability MAY be balanced against performance for very large objects.

## Anti-patterns
- toSignal() MUST NOT be used without configuring appropriate cleanup behaviour.
- Signal values MUST NOT be mutated directly.
- Input properties MUST NOT be mutated.
- Objects used with OnPush change detection MUST NOT be mutated.
- Array and object inputs MUST NOT be mutated.
- Mutable state MUST NOT be shared between components.

## Allowed deviations
- Observables MAY be used instead of signals for asynchronous or time-based streams.

## Examples

## Cross-references
- .devkit/contracts/angular/state-management.contract.md
- .devkit/checklists/angular/state-management-checklist.md
- .devkit/how-to/angular/reactive-state-with-signals.how-to.md