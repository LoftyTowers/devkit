# Logging

## Logging rules

- MUST use structured logging (`ILogger<T>` or equivalent) with **message templates and named properties**.
- MUST NOT use string interpolation or string concatenation in log messages.

## Scopes and context

- For each operation, open a logging scope that includes:
  - a correlation / trace identifier (if the platform provides one),
  - key domain identifiers (e.g. `OrderId`, `UserId`, `Email`).
- SHOULD include correlation identifiers (`TraceId`, `CorrelationId`, `RequestId`) when available.

## Exception logging

- MUST log exceptions **once** at the operational boundary (controllers, message handlers, workers).
- Inner layers MAY catch exceptions for translation or cleanup, but SHOULD rethrow and MUST NOT log them.
- MUST preserve the original exception and stack trace.

## Operational events

- SHOULD log start and end of significant operations at **Information** level.
- SHOULD log validation and domain failures at **Information** or **Warning**, depending on severity and expected frequency.
