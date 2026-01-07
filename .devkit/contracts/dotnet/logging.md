# Logging

## Logging rules

- MUST use structured logging (`ILogger<T>` or equivalent) with **message templates and named properties**.
- Loggers MUST be obtained via MEL abstractions (`ILogger` / `ILogger<T>`) from dependency injection.
- Application and library code MUST NOT depend on concrete logging implementations (e.g., Serilog `Logger`) outside the application entry point.
- Static or global logger instances MUST NOT be used outside the application entry point.
- Message templates MUST be constant string literals (CA2254 intent).
- Message templates MUST NOT be composed at runtime (no concatenation, interpolation, localisation tokens, or runtime building).
- Placeholder names in message templates MUST be meaningful and stable for the event.
- Placeholder names MUST NOT contain variable data.
- Values required for filtering, correlation, or analysis MUST be captured as structured properties (template placeholders or scope properties).
- A pre-formatted message string MUST NOT be passed as the first parameter when structured data is intended.
- Full request/response bodies or full object graphs MUST NOT be logged by default.
- If payload logging is explicitly required, it MUST be opt-in, redacted or masked, size-limited or truncated, and MUST NOT be enabled in production unless explicitly approved.
- Payload logging MUST be behind a configuration flag and MUST default to OFF.
- Payload logging MUST be per-endpoint/operation (or per handler), not a global always-on setting.
- When payload logging is enabled, only filtered/redacted extracts MAY be logged; raw payloads MUST NOT be emitted.
- Logging configuration MUST be centralised in the application entry point (Program.cs / host builder) and/or configuration files.
- Business logic MUST NOT configure logging providers or sinks.
- When Serilog is used as the MEL provider, configuration MUST explicitly enable MEL scope/context propagation into Serilog events.
- Scope/context inclusion MUST be configured explicitly; reliance on implicit defaults is forbidden.
- The logging pipeline MUST NOT emit duplicate log events for a single log call.
- When adding Serilog or other providers, default providers that cause duplicate events MUST be cleared or disabled.
- Logging MUST NOT perform blocking external I/O on the caller path.
- When a sink can block (network, database, remote API), buffering, async wrappers, or durable sinks MUST be used.
- Production log level configuration MUST be explicit, including minimum levels and category/namespace overrides.
- MUST NOT use string interpolation or string concatenation in log messages.

---

## Scopes and context

- For each operation, a logging scope MUST be opened at the boundary that includes:
  - a correlation / trace identifier (if the platform provides one),
  - key domain identifiers (e.g. `OrderId`, `UserId`, `Email`).
- SHOULD include correlation identifiers (`TraceId`, `CorrelationId`, `RequestId`) when available.
- Scope values MUST be small, stable, and safe for structured logging.
- Scope values MUST NOT include full payloads, full object graphs, or sensitive personal data in clear text.

### Context ownership and contribution

- The boundary MUST open the operation scope.
- Inner layers MAY contribute additional diagnostic fields only via the DevKit-approved diagnostic context mechanism.
- Inner layers MUST NOT:
  - open new scopes for routine context,
  - call `BeginScope` directly,
  - call Serilog `LogContext` APIs directly,
  unless explicitly authorised by a DevKit rule and done via a DevKit helper that enforces policy.

---

## Diagnostic context preservation (inner layers -> boundary)

### Purpose

Preserve inner-layer diagnostic context so boundary logging is sufficient to diagnose failures **without** inner-layer logging, duplicate logs, or swallowed exceptions.

### Inner-layer rules (no logging)

- Inner layers MUST NOT log exceptions for routine flows.
- Inner layers MUST NOT swallow exceptions.
- Inner layers MUST NOT catch `System.Exception`; only specific exception types MAY be caught.
- When rethrowing the same exception instance, inner layers MUST use `throw;` to preserve the original stack trace.
- When adding diagnostic context, inner layers MAY attach context via approved mechanisms, provided:
  - the original exception is preserved when wrapping,
  - exception type, message, and stack trace are preserved,
  - cancellation (`OperationCanceledException`) is not translated or wrapped.
- Inner layers MUST NOT add diagnostic context by logging.

### Preferred mechanism: operation-scoped diagnostic context carrier

- Diagnostic context MUST be preserved primarily via an operation-scoped diagnostic context carrier that is emitted by the boundary log event.
- The context carrier MUST:
  - be operation-scoped and async-flow-safe,
  - be cleared/disposed at the boundary,
  - enforce allow-listed keys only,
  - enforce redaction/masking rules,
  - enforce caps on field count and value length.
- Inner layers MUST interact with diagnostic context only via the DevKit-approved helper and MUST NOT call logging APIs directly.

### Allowed mechanism: contextual exception wrapping (secondary)

- Inner layers MAY wrap exceptions to add semantic meaning or attach diagnostic context that cannot be propagated via the context carrier.
- Wrapped exceptions MUST:
  - preserve the original exception as `InnerException`,
  - expose diagnostic context as explicit fields/properties,
  - include only small, safe, structured values.
- Wrapped exceptions MUST NOT include payloads, entities/DTOs, secrets, or unredacted personal data.

### Alternative mechanism (allowed, not preferred)

- Inner layers MAY attach diagnostic context via `Exception.Data` only if:
  - keys are stable strings,
  - values meet the same size and safety limits above.
- Boundary logging MUST treat `Exception.Data` as untrusted and MUST filter to allowed keys/types before logging.

---

## Boundary exception logging

- Exceptions MUST be logged only at an operational boundary (controllers, handlers, workers), unless explicitly authorised.
- Boundary logging MUST log the exception object itself (not message-only logging).
- Boundary logging MUST include:
  - boundary scope/context values, and
  - any preserved inner-layer diagnostic context.
- Boundary logging MUST emit a single log event per failure.
- Boundary logging MUST NOT rely on implicit provider defaults for context propagation.

### Single owner of unexpected exception logging

- Exactly one boundary per host MUST own unexpected exception logging.
- If global exception middleware logs unexpected exceptions, controllers/handlers MUST NOT also log them.
- If controllers/handlers log unexpected exceptions, global exception middleware MUST NOT log them.

---

## Exception logging

- Logging exceptions MUST preserve the original exception and stack trace.
- Logging MUST NOT swallow exceptions.
- Cancellation (`OperationCanceledException`) MUST NOT be logged as an unexpected error unless explicitly required by policy.

---

## Operational events

- SHOULD log start and end of significant operations at **Information** level.
- SHOULD log validation and domain failures at **Information** or **Warning**, depending on severity and expected frequency.
