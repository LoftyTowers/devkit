## Async and cancellation

- Operational methods must be `async` when the platform allows it, and **public async methods must accept a `CancellationToken`**.
- Public async method names end with `Async`.
- Always pass the cancellation token through to async collaborators and check it before heavy or long-running work.
- SHOULD use async end-to-end (e.g., validation, gateways, repositories) and pass the `CancellationToken` through all layers.
- Private helper methods may omit the token **only** if they perform no I/O and no long-running work.
- Cancellation MUST be represented via `OperationCanceledException` (or a derived type), using `ThrowIfCancellationRequested` or equivalent propagation.
- At the boundary, cancellation MAY be mapped to a cancellation outcome (e.g., `ErrorCode.Cancelled`).
- MUST NOT translate cancellation into `Unexpected` or success outcomes.
