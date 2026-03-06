# State management

## Procedure: Enable NgRx runtime checks

### When to use

When initialising NgRx Store in an application to enforce immutability and serialisability invariants at development time.

### Preconditions

- `@ngrx/store` is installed.
- Store is initialised via `provideStore()` or `StoreModule.forRoot()`.


### Steps

1. Open the root store configuration (e.g., `app.config.ts` or `app.module.ts`).
2. Add or update the `runtimeChecks` property inside the store configuration:

```typescript
provideStore(reducers, {
  runtimeChecks: {
    strictStateImmutability: true,
    strictActionImmutability: true,
    strictStateSerializability: true,
    strictActionSerializability: true,
    strictActionWithinNgZone: true,
    strictActionTypeUniqueness: true,
  },
})
```

3. Run `ng serve` and exercise the application; observe any runtime errors in the browser console indicating violations.
4. Disable `strictStateSerializability` or `strictActionSerializability` only if the store intentionally holds non-serialisable values; document the deviation.

### Validation

- Mutating state inside a reducer throws a runtime error in the browser console.
- Dispatching an action with a duplicate type string throws a runtime error.

## Procedure: Install and configure @ngrx/eslint-plugin

### When to use

When adding NgRx linting rules to an Angular project to enforce store, effects, and signals best practices.

### Preconditions

- Angular CLI project with ESLint configured (e.g., via `ng add angular-eslint`).
- `@ngrx/store` or `@ngrx/signals` is installed.


### Steps

1. Run `ng add @ngrx/eslint-plugin@latest`.
2. Verify `@ngrx/eslint-plugin` appears in `devDependencies` in `package.json`.
3. Open `eslint.config.js` (flat config) and extend the NgRx recommended config:

```javascript
import ngrx from '@ngrx/eslint-plugin';
// Add to your config array:
...ngrx.configs.store,
...ngrx.configs.effects,
...ngrx.configs.signals,
```

4. Run `npx eslint .` and resolve any reported violations.

### Validation

- `npx eslint .` exits with code 0 (no errors).
- Introducing a deliberate violation (e.g., using `withLatestFrom` in an effect) triggers the `prefer-concat-latest-from` warning.

## Procedure: Create a signal-based service store

### When to use

When shared feature state is needed across multiple components without a full NgRx Store setup.

### Preconditions

- Angular 17+ project.
- Feature components can inject a shared service.


### Steps

1. Create an injectable service:

```typescript
@Injectable({ providedIn: 'root' })
export class FeatureStore {
  private readonly _items = signal<Item[]>([]);
  readonly items = this._items.asreadonly();
  readonly count = computed(() => this._items().length);

  add(item: Item): void {
    this._items.update(prev => [...prev, item]);
  }
}
```



2. Inject the service in consuming components via `inject(FeatureStore)`.
3. Read state in templates directly: `{{ store.items() }}` or `{{ store.count() }}`.

### Validation

- Attempting `store.items.set([])` from a component produces a TypeScript compilation error (no `set` on `Signal<T>`).
- Updating via `store.add(item)` reflects immediately in all consuming component templates.

## Procedure: Create an NgRx SignalStore

### When to use

When structured signal-based state management with computed properties and methods is needed for a feature or globally.

### Preconditions

- `@ngrx/signals` is installed (`npm i @ngrx/signals`).


### Steps

1. Define the store:

```typescript
export const FeatureStore = signalStore(
  { providedIn: 'root' },  // or omit for component-level
  withState<FeatureState>({ items: [], loading: false }),
  withComputed(({ items }) => ({
    count: computed(() => items().length),
  })),
  withMethods((store, api = inject(ApiService)) => ({
    load: rxMethod<void>(
      pipe(
        switchMap(() => api.getItems()),
        tap(items => patchState(store, { items, loading: false })),
      )
    ),
  })),
);
```



2. Provide the store at the component level (if not `providedIn: 'root'`): `providers: [FeatureStore]`.
3. Inject and use: `const store = inject(FeatureStore); store.load();`

### Validation

- `store.items()` returns the current items array as a read-only signal.
- `store.count()` recomputes only when `items` changes (memoised by `computed`).
- `patchState` enforces immutable updates; direct mutation of state properties is not possible through the public API.

## Procedure: Bridge signals and RxJS with toSignal / toObservable

### When to use

When integrating existing Observable-based APIs (HTTP, router, forms) with signal-based components, or when feeding signal values into RxJS pipelines.

### Preconditions

- Angular 17+ project.
- `@angular/core/rxjs-interop` available.


### Steps

1. Convert Observable to signal:

```typescript
results = toSignal(this.http.get<Result[]>('/api/results'), { initialValue: [] });
```



2. Convert signal to Observable:

```typescript
query$ = toObservable(this.querySignal);
results$ = this.query$.pipe(
  debounceTime(300),
  distinctUntilChanged(),
  switchMap(q => this.http.get('/search?q=' + q))
);
```


3. For BehaviorSubject sources, use `requireSync: true` to avoid `undefined` initial value:

```typescript
value = toSignal(this.subject$, { requireSync: true });
```



### Validation

- `results()` in a template renders the HTTP response data without an `async` 
- Updating the signal used in `toObservable` triggers the downstr
- Multiple rapid signal updates emit only the final stabilised value throu
