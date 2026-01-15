# Background work

## Scope
Hosted services, worker services, and background processing loops.

## Rules
- Hosted services MUST be registered via `AddHostedService<T>()`.
- `StartAsync` MUST be lightweight and MUST NOT perform lengthy or blocking work.
- `ExecuteAsync` MUST yield early; it MUST NOT perform long synchronous initialisation before the first `await`.
- Background loops and waits MUST pass and honour the provided `CancellationToken` (e.g., `Task.Delay`, timers).
- Retries MUST be bounded and MUST use a transient-error filter; cancellation and non-transient failures MUST NOT be retried.
- Queue/message processors MUST implement poison handling: after max attempts, dead-letter rather than retry forever.

## Prohibited patterns
- Lengthy or blocking work in `StartAsync` MUST NOT occur.
- Long synchronous initialisation in `ExecuteAsync` before the first `await` MUST NOT occur.
- Background loops/waits that ignore `CancellationToken` or continue work after stop is requested MUST NOT occur.
- Retrying on all exceptions without a transient filter (including cancellation/non-transient) MUST NOT occur.
- Infinite retries with no poison/DLQ handling MUST NOT occur.

## Related documents
- `.devkit/contracts/dotnet/async-cancellation.md`
- `.devkit/contracts/dotnet/dependency-injection.md`
- `.devkit/contracts/dotnet/http-clients.md`
- `.devkit/how-to/dotnet/background-services-scoped-deps.md`
