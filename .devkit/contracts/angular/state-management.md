# State management

## Scope

Rules governing state management patterns in Angular applications. Covers NgRx Store, NgRx SignalStore, service-based state, RxJS operator usage, state immutability, and local-vs-global state boundaries.

## Rules

- Actions MUST be created using `createAction` or `createActionGroup`; class-based actions MUST NOT be used.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `prefer-action-creator`.
- Action types MUST follow the `[Source] Event` naming convention (good action hygiene).
    - Verification mechanism: `@ngrx/eslint-plugin` rule `good-action-hygiene`.
- Each action type string MUST be unique across the entire application.
    - Verification mechanism: NgRx runtime check `strictActionTypeUniqueness: true`.
- Reducers MUST be pure functions; they MUST NOT mutate the incoming state or action objects.
    - Verification mechanism: NgRx runtime checks `strictStateImmutability: true` and `strictActionImmutability: true` (enabled by default).
- Reducer `on()` handlers MUST have explicit return types.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `on-function-explicit-return-type`.
- A reducer MUST NOT handle the same action more than once.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `avoid-duplicate-actions-in-reducer`.
- Effects MUST NOT call `store.dispatch()` directly.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `no-dispatch-in-effects`.
- Effects MUST NOT re-emit actions that match their own `ofType` filter (cyclic effects).
    - Verification mechanism: `@ngrx/eslint-plugin` rule `avoid-cyclic-effects` and/or `eslint-plugin-rxjs-x` rule `no-cyclic-action`.
- Effects MUST NOT be listed in `providers` if already registered via `EffectsModule` or `provideEffects`.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `no-effects-in-providers`.
- Effects MUST NOT use unguarded `catchError` that would terminate the effect stream.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `no-unsafe-catch`.
- Effects MUST NOT use `first` or `take(1)` without a preceding filter that prevents premature completion.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `no-unsafe-first`.
- Effects classes MUST implement the corresponding lifecycle interface (e.g., `OnInitEffects`).
    - Verification mechanism: `@ngrx/eslint-plugin` rule `use-effects-lifecycle-interface`.
- Selectors MUST be created using `createSelector` or `createFeatureSelector`; raw string selectors or props drilling in `store.select()` MUST NOT be used.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `prefer-selector-in-select`.
- Selector names MUST be prefixed with `select` (e.g., `selectUsers`).
    - Verification mechanism: `@ngrx/eslint-plugin` rule `prefix-selectors-with-select`.
- `concatLatestFrom` MUST be used instead of `withLatestFrom` in effects to prevent selectors from firing before the action is dispatched.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `prefer-concat-latest-from`.
- Components MUST NOT subscribe to the store imperatively; the `async` pipe or `toSignal` MUST be used instead.
- Only one global `Store` injection MUST exist per component or service.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `no-multiple-global-stores`.
- Reducer key names MUST NOT contain the word "reducer".
    - Verification mechanism: `@ngrx/eslint-plugin` rule `no-reducer-in-key-names`.
- Service class fields of type `WritableSignal<T>` MUST be marked `private readonly`.
    - Verification mechanism: TypeScript compiler — `private readonly` keyword enforced on class fields.
- Custom `signalStoreFeature` functions with static input MUST use a generic type parameter.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `signal-store-feature-should-use-generic-type`.
- `@ngrx/signals` package MUST be present in `package.json` dependencies when SignalStore APIs are imported.
    - Verification mechanism: CI script — verify `package.json` contains `@ngrx/signals` when `signalStore` imports exist.


## Prohibited patterns

- MUST NOT mutate state objects inside reducer `on()` handlers (e.g., `state.items.push()`).
    - Verification mechanism: NgRx runtime check `strictStateImmutability: true`.
- MUST NOT dispatch multiple actions sequentially from a single location.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `avoid-dispatching-multiple-actions-sequentially`.
- MUST NOT place mapping or transformation logic outside selector functions when consuming selectors.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `avoid-mapping-selectors`.
- MUST NOT combine multiple selectors at the component level; combine at the selector level instead.
    - Verification mechanism: `@ngrx/eslint-plugin` rule `avoid-combining-selectors`.


## Allowed deviations

- MAY disable `strictStateSerializability` and `strictActionSerializability` runtime checks if the store intentionally holds non-serializable values (e.g., `Date`, `Map`).
- MAY use `shareReplay({ refCount: false, bufferSize: 1 })` in singleton services where the observable is guaranteed never to complete, acknowledging the memory trade-off.
- MAY use `{ dispatch: false }` on effects that perform side-effects without dispatching a resulting action.
