# Locking and deadlocks (SQL Server contract)

## Scope
Defines enforceable behaviors for locks, blocking, escalation, and deadlocks.

## Rules (R#)
- R1: Treat exclusive locks for data modifications as held until transaction completion regardless of isolation level.
- R2: Under READ COMMITTED without RCSI, expect reader-writer blocking due to shared locks for reads conflicting with exclusive locks for writes during overlapping operations.
- R3: Treat lock escalation as possible (row or page to table lock) when thresholds or memory pressure are reached, expanding blocking scope.
- R4: Treat deadlocks as occurring when transactions hold locks each other needs, and SQL Server resolves them by selecting a deadlock victim and rolling back that victim’s transaction.
- R6: Treat NOLOCK or READ UNCOMMITTED as avoiding some blocking or deadlocks at the cost of documented anomalies, not as a correctness-preserving fix.

## Prohibited patterns (P#)
- P1: Long-running transactions that unnecessarily extend lock duration and amplify blocking.
- P2: Using NOLOCK as a default policy to avoid blocking or deadlocks without explicitly accepting correctness anomalies.

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/locking-and-deadlocks.md
- playbooks/sql/isolation-levels.md
