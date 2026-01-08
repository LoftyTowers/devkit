## Async and cancellation

## Definitions

- **ASP.NET Core request path**: controllers/endpoints and services directly invoked by them for that request.
- **Library-style code**: reusable, non-UI, non-endpoint code where a captured context is not required by default.
- **Cancellation-aware operation**: an operation that may block or wait asynchronously, perform long-running work, call token-accepting async APIs, or otherwise benefit from cooperative cancellation.

## Rules

- If a method awaits asynchronous work, it MUST be `async` and MUST return `Task`, `Task<T>`, `ValueTask`, or `ValueTask<T>`. It MUST NOT return `void`, except where D2 applies.
- Code MUST NOT synchronously block on tasks (`Task.Wait()`, `Task<T>.Result`, `GetAwaiter().GetResult()`).
- `async void` MUST NOT be used except for event handlers whose required signature returns `void`.
- In ASP.NET Core request paths, code MUST NOT use `Task.Run(...)` and immediately `await` it.
- Code MUST use `await` for sequencing asynchronous operations and MUST NOT use `Task.ContinueWith(...)` for ordinary control flow.
- Library-style code MUST use `ConfigureAwait(false)` on awaited tasks unless the continuation requires the captured context.
- Cancellation-aware operations MUST accept a `CancellationToken` and MUST pass it to downstream async APIs that accept a token.
- Any `CancellationTokenSource` created by the code MUST be disposed.
- Long-running background work MUST NOT permanently occupy ThreadPool threads via a "forever" `Task.Run` loop; use an appropriate long-running mechanism when present.
- `Task.Factory.StartNew(...)` MUST NOT be used for async delegates or as a substitute for `Task.Run` without explicit, justified scheduling semantics.
- Private helper methods may omit the token **only** if they perform no I/O and no long-running work.
- Cancellation MUST be represented via `OperationCanceledException` (or a derived type), using `ThrowIfCancellationRequested` or equivalent propagation.

## Allowed deviations

- D1: A synchronous boundary MAY block exactly once at the outermost entry point only when an async entry point is impossible. This MUST be isolated to that boundary and MUST NOT appear in application logic.
- D2: `async void` MAY be used for UI/event handlers only where the event signature requires `void`.
