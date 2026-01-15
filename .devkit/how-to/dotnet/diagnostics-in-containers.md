# Diagnostics in containers

## Scope
Container diagnostics access patterns for runtime tooling.

## Supported patterns
### Diagnostic port
1) Enable a diagnostic port for the container runtime.
2) Expose the port to the diagnostics tooling host.

### Shared socket
1) Mount a shared volume for the diagnostics socket.
2) Configure the runtime to emit diagnostics to the shared socket path.
3) Attach tooling to the socket from a sidecar or host.

### Process namespace / sidecar
1) Run a sidecar with access to the target process namespace.
2) Execute diagnostics tools within the shared namespace.

## Verification steps
1) Run diagnostics commands inside the container or sidecar.
2) Validate counters, traces, and dumps can be collected without errors.
3) Repeat under realistic CPU/memory/disk limits.

## Example commands
```bash
dotnet-counters monitor --process-id <pid>
dotnet-trace collect --process-id <pid> -o trace.nettrace
dotnet-dump collect --process-id <pid> -o dump.dmp
dotnet-gcdump collect --process-id <pid> -o gc.gcdump
```
