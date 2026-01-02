# Operational Checklist

For any new **operational** class (handles input or orchestrates work, e.g. endpoint, handler, saga, worker, CLI):

- [ ] Uses a typed `Result` / `Result<T>` and an `ErrorCode` enum (or equivalent error categories) for all outcomes.
- [ ] Uses `CancellationToken` on public async methods and passes it through to async collaborators.
- [ ] Validates input at the edge (DTO/message/command) and treats validation failure as an error outcome
      (e.g. `ErrorCode.Validation`).
- [ ] Uses a structured logging scope with a correlation/trace identifier when available.
- [ ] Does not `new` collaborators inside methods; all dependencies are provided via constructor DI.
- [ ] Tests cover:
  - Success
  - Validation failure
  - Unexpected error
  - Cancellation (where supported)
- [ ] Wraps the full method body in a `try/catch` per the exceptions contract and logs exceptions
      **once** at the operational boundary.

If any applicable item in this checklist is not met, update the code and/or tests to comply **before**
considering the feature complete.
