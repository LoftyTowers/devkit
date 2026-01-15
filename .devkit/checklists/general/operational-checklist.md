# Operational Checklist

For any new **operational** class (handles input or orchestrates work, e.g. endpoint, handler, saga, worker, CLI):

- [ ] Uses a typed `Result` / `Result<T>` and an `ErrorCode` enum (or equivalent error categories) for expected/handled outcomes; unexpected exceptions are handled at the operational boundary or central exception handler per the exceptions contract.
- [ ] Uses `CancellationToken` on public async methods and passes it through to async collaborators.
- [ ] Validates input at the edge (DTO/message/command) and treats validation failure as an error outcome
      (e.g. `ErrorCode.Validation`).
- [ ] Uses a structured logging scope with a correlation/trace identifier when available.
- [ ] Does not `new` collaborators inside methods; all dependencies are provided via constructor DI.
- [ ] Hosted services / long-lived workers do not inject scoped services directly; they create per-unit-of-work scopes via `IServiceScopeFactory`.
- [ ] When EF Core is used, production startup does not auto-run migrations and a controlled migration process exists.
- [ ] No blocking calls in request paths (explicitly: no `Thread.Sleep`).
- [ ] No sync-over-async (`.Result`/`.Wait`/`GetAwaiter().GetResult()`).
- [ ] `CancellationToken` flows through operational handlers where applicable.
- [ ] No `Task.Run` + immediate `await` in ASP.NET Core request paths.
- [ ] Background loops/waits honour `CancellationToken` (e.g., `Task.Delay`, timers) and stop work on cancellation.
- [ ] Tests cover:
  - Success
  - Validation failure
  - Unexpected error
  - Cancellation (where supported)
- [ ] Unexpected exceptions are logged **exactly once** by the host's designated operational boundary owner
      (per Logging contract "single owner of unexpected exception logging"); if global exception middleware
      owns unexpected exception logging, this operational class MUST NOT also log unexpected exceptions.

If any applicable item in this checklist is not met, update the code and/or tests to comply **before**
considering the feature complete.
