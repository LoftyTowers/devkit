## Async and cancellation

- Operational methods must be `async` when the platform allows it, and **public async methods must accept a `CancellationToken`**.
- Public async method names end with `Async`.
- Always pass the cancellation token through to async collaborators and check it before heavy or long-running work.
- SHOULD use async end-to-end (e.g., validation, gateways, repositories) and pass the `CancellationToken` through all layers.
- Private helper methods may omit the token **only** if they perform no I/O and no long-running work.
- When cancelled, treat it as a **first-class outcome**: log at the boundary and return or emit a clear cancellation result.
