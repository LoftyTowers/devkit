# Locking and deadlocks (SQL Server contract)

## Scope

Defines enforceable behaviors for locks, blocking, escalation, and deadlocks.

## Rules

- Treat exclusive locks for data modifications as held until transaction completion regardless of isolation level.
- Under READ COMMITTED without RCSI, expect reader-writer blocking due to shared locks for reads conflicting with exclusive locks for writes during overlapping operations.
- Treat lock escalation as possible (row or page to table lock) when thresholds or memory pressure are reached, expanding blocking scope.
- Treat deadlocks as occurring when transactions hold locks each other needs, and SQL Server resolves them by selecting a deadlock victim and rolling back that victim's transaction.
- NOLOCK or READ UNCOMMITTED MUST NOT be treated as a correctness-preserving fix for blocking or deadlocks.

## Prohibited patterns

- Transactions MUST NOT be long-running in ways that unnecessarily extend lock duration and amplify blocking.
- NOLOCK MUST NOT be used as a default policy to avoid blocking or deadlocks without explicitly accepting correctness anomalies.

## Allowed deviations

- None.

## Cross-references

- playbooks/sql/locking-and-deadlocks.md
- playbooks/sql/isolation-levels.md
