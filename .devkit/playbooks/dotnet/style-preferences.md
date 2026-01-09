## Style and preferences

## Naming conventions

- Async suffix is enforced in `.devkit/contracts/dotnet/naming.md`; exceptions are described in `.devkit/playbooks/dotnet/naming-conventions.md`.
- See `.devkit/playbooks/dotnet/naming-conventions.md` for additional naming guidance and deviations.

## Cancellation token conventions (guidance)

- Always pass the cancellation token through to async collaborators and check it before heavy or long-running work.
- SHOULD use async end-to-end (e.g., validation, gateways, repositories) and pass the `CancellationToken` through all layers.
