# Async and concurrency (guidance)

## CPU-bound vs I/O-bound decisioning (R8)
- I/O-bound work waits on external systems (network, disk, database). Await I/O tasks directly.
- CPU-bound work consumes CPU cycles locally. Consider `Task.Run` only when you must keep a thread responsive.
- Default: use async I/O; do not offload I/O to `Task.Run`.

## Allowed deviation (D2): Task.Run for CPU-bound offload
- `Task.Run` MAY be used for CPU-bound work when you need to free a UI/request thread.
- `Task.Run` MUST NOT be used to wrap I/O-bound work or already-async calls.

### Examples
```csharp
// Good: CPU-bound work offloaded
var result = await Task.Run(() => ComputeHash(input), cancellationToken);
```

```csharp
// Bad: wrapping I/O in Task.Run
var data = await Task.Run(() => httpClient.GetAsync(url, cancellationToken));
```

```csharp
// Bad: wrapping an async call in Task.Run
var data = await Task.Run(() => ReadAsync(stream, cancellationToken));
```

## ConfigureAwait boundaries (note)
- Use `ConfigureAwait(false)` in library/infrastructure code that does not require a captured context.
- Avoid `ConfigureAwait(false)` when you must resume on the original context (e.g., UI updates).
