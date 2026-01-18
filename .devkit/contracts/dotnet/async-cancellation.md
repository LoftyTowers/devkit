# Async and cancellation

## Scope

### Definitions

- **ASP.NET Core request path**: controllers/endpoints and services directly invoked by them for that request.
- **Library-style code**: reusable, non-UI, non-endpoint code where a captured context is not required by default.
- **Cancellation-aware operation**: an operation that may block or wait asynchronously, perform long-running work, call token-accepting async APIs, or otherwise benefit from cooperative cancellation.

## Rules

- If a method calls an async API, the call chain MUST remain async and the task MUST be awaited end-to-end.
- If a method awaits asynchronous work, it MUST be `async` and MUST return `Task`, `Task<T>`, `ValueTask`, or `ValueTask<T>`. It MUST NOT return `void`, except where D2 applies.
- I/O-bound operations MUST use true async APIs where available; code MUST NOT use `Task.Run` to wrap I/O-bound work or already-async calls.
- Code MUST NOT synchronously block on tasks (`Task.Wait()`, `Task<T>.Result`, `GetAwaiter().GetResult()`).
- `async void` MUST NOT be used except for event handlers whose required signature returns `void`.
- In ASP.NET Core request paths, code MUST NOT use `Task.Run(...)` and immediately `await` it.
- Code MUST use `await` for sequencing asynchronous operations and MUST NOT use `Task.ContinueWith(...)` for ordinary control flow.
- Library-style code MUST use `ConfigureAwait(false)` on awaited tasks unless the continuation requires the captured context.
- Cancellation-aware operations MUST accept a `CancellationToken` and MUST pass it to downstream async APIs that accept a token.
- `CancellationToken` parameters MUST be the final parameter; they MUST NOT appear in any other position.
- `CancellationToken` parameters MAY be optional only for public APIs where cancellation is genuinely optional; internal APIs MUST require explicit tokens.
- When intentionally handling cancellation, code MUST catch `OperationCanceledException` and MUST NOT catch only `TaskCanceledException`.
- Code MUST NOT catch and swallow `OperationCanceledException` unless it explicitly intends to handle cancellation (cleanup/controlled response); otherwise it MUST propagate.
- Any `CancellationTokenSource` created by the code MUST be disposed.
- Cancellation MUST be observed at safe checkpoints before irreversible side-effects (e.g., prior to writes/commits/external side-effects).
- After a point of no return, code MUST NOT cancel mid-change in a way that can leave partial side-effects or inconsistent state; it MUST complete safely or revert safely.
- Once a success outcome has been determined (the operation's result is known), code MUST return that result normally and MUST NOT perform additional cancellation checks that can override the completed outcome.
- In ASP.NET Core request paths, `HttpContext.RequestAborted` MUST be propagated into long-running and I/O-bound work started for that request.
- Long-running or I/O-bound work within a request MUST NOT run without passing `HttpContext.RequestAborted`.
- Code MUST NOT rely on request/response stream reads or writes to detect abort for external/background tasks; use `RequestAborted` propagation.
- Background loops/waits (e.g., `Task.Delay`, timers, `PeriodicTimer.WaitForNextTickAsync`) MUST pass the `CancellationToken` and stop work promptly when cancellation is requested.
- Code MUST NOT continue doing new work after cancellation is requested.
- Code in request paths and long-running/background loops MUST NOT block ThreadPool threads (e.g., `Thread.Sleep`); use async waits or appropriate scheduling.
- Long-running background work MUST NOT permanently occupy ThreadPool threads via a "forever" `Task.Run` loop; use an appropriate long-running mechanism when present.
- When `TaskCompletionSource<T>` is used, it MUST use `TaskCreationOptions.RunContinuationsAsynchronously` unless an explicit comment explains why it is unsafe or unnecessary.
- `Task.Factory.StartNew(...)` MUST NOT be used for async delegates or as a substitute for `Task.Run` without explicit, justified scheduling semantics.
- Private helper methods may omit the token **only** if they perform no I/O and no long-running work.
- Cancellation MUST be represented via `OperationCanceledException` (or a derived type), using `ThrowIfCancellationRequested` or equivalent propagation.

## Prohibited patterns

- None.

## Allowed deviations

- D1: A synchronous boundary MAY block exactly once at the outermost entry point only when an async entry point is impossible. This MUST be isolated to that boundary and MUST NOT appear in application logic.
- D2: `async void` MAY be used for UI/event handlers only where the event signature requires `void`.

## Cross-references

- None.
