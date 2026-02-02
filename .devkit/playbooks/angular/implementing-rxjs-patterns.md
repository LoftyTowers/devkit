# Implementing Rxjs Patterns Playbook

## Scope
This playbook covers implementing common RxJS operator patterns in Angular using declarative operator chains, error handling, and safe subscription management. It applies to observable transformations and multi-subscriber sharing.

## Core guidance

## Rules & patterns
- Reactive transformations MUST be implemented using operators chained with pipe().
- switchMap MUST be used for dependent sequential operations where cancellation of previous emissions is required.
- debounceTime SHOULD be used for user input streams to reduce unnecessary API calls.
- shareReplay MUST be used to share results of expensive observables with multiple subscribers.
- catchError MUST be used to handle errors within observable streams.
- switchMap, mergeMap, or concatMap MAY be chosen based on the required behaviour.

## Anti-patterns
- Nested subscriptions MUST NOT be used.
- Subscriptions MUST NOT be created inside other subscription callbacks.
- Observable chains MUST NOT omit error handling.
- subscribe MUST NOT be used when declarative operators can achieve the same result.
- Subscriptions created with subscribe() MUST NOT remain uncleared.

## Allowed deviations

## Examples

## Cross-references
- .devkit/contracts/angular/state-management.contract.md
- .devkit/checklists/angular/state-management-checklist.md
- .devkit/how-to/angular/rxjs-operator-patterns.how-to.md