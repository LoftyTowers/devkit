# Testing Standards Contract

## Scope
This contract defines Angular testing standards for unit, component, service, form, and routing tests. It covers TestBed configuration, mocks, HTTP testing, coverage, and validation of routing and forms.

## Rules
- Unit tests MUST test individual units in isolation with mocked dependencies and verify a single behavior per test.
- Angular unit tests MUST use TestBed.configureTestingModule() to configure the required declarations, imports, and providers. TestBed.configureTestingModule()
- Dependencies MUST be replaced with mocks or spies in TestBed providers to isolate the unit under test.
- Jasmine spies MUST be used to mock dependencies and verify interactions. spyOn(service, 'method').and.returnValue(value)
- Unit tests MUST be executed using the ng test CLI command. ng test
- Component tests MUST use ComponentFixture obtained from TestBed.createComponent() to interact with the component. TestBed.createComponent()
- Tests MUST call fixture.detectChanges() after updating component state before making assertions. fixture.detectChanges()
- Tests SHOULD query the DOM using DebugElement for Angular-aware access. fixture.debugElement.query(By.css('button'))
- Component interactions SHOULD be tested by triggering DOM events and verifying resulting behavior. button.triggerEventHandler('click', null)
- Child components SHOULD be replaced with stubs to isolate parent component tests.
- Service tests MUST use HttpClientTestingModule and HttpTestingController for HTTP interactions. HttpClientTestingModule; HttpTestingController
- HTTP requests MUST be verified using HttpTestingController. httpMock.expectOne(url)
- Mock HTTP requests MUST be completed by calling request.flush(). request.flush(mockData)
- Tests MUST verify that no outstanding HTTP requests remain after each test. httpMock.verify()
- Service tests MUST verify error handling by simulating HTTP error responses. request.flush(errorMsg, { status: 404, statusText: 'Not Found' })
- Non-HTTP service dependencies MUST be mocked in TestBed providers.
- Test suites MUST generate coverage reports using ng test --code-coverage. ng test --code-coverage
- Coverage reports SHOULD be reviewed using the browser-friendly HTML output. coverage/index.html
- Coverage thresholds MAY be configured in angular.json. angular.json
- Coverage reporting SHOULD NOT include generated files.
- Projects MAY choose their own target coverage percentages.
- Reactive forms tests MUST verify form validity and error states.
- Form submission behavior MUST be tested by invoking submit handlers and verifying service interactions.
- Custom validators MUST be tested in isolation. FormControl
- Dependencies of asynchronous validators MUST be mocked.
- Asynchronous validator tests MUST use fakeAsync() and tick(). fakeAsync(); tick()
- Modern router tests MUST use RouterTestingHarness. RouterTestingHarness.create()
- Route guards MUST be tested using RouterTestingHarness.
- Tests MUST verify that route parameters are passed correctly.
- Lazy-loaded routes MUST be tested using RouterTestingHarness. loadComponent; loadChildren

## Prohibited patterns
- Unit tests MUST NOT test multiple units together using real services or child components.
- Tests MUST NOT leave observable subscriptions without cleanup.
- Tests MUST NOT depend on execution order or shared state from other tests.
- Tests SHOULD NOT verify internal implementation details instead of observable behavior.
- Tests MUST NOT make DOM assertions without calling fixture.detectChanges().
- Tests MUST NOT unintentionally include real child components.
- Tests SHOULD NOT directly manipulate component instances in ways that bypass the Angular lifecycle.
- Tests SHOULD NOT over-rely on NO_ERRORS_SCHEMA.
- Tests MUST NOT make real HTTP network requests.
- Tests MUST NOT leave HTTP requests unflushed.
- Tests MUST NOT omit verification of outstanding HTTP requests.
- Service tests MUST NOT use real dependencies.
- Test efforts SHOULD NOT focus solely on achieving one hundred percent coverage without regard to quality.
- Tests MUST NOT assert form validity before asynchronous validators complete.
- Tests MUST NOT validate forms without triggering change detection.
- Tests MUST NOT omit coverage of cross-field validation logic.
- New router tests MUST NOT use RouterTestingModule.
- Tests MUST NOT omit coverage of route guards.
- Routing tests SHOULD NOT test routing in isolation without integration coverage.

## Allowed deviations
- NO_ERRORS_SCHEMA MAY be used to ignore unknown elements and attributes when isolating component tests. NO_ERRORS_SCHEMA
- Component tests MAY be written as deep or shallow tests depending on the testing intent.
- Coverage thresholds MAY be configured in angular.json. angular.json
- Projects MAY choose their own target coverage percentages.

## Cross-references