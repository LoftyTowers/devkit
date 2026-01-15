# Background work (guidance)

## BackgroundService shape (R1)
- Prefer `BackgroundService` for long-running tasks.
- Implement `ExecuteAsync(CancellationToken)` and yield early to avoid blocking host startup.
- Avoid long synchronous work before the first `await`.

## Stop and disposal (R7)
- Implement `StopAsync` to signal shutdown, stop timers, and flush work safely.
- Implement `IDisposable`/`IAsyncDisposable` for timers, subscriptions, and unmanaged resources.

## Retry posture (R8, R9)
- Use bounded retries with exponential backoff and jitter for transient failures.
- Apply a transient-error filter; do not retry cancellation or non-transient errors.
- Use a circuit breaker with retries to avoid hammering failing dependencies.

## Poison handling and diagnostics (R10, R11)
- After max attempts, dead-letter the message/job instead of retrying forever.
- Include diagnostics in DLQ metadata (reason, exception type, correlation id, last attempt time).

## Monitoring (R12)
- Monitor queue length, DLQ growth, failure rates, and processing latency.
- Track health indicators for the worker host and downstream dependencies.

## Worker host choice (R13)
- Consider the Worker Service template or a dedicated worker host for heavy background workloads.

## Allowed deviations
### D1: Custom IHostedService
- Use a custom `IHostedService` when you need precise startup sequencing or custom cancellation handling.
- Track the background task explicitly and ensure cancellation and disposal are handled reliably.

### D2: Timer-based scheduling
- Use `Timer`/`PeriodicTimer` when overlapping schedules are required.
- Ensure thread-safety and avoid concurrent execution races.
