# Background services with scoped dependencies

## Per-unit-of-work scope
1) Inject `IServiceScopeFactory` into the background service.
2) For each unit of work, create a scope via `CreateScope()` or `CreateAsyncScope()`.
3) Resolve scoped services from `scope.ServiceProvider` inside the unit of work.
4) Dispose the scope with `using` or `await using` after the unit completes.

## Reliability checks
- Ensure each unit of work creates its own scope.
- Avoid holding scoped services across iterations.
