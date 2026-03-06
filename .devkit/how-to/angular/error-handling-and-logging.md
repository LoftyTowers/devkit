# Error handling and logging

## Procedure: Add a global error handler that reports to the logger

### When to use
Use when you need consistent capture of unhandled runtime errors and a single reporting path to logs/monitoring.

### Preconditions
- Have an existing `LoggerService` (or create one first) that exposes methods like `error(eventName, payload, err)`.

### Steps
1. Create a class (for example `GlobalErrorHandler`) that implements Angular's global error handler contract and injects `Injector` (or injects `LoggerService` directly if it does not create cyclic dependencies).
2. Implement the handler method to normalise unknown inputs into an `Error` instance and to pass the original error object to `LoggerService`.
3. Register the class as the application's error handler provider in the bootstrap configuration (`providers`), replacing the default handler.
4. Add a minimal unit test that triggers the handler with a thrown error and asserts the logger receives an event with the `Error` instance.
5. Run the application and intentionally throw an error from a click handler to confirm the event is captured by the logger.

### Validation
- `ng test` passes and the unit test asserts that `LoggerService.error(...)` is called for an unhandled exception.
- A manual fault injection (throwing an error in the UI) produces exactly one structured log event from the global handler.

## Procedure: Add an HTTP error interceptor that classifies errors

### When to use
Use when you want consistent HTTP error classification and consistent logging on failed HTTP calls.

### Preconditions
- All API calls use Angular `HttpClient`.
- The project has a stable domain error model (or you decide one for HTTP failures).

### Steps
1. Create an HTTP interceptor (class-based or functional) and inject `LoggerService`.
2. In the interceptor, pass the request through and attach an RxJS `catchError` that receives the HTTP failure.
3. Classify the failure into a domain error type using observable, deterministic inputs (status code, offline detection, URL patterns, response payload shape).
4. Emit exactly one log event per failed request with fields that support triage (URL, method, status, correlation id if present) and attach the original error.
5. Re-throw the classified domain error (or re-throw the original error when classification is not possible) so callers can choose UI behaviour.
6. Register the interceptor in the application's HTTP configuration so it applies to all requests.

### Validation
- `ng build` succeeds and the interceptor is included in the application bundle.
- An intentional failed request (for example to a bad URL) results in one structured log event and the calling code receives the re-thrown error.

## Procedure: Apply bounded retry with exponential backoff for safe requests

### When to use
Use when you need retries for transient failures on safe-to-repeat operations.

### Preconditions
- The operation is safe to re-run (idempotent or protected by an idempotency key).
- You have decided retry limits (attempt count and maximum total delay).

### Steps
1. Create a reusable RxJS operator function (for example `retryWithBackoff`) that accepts `maxAttempts`, `initialDelayMs`, and `maxDelayMs`.
2. Implement the operator using RxJS retry capabilities and a delay function that increases delay per attempt and caps at `maxDelayMs`.
3. Add a predicate that retries only on transient failure signals (for example: network offline recovered, timeouts, 502/503/504) and does not retry on deterministic failures (for example: 400/401/403/404).
4. Apply the operator only at call sites where retry is approved, not globally on all HTTP requests.
5. Add a unit test that simulates transient failures and asserts the correct number of resubscriptions and the final outcome.

### Validation
- Unit tests prove retries stop at the configured attempt limit.
- Logs show retries occur only for allowed error types and do not occur for excluded status codes.

## Procedure: Integrate an error monitoring provider behind the logger

### When to use
Use when you need production monitoring (error aggregation, alerting, release tracking) without scattering monitoring SDK calls across feature code.

### Preconditions
- Have a single "monitoring integration" module/library where monitoring SDK imports are allowed.
- Have environments/config that can disable monitoring for local development.

### Steps
1. Install the monitoring SDK packages and add them to the project dependencies.
2. Create a monitoring adapter (for example `MonitoringSink`) that exposes a small API (`captureException`, `captureMessage`, `setUser`, `setTag`).
3. Configure the adapter to initialise the SDK only when the production environment flag is enabled.
4. Update `LoggerService` to call the monitoring sink only for high-severity events (for example: `error` and `fatal`) and only after redacting sensitive fields.
5. Update the global error handler to include context fields (route, feature area, build version) via the logger so monitoring events carry usable tags.
6. Add an integration test (or a controlled dev environment) that triggers an exception and confirms the monitoring sink is invoked.

### Validation
- When production flag is off, triggering an error does not call the monitoring sink.
- When production flag is on, triggering an error calls the monitoring sink exactly once with the original `Error` object.