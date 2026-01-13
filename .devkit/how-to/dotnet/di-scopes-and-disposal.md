# DI scopes and disposal

## Create and dispose scopes
1) Resolve `IServiceScopeFactory` from the root provider.
2) Create a scope with `CreateScope()` or `CreateAsyncScope()`.
3) Resolve scoped services from `scope.ServiceProvider`.
4) Dispose the scope with `using` or `await using` to release container-owned disposables.

## Example patterns
- Synchronous scope:
  - `using var scope = scopeFactory.CreateScope();`
- Asynchronous scope:
  - `await using var scope = scopeFactory.CreateAsyncScope();`

## Common mistakes to avoid
- Forgetting to dispose the scope (leaks container-managed disposables).
- Resolving disposable transients from the root provider in long-running flows.
