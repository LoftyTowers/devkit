# Locking and deadlocks playbook (SQL Server)

## Scope
Guidance for minimizing blocking and deadlocks in transactional workloads.

## When to use
- When reviewing transaction scope and lock contention risks.
- When diagnosing deadlock patterns.

## When not to use
- Do not treat NOLOCK as a correctness-preserving fix.

## Guidance
- R5: To minimize deadlocks, keep transactions short, avoid user interaction inside transactions, access objects in a consistent order, and consider row-versioning isolation where appropriate.
- P3: Read-modify-write patterns at READ COMMITTED must not assume readers and writers will not deadlock; review ordering and locking.
- D1: Using row-versioning (RCSI or SNAPSHOT) to reduce reader-writer blocking is allowed when business rules permit and operational constraints are acceptable.

## Pitfalls
- Long-running transactions that extend lock duration.
- Relying on NOLOCK to avoid deadlocks without accepting anomalies.

## Cross-references
- contracts/sql/locking-and-deadlocks.md
- playbooks/sql/isolation-levels.md
