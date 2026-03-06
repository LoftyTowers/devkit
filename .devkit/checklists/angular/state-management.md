# State management

## Checklist

### NgRx Store

- [ ] Verify `strictStateImmutability` and `strictActionImmutability` are `true` in the store runtime checks configuration.
- [ ] Verify `strictActionTypeUniqueness` is `true` in the store runtime checks configuration.
- [ ] Verify `@ngrx/eslint-plugin` is installed and the `store`, `effects`, and `signals` configs are extended in `eslint.config.js`.
- [ ] Verify `npx eslint .` passes with zero errors related to `@ngrx/eslint-plugin` rules.
- [ ] Verify all actions are created via `createAction` or `createActionGroup` (no class-based actions exist).
- [ ] Verify all action type strings follow the `[Source] Event` naming pattern.
- [ ] Verify every reducer `on()` handler returns a new state object (no in-place mutation).
- [ ] Verify every reducer `on()` handler has an explicit return type annotation.
- [ ] Verify no effect re-emits an action matching its own `ofType` filter.
- [ ] Verify all effects use `concatLatestFrom` instead of `withLatestFrom`.
- [ ] Verify all selector names are prefixed with `select`.
- [ ] Verify all selectors are created via `createSelector` or `createFeatureSelector`.
- [ ] Verify components consume store data via `async` pipe or `toSignal`, not via imperative `.subscribe()`.
- [ ] Verify reducer key names do not contain the word "reducer".
- [ ] Verify only one global `Store` injection exists per component or service.
- [ ] Verify effects are not listed in `providers` if already registered via `EffectsModule` or `provideEffects`.
- [ ] Verify effects do not use unguarded `catchError` that would terminate the effect stream.
- [ ] Verify effects do not use `first` or `take(1)` without a preceding filter.
- [ ] Verify effects classes implement the corresponding lifecycle interface.
- [ ] Verify no mapping or transformation logic exists outside selector functions.
- [ ] Verify selectors are not combined at the component level.
- [ ] Verify reducers do not handle the same action more than once.
- [ ] Verify effects do not call `store.dispatch()` directly.
- [ ] Verify no multiple actions are dispatched sequentially from a single location.


### NgRx SignalStore

- [ ] Verify `@ngrx/signals` is listed in `package.json` dependencies.
- [ ] Verify all state mutations use `patchState`; no direct property assignment on store state.
- [ ] Verify custom `signalStoreFeature` functions use a generic type parameter when accepting static input.


### Service-based state

- [ ] Verify service-held writable signals are declared `private readonly`.
- [ ] Verify service-held `BehaviorSubject` instances are `private readonly` with a public `.asObservable()` accessor.


### State immutability

- [ ] Verify NgRx runtime checks throw on state mutation during development (`ng serve`).

<div align="center">⁂</div>
