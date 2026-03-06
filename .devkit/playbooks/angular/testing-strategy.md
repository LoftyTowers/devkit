# Testing strategy

## Context

Angular testing spans unit tests (services, pipes, pure logic), component tests (TestBed + DOM), HTTP integration tests (HttpTestingController), route tests (RouterTestingHarness), reactive-form tests (FormControl/FormGroup validation), and E2E tests (Cypress/Playwright). The default framework for new Angular CLI projects is Vitest running in a jsdom environment, replacing Karma/Jasmine.

Test architecture decisions affect feedback-loop speed, CI reliability, and the ability to refactor safely. The guidance below addresses judgement calls that cannot be mechanically enforced but significantly influence test quality.

## Guidance

- Prefer testing services without `TestBed` when the service has no Angular DI dependencies; instantiate the class directly for faster, simpler tests.
- Prefer `TestBed.inject()` over `fixture.debugElement.injector.get()` for retrieving services unless the service is provided at the component level via `providers: [...]`.
- Prefer stub classes (`useClass`) or spy objects (`useValue`) over deep mocks for service dependencies; this keeps tests closer to real behaviour while remaining isolated.
- Use `TestBed.overrideComponent()` to replace component-level providers when `TestBed.configureTestingModule()` cannot reach the child injector.
- Prefer the test-host component pattern or `fixture.componentRef.setInput()` to exercise input/output bindings rather than accessing internal component state directly.
- Use the Page Object pattern to encapsulate DOM queries for complex component templates; this reduces duplication and makes tests resilient to template restructuring.
- Prefer `RouterTestingHarness` over creating custom test-host components for route testing; it provides built-in navigation, type-safe component access, and eliminates boilerplate.
- Prefer real route configurations with `provideRouter()` over mocked Router services; this catches real routing issues and avoids brittleness from internal API changes.
- Prefer mocking HTTP responses at the `HttpTestingController` level rather than stubbing the service layer; this validates the full HTTP pipeline including interceptors.
- Prefer testing reactive forms at the model level (set values, check validity/errors) rather than through DOM interactions when validating pure form logic. Reactive forms provide synchronous access that does not require rendering the UI.
- Use `updateOn: 'blur'` on form controls with async validators to reduce unnecessary validation calls during rapid user input.
- Avoid overuse of `NO_ERRORS_SCHEMA`; it suppresses compiler errors for misspelled selectors and missing attributes, masking real defects. Combine it sparingly with targeted stub components.
- Prefer calling `TestBed.compileComponents()` when testing components containing `@defer` blocks to ensure asynchronous template compilation is resolved correctly.
- Avoid using `fakeAsync` with the Vitest runner; prefer native Vitest fake timers (`vi.useFakeTimers`) for timer control.
- When defining async validators on reactive form controls, pass them via the `asyncValidators` option rather than mixing them into synchronous validators.
- Avoid relying on `fixture.detectChanges()` as the sole change-detection trigger in new tests; prefer `await fixture.whenStable()` where appropriate.
- Legacy projects may continue using Karma during incremental migration, provided coverage thresholds remain enforced.

## Trade-offs

- Shallow vs deep component tests: Shallow tests (stubs/`NO_ERRORS_SCHEMA`) run faster and isolate the component, but miss integration defects between parent and child components. Deep tests catch wiring errors but require more setup and are slower.
- HttpTestingController vs service stubs: HTTP-level mocking validates interceptors and the full request pipeline, but couples tests to URL structures and request shapes. Service-level stubs are simpler but skip the HTTP layer.
- E2E tool choice — Cypress vs Playwright: Cypress offers a rich interactive test runner and time-travel debugging, well-suited for developer-local feedback. Playwright supports multiple browser engines (Chromium, Firefox, WebKit) and has native parallelism, well-suited for comprehensive CI coverage.
- Coverage thresholds: High mandatory thresholds (e.g. 90%+) incentivise meaningful test writing but can lead to low-value tests written solely to satisfy the gate. Balance thresholds with code-review scrutiny of test quality.

## Decision criteria

- When to choose option A: Choose unit tests without TestBed for pure services, utilities, pipes, and validators with no DI.
- When to choose option B: Choose TestBed component tests when template rendering, DOM interaction, or DI wiring needs verification.
- When to choose option A: Choose HttpTestingController for any service that depends on `HttpClient`, including interceptor verification.
- When to choose option B: Choose RouterTestingHarness for testing routed components, route parameters, guards, resolvers, and query parameters.
- When to choose option A: Choose Cypress for developer-focused E2E feedback loops and projects that benefit from visual debugging.
- When to choose option B: Choose Playwright for CI-oriented E2E suites requiring cross-browser coverage.
- When to choose option A: Choose reactive-form model-level tests when validating form state, validators, and data flow without DOM concerns.
- When to choose option B: Choose DOM-level form tests when validating two-way binding, template rendering of errors, and user interaction flows.

## Preferences

- PREFERENCE — JUSTIFIED: Organise spec files co-located with the file under test rather than in a separate `tests/` directory. Angular CLI generates specs this way by default, and co-location simplifies discovery and maintenance.
- PREFERENCE — JUSTIFIED: Set coverage thresholds at a minimum of 80% for `statements`, `branches`, `functions`, and `lines` as a baseline quality gate. The angular.dev docs use 80% as the canonical example threshold.
- PREFERENCE — JUSTIFIED: Use Vitest fake timers (`vi.useFakeTimers`) over Zone.js-based async helpers in all new test code, because `fakeAsync` is incompatible with the Vitest runner and Angular recommends zoneless testing with framework-native timers.
