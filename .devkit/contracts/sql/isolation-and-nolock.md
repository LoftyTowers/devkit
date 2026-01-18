# SQL Server isolation and NOLOCK contract

## Scope

Applies to READ UNCOMMITTED/NOLOCK usage for correctness-critical reads.

## Rules

### Rules (R#)

- Treat SQL Server as supporting READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, SERIALIZABLE, plus SNAPSHOT and READ COMMITTED SNAPSHOT (RCSI).
- Treat dirty reads as permitted only under READ UNCOMMITTED (including NOLOCK), and not under READ COMMITTED or higher.
- Under READ COMMITTED without RCSI, treat shared locks for reads as held for the duration of the read operation (not the full transaction), so non-repeatable reads and phantoms remain possible.
- Treat REPEATABLE READ as preventing dirty and non-repeatable reads but still allowing phantoms.
- Treat SERIALIZABLE as preventing dirty reads, non-repeatable reads, and phantoms, with increased blocking due to range locks.
- Treat SNAPSHOT isolation as providing transaction-level read consistency via row versioning without holding row/page locks for reads.
- Treat READ_COMMITTED_SNAPSHOT ON as changing READ COMMITTED to use row-versioned statement-level reads, removing most reader-writer blocking.
- When ALLOW_SNAPSHOT_ISOLATION is ON, treat SQL Server as creating row versions for data modifications regardless of whether current transactions are using SNAPSHOT.
- When READ_COMMITTED_SNAPSHOT is ON, treat readers as using versioned reads while writers still block writers.

## Prohibited patterns

### Prohibited patterns (P#)

- READ UNCOMMITTED (including NOLOCK) MUST NOT be used for correctness-critical reads and MUST NOT be treated as a correctness-preserving deadlock fix.
- READ COMMITTED SNAPSHOT (RCSI) MUST NOT be assumed to provide transaction-level repeatable reads.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/query-hints.md
- .devkit/playbooks/sql/isolation-levels.md
