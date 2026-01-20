# Diagnostics runtime behavior

## Scope

- System.Diagnostics.Metrics and EventCounters
- dotnet-* diagnostics tools and dotnet-monitor patterns
- Container diagnostics access
- Runtime counter collection
Out of scope: vendor dashboards and platform-specific observability backends.

### Notes

- `.devkit/contracts/dotnet/logging.md`
- `.devkit/contracts/dotnet/observability-opentelemetry.md`

## Rules

- Runtime counters and diagnostics collection MUST support cross-platform hosting (Linux/containers), including CPU, GC heap sizes, threadpool, and exception counts.

## Prohibited patterns

- PerformanceCounters as the primary mechanism in cross-platform/Linux/container deployments MUST NOT be used.
- Heavy diagnostic capture in production without validating memory/disk/CPU impact under production-like limits MUST NOT be used.

## Allowed deviations

- Legacy PerformanceCounter modules MAY be used only when the hosting environment is explicitly Windows and supports them.

## Cross-references

- None.
