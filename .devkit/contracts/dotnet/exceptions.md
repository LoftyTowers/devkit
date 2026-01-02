# Exception Handling (canonical)

- Wrap the **entire body of every operational handler entrypoint** in a `try/catch`.
- Expected failures (validation, known domain rule failures, known external failures) MUST be represented as explicit outcomes (e.g., `Result` / `ReturnObj`) and MUST NOT use exceptions for control flow.
- Unexpected exceptions MUST be caught at the boundary, logged **once**, and converted into an explicit **Unexpected** outcome (e.g., `ErrorCode.Unexpected`).
- Inner layers MUST NOT log exceptions. They MAY catch only to add context/cleanup, but MUST rethrow OR rethrow-as (preserving the exception) so the boundary can handle logging and translation.
  - If you have chosen a "no rethrow anywhere" policy, then inner layers MUST NOT catch exceptions at all (except for cleanup via `finally`).
- MUST NOT swallow exceptions silently. If an exception is caught, it MUST either:
  - propagate to the boundary for translation, or
  - be translated at the boundary into an Unexpected outcome.

## Canonical boundary shape (schematic)

method entrypoint:
  try:
    run all method logic
    return success or expected failure outcome
  catch unexpected exception:
    log once at the boundary
    return Unexpected outcome (never throw)
