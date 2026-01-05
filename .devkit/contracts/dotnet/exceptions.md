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
- If an exception is caught, it MUST either:
  - propagate to the boundary for translation, or
  - be translated at the boundary into an Unexpected outcome.

## Canonical boundary shape (schematic)

method entrypoint:
  try:
    run all method logic
    return success or expected failure outcome
  catch unexpected exception:
    return Unexpected outcome (never throw)
