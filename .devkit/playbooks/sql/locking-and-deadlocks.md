# Locking and deadlocks playbook (SQL Server)

## Scope
Guidance for minimizing blocking and deadlocks in transactional workloads.

## When to use
- When reviewing transaction scope and lock contention risks.
- When diagnosing deadlock patterns.

## When not to use
- NOLOCK SHOULD NOT be treated as a correctness-preserving fix.

## Guidance
- To minimize deadlocks, transactions SHOULD be kept short, user interaction inside transactions SHOULD be avoided, objects SHOULD be accessed in a consistent order, and row-versioning isolation SHOULD be considered where appropriate.
- Read-modify-write patterns at READ COMMITTED SHOULD NOT assume that readers and writers will not deadlock; ordering and locking SHOULD be reviewed.
- Row-versioning isolation (RCSI or SNAPSHOT) MAY be used to reduce reader-writer blocking when business rules permit and operational constraints are acceptable.

## Pitfalls
- Long-running transactions that extend lock duration.
- Relying on NOLOCK to avoid deadlocks without accepting anomalies.

## Cross-references
- contracts/sql/locking-and-deadlocks.md
- playbooks/sql/isolation-levels.md
