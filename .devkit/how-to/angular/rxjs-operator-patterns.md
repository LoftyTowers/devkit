# Rxjs Operator Patterns How To

## Scope
This how-to covers implementing RxJS operator patterns such as switchMap, debounceTime, and shareReplay with correct error handling and subscription safety. It applies to observable pipelines in Angular code.

## Prerequisites

## Steps
- Reactive transformations MUST be implemented using operators chained with pipe().
- switchMap MUST be used for dependent sequential operations where cancellation of previous emissions is required.
- debounceTime SHOULD be used for user input streams to reduce unnecessary API calls.
- shareReplay MUST be used to share results of expensive observables with multiple subscribers.
- catchError MUST be used to handle errors within observable streams.
- switchMap, mergeMap, or concatMap MAY be chosen based on the required behaviour.

## Pitfalls
- Nested subscriptions MUST NOT be used.
- Subscriptions MUST NOT be created inside other subscription callbacks.
- Observable chains MUST NOT omit error handling.
- subscribe MUST NOT be used when declarative operators can achieve the same result.
- Subscriptions created with subscribe() MUST NOT remain uncleared.

## Cross-references
- .devkit/contracts/angular/state-management.contract.md
- .devkit/playbooks/angular/implementing-rxjs-patterns.playbook.md
- .devkit/checklists/angular/state-management-checklist.md