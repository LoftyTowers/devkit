# Error handling and logging

## Context
Error handling needs to work across UI events, async tasks, template execution, and HTTP calls. A fragmented approach makes production triage slow, increases duplicated code, and makes user messaging inconsistent.
Logging and monitoring need a single, predictable pipeline so engineers can correlate a user action to an error, a network call, and the user-visible outcome without leaking sensitive data.

## Guidance
- Organise error handling around two layers: a global capture layer for unhandled faults, and local handling for recoverable, feature-specific failures.

- Prefer transforming raw technical failures into a small set of domain error types (for example: `NetworkUnavailable`, `Unauthorised`, `Forbidden`, `NotFound`, `ValidationFailed`, `ServerError`, `Unexpected`).

- Separate "user message" concerns from "engineering diagnostics" concerns: show the minimum safe message to the user, and log the full diagnostic detail to the logging pipeline.

- Prefer placing cross-cutting HTTP error classification in an interceptor, and keeping feature components focused on UI behaviour, not transport details.

- Avoid retrying by default; apply retries only where the operation is safe to repeat and the user experience benefits.

- Prefer bounded retry budgets: cap attempts and cap total retry time so failures remain observable and do not stall UI flows indefinitely.

- Prefer structured logging (event name + fields) over ad-hoc strings so logs remain queryable and consistent.

- Prefer logging the original `Error` object (or preserving it via a `cause` chain) rather than logging only `error.message` to avoid losing stack context.

- Prefer a single monitoring integration that receives events from the same central logger and global error handler so the "source of truth" for reporting is consistent.


## Trade-offs
- Centralising HTTP error handling in an interceptor reduces duplication but can hide case-by-case UI needs if it tries to own user messaging for every endpoint.

- Aggressive retries can reduce transient failure rates but can also amplify load on backends, increase perceived latency, and create duplicate side effects for non-idempotent operations.

- Capturing everything globally improves observability but increases noise; without classification and sampling, engineers can lose critical signals in high-volume "expected" errors.

- Rich client logs improve triage but increase privacy risk; without strict redaction rules, logs can leak personal data and security-sensitive tokens.


## Decision criteria
- Choose global error capture as the primary route when the error is unhandled, originates outside a feature boundary, or would otherwise crash the UI flow.

- Choose local handling when the UI can recover immediately (for example: inline form validation errors, optional content failing to load, a single widget error inside a resilient page layout).

- Choose interceptor-based HTTP classification when multiple features share the same transport semantics (auth expiry, forbidden, network offline, server unavailable).

- Choose call-site handling when retry rules, fallback behaviour, or user messaging differs materially per feature or per endpoint.

- Choose retry with backoff when the operation is idempotent and the failure mode is transient (timeouts, flaky mobile connectivity, 502/503/504).

- Avoid retry when the operation has side effects (payments, mutations without idempotency keys) or when errors are deterministic (4xx validation failures).


## Preferences
- PREFERENCE — JUSTIFIED: Prefer a single `LoggerService` entry point that can emit to multiple sinks (console in dev, remote in production, monitoring for high-severity events).

- PREFERENCE — JUSTIFIED: Prefer mapping technical errors to stable error codes and using those codes in user messages, support tooling, and monitoring tags.
