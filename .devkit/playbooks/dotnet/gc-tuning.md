# GC tuning (guidance)

## GC mode selection (R5)
- Choose Server GC for throughput-heavy workloads and dedicated hosts.
- Choose Workstation GC for client-style or low-throughput workloads.
- Document the decision and hosting context (density, resource limits).

## Concurrent/background GC trade-offs (R6)
- Treat concurrent/background GC as a deliberate trade-off.
- Disable only when strict pause predictability is required.
- If disabled, document the justification and evidence.

## LOH posture (R7)
- Reduce allocations first; tune LOH only when profiling shows fragmentation or churn.
- LOH compaction or threshold changes should be used only with profiling evidence.
- Note that LOH compaction requires a full GC.
