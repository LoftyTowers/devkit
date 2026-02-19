# Testing strategy

## Procedure: Configure HTTP service testing with HttpTestingController

### When to use

When testing any service or component that depends on `HttpClient` for remote data access.

### Preconditions

- `@angular/common/http` and `@angular/common/http/testing` are installed.
- The service under test injects `HttpClient`.

### Steps

1. Run `TestBed.configureTestingModule({ providers: [provideHttpClient(), provideHttpClientTesting()] })`, ensuring `provideHttpClient()` appears first.
2. Run `const httpTesting = TestBed.inject(HttpTestingController);`.
3. Run the service method that triggers the HTTP request.
4. Run `const req = httpTesting.expectOne('/api/endpoint');` to capture the pending request.
5. Inspect `req.request.method`, headers, and body to assert expected properties.
6. Run `req.flush(mockResponseBody);` to deliver the mock response.
7. Verify the service output with standard test assertions.
8. Add `afterEach(() => { TestBed.inject(HttpTestingController).verify(); });` to confirm no outstanding requests remain.

### Validation

- `ng test` passes with no `HttpTestingController.verify()` failures.
- `expectOne` throws on zero or multiple matches, visible in test output.

---

## Procedure: Configure HTTP error handling tests

### When to use

When testing service behaviour under backend errors (non-2xx status) or network failures.

### Preconditions

- HttpTestingController is configured per the previous procedure.

### Steps

1. Run the service method that makes the HTTP request.
2. Capture the request with `const req = httpTesting.expectOne(...);`.
3. For backend errors, run `req.flush('Error body', { status: 500, statusText: 'Internal Server Error' });`.
4. For network errors, run `req.error(new ProgressEvent('network error'));`.
5. Verify service error-handling behaviour with assertions on returned values or thrown errors.

### Validation

- Tests pass while confirming correct error-handling logic.

---

## Procedure: Test interceptors

### When to use

When verifying that HTTP interceptors correctly modify requests or responses.

### Preconditions

- The interceptor function or class is implemented.

### Steps

1. Run `TestBed.configureTestingModule({ providers: [provideHttpClient(withInterceptors([myInterceptor])), provideHttpClientTesting()] });`.
2. Trigger an HTTP request through a service or directly via `HttpClient`.
3. Capture the request with `const req = httpTesting.expectOne(...);`.
4. Inspect `req.request.headers`, URL, or body to assert interceptor behaviour.

### Validation

- Captured `TestRequest` shows the expected header, body, or URL modifications.

---

## Procedure: Test routed components with RouterTestingHarness

### When to use

When testing components that are targets of Angular Router navigation, including components that read route parameters, query parameters, or are protected by guards.

### Preconditions

- `@angular/router` and `@angular/router/testing` are installed.
- Route configuration is defined for the component under test.

### Steps

1. Run `TestBed.configureTestingModule({ providers: [provideRouter([{ path: 'route/:id', component: MyComponent }])] });`.
2. Run `const harness = await RouterTestingHarness.create();`.
3. Run `const component = await harness.navigateByUrl('/route/42', MyComponent);`.
4. Inspect `harness.routeNativeElement` or the `component` instance to assert expected state.
5. For guard testing, read `TestBed.inject(Router).url` after navigation to assert redirect targets.
6. For query parameter testing, navigate with query string and assert corresponding component properties.

### Validation

- `harness.routeNativeElement?.textContent` includes expected rendered content.
- `TestBed.inject(Router).url` matches the expected URL after navigation.

---

## Procedure: Test reactive form validation

### When to use

When verifying form control/group validity, error states, and validator behaviour without rendering the full component template.

### Preconditions

- The component or standalone form model uses `FormControl`, `FormGroup`, or `FormArray` from `@angular/forms`.

### Steps

1. Run `const control = new FormControl(initialValue, validators);` or create a `FormGroup` instance directly in the test.
2. Run `control.setValue(value)` or `group.patchValue({ ... })` to simulate input.
3. Inspect `control.valid`, `control.invalid`, and `control.errors` to assert expected validation state.
4. For view-to-model tests, create the component with `TestBed.createComponent()`, query the input element, set its value, dispatch an `input` event, and run `await fixture.whenStable()` before reading the control value.
5. For model-to-view tests, set the `FormControl` value with `setValue()` and verify the corresponding DOM input value.

### Validation

- `control.valid` or `control.invalid` matches expectations.
- `control.errors` contains expected keys such as `{ required: true }`.

---

## Procedure: Test async validators on reactive form controls

### When to use

When a form control uses an `AsyncValidatorFn` that returns a `Promise` or `Observable`.

### Preconditions

- The async validator is implemented and the form control is configured with the `asyncValidators` option.

### Steps

1. Run `const control = new FormControl('', { asyncValidators: [myAsyncValidator] });`.
2. Run `control.setValue('test-value');` to trigger the async validator.
3. Immediately inspect `control.status` and verify it is `'PENDING'`.
4. Resolve the async operation (e.g. complete an observable, advance timers via `vi.runAllTimersAsync()` when using fake timers).
5. Inspect `control.status` for `'VALID'` or `'INVALID'` and check `control.errors` for the expected key.

### Validation

- `control.status` transitions from `'PENDING'` to the final state.
- `control.errors` contains the expected async validation error or is `null`.

---

## Procedure: Configure and enforce code coverage thresholds

### When to use

When setting up or updating the project's coverage quality gate.

### Preconditions

- `@vitest/coverage-v8` is installed as a dev dependency.

### Steps

1. Run `npm install -D @vitest/coverage-v8`.
2. Open `angular.json` and locate `projects.<name>.architect.test.options`.
3. Set `"coverage": true`.
4. Add `"coverageThresholds"` with numeric values:  
   `"coverageThresholds": { "statements": 80, "branches": 80, "functions": 80, "lines": 80 }`.
5. Run `ng test --no-watch --coverage` to verify thresholds are enforced.

### Validation

- Command exits with code 0 when thresholds are met.
- Command exits with a non-zero code and threshold-failure message when thresholds are not met.
- A `coverage/` directory is generated containing `index.html`.

---

## Procedure: Configure CI test execution

### When to use

When integrating Angular unit tests into a continuous integration pipeline.

### Preconditions

- `angular.json` test target is configured.

### Steps

1. Add `ng test --no-watch --no-progress` to the CI script.
2. For coverage enforcement, use `ng test --no-watch --no-progress --coverage`.
3. Ensure the CI environment sets `CI=true` where needed.

### Validation

- CI job exits with code 0 on success, non-zero on test failures or threshold violations.
- Console output displays test and coverage results.

---

## Procedure: Set up global test providers

### When to use

When multiple test suites need the same providers (e.g. `provideHttpClient()` + `provideHttpClientTesting()`) globally.

### Preconditions

- Project uses `@angular/build:unit-test` builder.

### Steps

1. Create `src/test-providers.ts` exporting an array of providers including `provideHttpClient()` and `provideHttpClientTesting()`.
2. Add `"providersFile": "src/test-providers.ts"` to `angular.json` under `architect.test.options`.
3. Ensure `src/test-providers.ts` is included in `tsconfig.spec.json`.

### Validation

- `ng test` runs without missing provider errors.
- HTTP tests work without redefining HTTP providers in each spec.
