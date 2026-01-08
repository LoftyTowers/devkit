## Style and preferences

## Naming conventions

- Public async method names end with `Async`.

## Cancellation token conventions (guidance)

- Always pass the cancellation token through to async collaborators and check it before heavy or long-running work.
- SHOULD use async end-to-end (e.g., validation, gateways, repositories) and pass the `CancellationToken` through all layers.
