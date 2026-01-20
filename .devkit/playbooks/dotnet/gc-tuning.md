# GC tuning (guidance)

## Scope

- Non-enforceable guidance for .NET GC mode selection and tuning trade-offs.

## When to use

- None.

## Guidance

### GC mode selection (R5)

- Choose Server GC for throughput-heavy workloads and dedicated hosts.
- Choose Workstation GC for client-style or low-throughput workloads.
- Document the decision and hosting context (density, resource limits).

### LOH posture (R7)

- Reduce allocations first; tune LOH only when profiling shows fragmentation or churn.
- LOH compaction or threshold changes should be used only with profiling evidence.
- Note that LOH compaction requires a full GC.

## Trade-offs and pitfalls

### Concurrent/background GC trade-offs (R6)

- Treat concurrent/background GC as a deliberate trade-off.
- Disable only when strict pause predictability is required.
- If disabled, document the justification and evidence.

## Examples

- None.

## Cross-references

- None.
