# Testing strategy

## Checklist

- [ ] Verify every component, service, pipe, directive, and guard has a co-located `.spec.ts` file.
- [ ] Verify `angular.json` `architect.test.builder` is set to `@angular/build:unit-test`.
- [ ] Verify `coverageThresholds` is configured in `angular.json` with numeric values for `statements`, `branches`, `functions`, and `lines`.
- [ ] Verify `@vitest/coverage-v8` is listed in `devDependencies`.
- [ ] Verify `ng test --no-watch --coverage` exits with code 0.
- [ ] Verify no test file imports `HttpClientTestingModule`; confirm `provideHttpClientTesting()` is used instead.
- [ ] Verify no test file imports `RouterTestingModule`; confirm `provideRouter()` with `RouterTestingHarness` is used instead.
- [ ] Verify every test suite using `HttpTestingController` includes `afterEach(() => { TestBed.inject(HttpTestingController).verify(); })`.
- [ ] Verify `provideHttpClient()` appears before `provideHttpClientTesting()` in every test module's providers array.
- [ ] Verify no test file contains `{ provide: Router, useValue: ... }` or `{ provide: Router, useClass: ... }`.
- [ ] Verify `TestBed.configureTestingModule()` is not called after `TestBed.createComponent()` in any spec.
- [ ] Verify CI pipeline includes `ng test --no-watch --no-progress --coverage` as a required gate.
