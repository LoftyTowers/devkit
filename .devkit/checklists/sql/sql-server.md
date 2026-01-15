# SQL Server checklist

Use this checklist during code review, schema review, or production issue triage.

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

## Transactions and locking
- Transaction boundaries are explicit where correctness depends on them.
- Long-running transactions avoided.
- Isolation level choices are deliberate.
- Deadlock risks are considered for hot paths.
- Concurrency approach is documented where it affects correctness.

## Migrations
- EF Core migrations are versioned, reviewed, and repeatable.
- Migration scripts avoid destructive surprises.
- Rollback strategy exists (where required).
- Deployment order and app/db compatibility is considered.

## Security
- Principle of least privilege for database users/roles.
- Sensitive data handling considered (encryption, access controls where required).
- No secrets stored in plain text in the repository.
- Auditing/traceability considered for sensitive operations (where required).
