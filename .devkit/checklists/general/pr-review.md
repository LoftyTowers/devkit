# PR Review

**Correctness | Boundaries | Tests | Logging | Security | Performance | Docs**

Before approving a PR, confirm:

- The change is correct and preserves existing behaviour unless explicitly intended.
- Boundaries are respected (no domain logic in controllers/handlers; no I/O in domain).
- Tests cover the meaningful paths and assert behaviour, not implementation.
- If the PR touches EF Core/DbContext/migrations, apply `.devkit/checklists/dotnet/efcore.md`.
- Async & Concurrency:
  - No sync-over-async (`.Result`/`.Wait`/`GetAwaiter().GetResult()`).
  - No `async void` except event handlers.
  - No `Task.Run` misuse for I/O or already-async calls.
  - `CancellationToken` propagation where applicable.
  - No long-running "forever" ThreadPool loops without isolation.
  - `TaskCompletionSource<T>` uses `RunContinuationsAsynchronously` when used.
- Logging is structured, scoped, and exceptions are logged once at the boundary.
- Security controls are preserved (no secrets logged; no validation/auth bypass).
- Performance is reasonable (no obvious N+1 queries, repeated I/O, or unnecessary allocations).
- Documentation is updated where behaviour, contracts, or usage changed.

Design sanity checks:

- Over-engineering guard: no interface, abstraction, or pattern added without a real boundary or concrete variation.
- Any patterns used match a documented trigger; otherwise, recommend a simpler solution.
