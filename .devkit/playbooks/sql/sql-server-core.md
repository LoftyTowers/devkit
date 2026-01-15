# SQL Server core playbook

## When this applies

Use this playbook when:
- Designing or reviewing SQL Server schema for an OLTP application
- Writing or reviewing queries (T-SQL or EF-generated SQL) with performance or correctness concerns
- Investigating locking, deadlocks, timeouts, and concurrency issues
- Defining EF Core migration practices and deployment flow

## Rationale and trade-offs

This playbook exists to:
- Explain the “why” behind rules in the SQL Server contract
- Capture trade-offs where there is no single universal rule
- Provide safe defaults and escalation paths for exceptions

Guidance here may later be promoted into the contract if it becomes enforceable and consistently required.

## Examples and pitfalls

> Add examples only when you have real project evidence or sourced best practices.

### Example placeholders
- Avoiding `SELECT *` and selecting only required columns
- Index design and the cost of over-indexing
- Parameter sniffing and plan stability (when it matters)
- Deadlocks: common patterns and remediation
- EF Core migration discipline and rollout sequencing

## Review guidance

Use this playbook during reviews to ask:
- Is the query shape safe under concurrency?
- Are indexes aligned to access patterns (not guesses)?
- Are we relying on undefined behaviours or “it seems to work” patterns?
- Are migrations reversible and controlled?
- Are exceptions documented as deviations (when required)?
