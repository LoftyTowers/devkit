# Exception Handling (canonical)

- Wrap the **entire body of every operational handler entrypoint** in a `try/catch`.
- Expected failures (validation, known domain rule failures, known external failures) MUST be represented as explicit outcomes (e.g., `Result` / `ReturnObj`) and MUST NOT use exceptions for control flow.
- Unexpected exceptions MUST be caught at the boundary and converted into an explicit **Unexpected** outcome (e.g., `ErrorCode.Unexpected`).
- Inner layers MUST NOT swallow exceptions.
- Inner layers MAY catch only specific exception types (not `System.Exception`) for handling, cleanup, or adding context.
- If an inner layer catches an exception, it MUST rethrow in a way that preserves the original exception and stack trace.
  - If rethrowing without wrapping, use `throw;`.
  - If wrapping, the original exception MUST be assigned to `InnerException`.
- When wrapping for context, add only a short contextual message and small, safe key fields.
- Diagnostic context preservation SHOULD be done via the Logging contract's operation-scoped diagnostic context mechanism.
- Exception wrapping for context MUST be used sparingly and only when adding semantic meaning or when the required diagnostic fields cannot be preserved via the approved context carrier.
- If an exception is caught, it MUST either:
  - propagate to the boundary for translation, or
  - be translated at the boundary into an Unexpected outcome.

## Failure signalling for non-HTTP handlers (dotnet operational boundaries)

- SHOULD represent failures in non-HTTP operational handlers using result-like outcomes, events, or state transitions.
- MUST NOT rely on callers catching exceptions as the normal error signal.
- This does not require inner layers to catch exceptions; unexpected exceptions are handled at the operational boundary.

## Canonical boundary shape (schematic)

method entrypoint:
  try:
    run all method logic
    return success or expected failure outcome
  catch unexpected exception:
    return Unexpected outcome (never throw)
