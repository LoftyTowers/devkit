# Reactive State With Signals How To

## Scope
This how-to covers implementing signal-based reactive state and derived state in Angular. It includes use of effects for side effects and immutable update patterns.

## Prerequisites

## Steps
- Synchronous reactive state MUST be created using signals.
- Derived state MUST be implemented using computed signals.
- Effects MUST be used only for side effects triggered by signal changes.
- Signals MUST be read in templates to enable automatic change detection.
- Signals SHOULD be combined with OnPush change detection.
- Immutable update patterns MUST be used with OnPush change detection.
- Signals SHOULD be used to enforce immutable state management.
- Readonly types SHOULD be used for immutable structures.
- Immutability MAY be balanced against performance for very large objects.

## Pitfalls
- Signal values MUST NOT be mutated directly.
- Input properties MUST NOT be mutated.
- Objects used with OnPush change detection MUST NOT be mutated.
- Array and object inputs MUST NOT be mutated.
- Mutable state MUST NOT be shared between components.

## Cross-references
- .devkit/contracts/angular/state-management.contract.md
- .devkit/playbooks/angular/change-detection-reactivity.md
- .devkit/playbooks/angular/migrating-to-signals.playbook.md
- .devkit/checklists/angular/state-management-checklist.md