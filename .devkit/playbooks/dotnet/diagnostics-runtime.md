# Diagnostics runtime behavior (guidance)

## Scope

- Non-enforceable guidance for runtime diagnostics and metrics tooling in .NET.

## When to use

- None.

## Guidance

### Metrics posture

- Prefer `System.Diagnostics.Metrics` for new runtime/application metrics.
- Use EventCounters only for legacy compatibility needs.
- Publish critical KPIs explicitly as metrics (latency, error rate, throughput).

### Cross-platform runtime counters

- Collect CPU, GC heap sizes, threadpool, and exception counts.
- Ensure collection works in Linux/container hosting as well as Windows.

### Diagnostic tools readiness

- Dev/test: ensure `dotnet-counters`, `dotnet-trace`, `dotnet-dump`, and `dotnet-gcdump` are available and usable.
- Production: prefer a defined approach (e.g., `dotnet-monitor` or sidecar pattern) with operational guardrails.

### Production safety

- Validate diagnostics capture under production-like CPU/memory/disk limits.
- Define capture budgets (data volume, retention) and document the operational impact.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
