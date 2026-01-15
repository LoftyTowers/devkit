# SQL Server checklist

Use this checklist during code review, schema review, or production issue triage.

See also: .devkit/checklists/sql/query-design.md

## Schema design
- Every table has a PRIMARY KEY.
- PRIMARY KEY columns are NOT NULL.
- PRIMARY KEY definitions do not exceed SQL Server limits (32 columns or 900 bytes total key length).
- Foreign key column data types exactly match referenced column data types.
- Foreign keys target PRIMARY KEY or UNIQUE constraints.
- Designs do not assume SQL Server auto-indexes foreign key columns.
- Deprecated types TEXT/NTEXT/IMAGE are not used.
- The same logical attribute uses the same data type across tables.

## Constraints
- CHECK constraints handle NULL explicitly when NULL must be rejected.
- Designs do not rely on CHECK constraints to block DELETE operations.
- DEFAULT constraints are explicitly named.
- Designs do not rely on DEFAULT constraints to change values on UPDATE.
- Computed columns are not inserted or updated directly.
- Computed columns are not used in DEFAULT or FOREIGN KEY constraints.
- Sparse column restrictions are respected when sparse columns are used.

## Queries
- NULL comparisons use IS NULL / IS NOT NULL (not = or !=).
- Queries select only required columns (avoid SELECT * for schema-change safety).
- Queries do not rely on physical column order.

## Indexing
- Indexes align to real query patterns (read/write trade-offs considered).
- Avoid over-indexing heavily updated tables.
- Avoid unnecessary or wide indexes (only include required columns).
- Index usage is monitored and unused indexes are removed over time.

## Indexing (Blob C)
- Clustered index count is 0 or 1.
- Composite key order follows equality then range then sort; distinctness order considered.
- Key column limits respected (16 columns, 900 bytes total key size).
- INCLUDE column limit respected (1,023 columns).
- INCLUDE columns are not treated as key columns for seeks/range scans.
- Filtered index predicates use only allowed forms (no LIKE, OR, computed predicate, or multi-table references).
- No redundant or superseded indexes (leading key coverage checked).
- No numeric selectivity thresholds stated as authoritative.
- If a heap is used, the scenario justification matches allowed deviation patterns.

## Transactions and locking
- Transaction boundaries are explicit where correctness depends on them.
- Long-running transactions avoided.
- Isolation level choices are deliberate.
- Deadlock risks are considered for hot paths.
- Concurrency approach is documented where it affects correctness.

## Transactions and error handling (Blob D)
- Autocommit vs explicit vs implicit transaction usage is intentional; no implicit mode without commit/rollback logic.
- Nested transaction ownership and savepoint usage are explicit; inner procedures do not rollback caller-owned transactions.
- Isolation level selection documents anomaly trade-offs; NOLOCK is not used for correctness-critical reads.
- Deadlock avoidance patterns are applied (short transactions, consistent ordering, no user interaction in transactions).
- TRY...CATCH patterns include explicit rollback or commit decision logic and error propagation.
- XACT_STATE is used in CATCH to choose rollback vs commit; @@TRANCOUNT alone is not used for committable decisions.
- XACT_ABORT usage is explicit where required, and its limitations are understood.
- Row-versioning isolation impacts (version store, tempdb) are considered where enabled.
- Retry-safe design is intentional; idempotency is addressed or retries are avoided.

## Migrations
- EF Core migrations are versioned, reviewed, and repeatable. (Dotnet scope)
- Migration scripts avoid destructive surprises. (Dotnet scope)
- Rollback strategy exists (where required). (Dotnet scope)
- Deployment order and app/db compatibility is considered. (Dotnet scope)

## Security
- Principle of least privilege for database users/roles.
- Sensitive data handling considered (encryption, access controls where required).
- No secrets stored in plain text in the repository.
- Auditing/traceability considered for sensitive operations (where required).
