# Operational Contract

This contract applies to any code that reacts to input and orchestrates work:

- HTTP controllers / endpoints
- NServiceBus handlers and sagas
- message consumers
- background workers / scheduled jobs
- CLI commands that perform operations

Treat all of these as **operational handlers** and follow the rules below.

---

## 1. Dependency injection

- All collaborators (repositories, gateways, clients, clocks, validators, loggers, etc.) must be injected via the constructor.
- Do **not** resolve services manually or use service locators inside methods.
- Do **not** call `new` for collaborators inside operational methods.
- Static members are only allowed for **pure, stateless helpers** (no I/O, no shared state).

---

## 2. Async and cancellation

- If the platform allows it, operational methods must:
  - be `async`, and
  - accept a `CancellationToken` (or platform equivalent).
- Always pass the token through to async collaborators.
- Call `ThrowIfCancellationRequested()` before heavy work and in long-running operations.
- When cancelled, treat it as a **first-class outcome** (log it and return/emit a clear cancellation result).

---

## 3. Outcome and error handling

Operational code must never leak unhandled exceptions as normal behaviour.

- Normal outcomes should use a typed result or similar pattern, with:
  - `Success` / `IsSuccess`
  - a small set of error categories (e.g. a local `ErrorCode` enum: Validation, Domain, Cancelled, Unexpected)
  - optional error messages or reasons.
- Use exceptions only for unexpected conditions, not for validation or known domain rules.
- Wrap calls to external systems (HTTP services, DB, queues, payment gateways, file I/O) in `try/catch`:
  - log the exception with context,
  - convert it into an appropriate failure outcome (`Unexpected` or similar),
  - do **not** let the exception leak out as the primary signal.

Transport-specific rules:

- **HTTP endpoints**:
  - Map result + error category to HTTP responses via a central mapping (e.g. ProblemDetails, status code).
  - Do not create ad-hoc status codes per endpoint.
- **Non-HTTP handlers (sagas, workers, consumers)**:
  - Use result-like outcomes, events, or state transitions to represent failure.
  - Do not rely on callers catching exceptions as the normal error signal.

---

## 4. Validation

- Perform input validation at the **edge**:
  - HTTP: use FluentValidation on request DTOs.
  - Messaging: validate incoming messages before acting.
  - Workers/CLI: validate arguments before doing work.
- A validation failure is an **error outcome**, not just a flag on a success:
  - HTTP: return a 4xx response with a structured body.
  - Non-HTTP: return or emit a result/event that clearly states validation has failed.
- Do not duplicate the same validation rules in multiple layers without a reason.
  - If a validator guarantees basic shape (e.g. email syntax), downstream handlers may assume that shape.

---

## 5. Logging and scopes

- Use structured logging (`ILogger<T>` or equivalent).
- For each operation, open a logging scope that includes:
  - correlation / trace id (if the platform provides one),
  - key identifiers (OrderId, Email, UserId, etc.).
- Log:
  - start / end of significant operations at **Information** level,
  - validation and domain failures at **Information** or **Warning**,
  - unexpected errors at **Error**, with the exception attached.

---

## 6. Separation of concerns

- Operational code orchestrates work; it does **not** own core domain rules.
- Keep:
  - HTTP / messaging / worker concerns in the operational layer,
  - business rules in domain/services,
  - persistence in infrastructure.
- Do not let sagas, controllers, or workers become “god objects” that do validation, business rules, and persistence in one place.

---

## 7. Testing expectations

For any new operational handler (controller, saga, consumer, worker):

- [ ] Tests cover the **happy path**.
- [ ] Tests cover at least one **validation failure**.
- [ ] Tests cover at least one **unexpected error path** from a collaborator.
- [ ] Where cancellation is supported, tests cover cancelled work.
- [ ] Tests assert behaviour (outcome, events, status), not internal implementation details.

If any of these are missing, update the code or tests until this checklist passes.
