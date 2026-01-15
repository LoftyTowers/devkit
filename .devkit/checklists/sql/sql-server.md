# SQL Server checklist

Use this checklist during code review, schema review, or production issue triage.

## Schema design
- Tables have a clear primary key strategy
- Data types are chosen intentionally (no “defaults” without reason)
- Nullability reflects domain reality (not convenience)
- Constraints exist where correctness must be enforced (PK/FK/unique/check)
- Naming conventions are consistent across objects

## Queries
- Queries select only required columns (avoid `SELECT *`)
- Predicates are sargable where practical
- Parameter usage avoids ad-hoc string concatenation patterns
- Pagination and ordering are deterministic
- Heavy queries have an evidence-based approach (measured, not guessed)

## Indexing
- Indexes align to real query patterns (read/write trade-offs considered)
- Covering indexes used when justified
- Duplicate/overlapping indexes avoided
- Index maintenance considerations are understood (fragmentation, fill factor where applicable)

## Transactions and locking
- Transaction boundaries are explicit where correctness depends on them
- Long-running transactions avoided
- Isolation level choices are deliberate
- Deadlock risks are considered for hot paths
- Concurrency approach is documented where it affects correctness

## Migrations
- EF Core migrations are versioned, reviewed, and repeatable
- Migration scripts avoid destructive surprises
- Rollback strategy exists (where required)
- Deployment order and app/db compatibility is considered

## Security
- Principle of least privilege for database users/roles
- Sensitive data handling considered (encryption, access controls where required)
- No secrets stored in plain text in the repository
- Auditing/traceability considered for sensitive operations (where required)
