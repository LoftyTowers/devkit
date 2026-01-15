# Transaction ownership playbook (SQL Server)

## Scope
Guidance for caller-owned vs procedure-owned transactions, nesting, and savepoints.

## When to use
- When stored procedures can be called both standalone and inside an outer transaction.
- When defining savepoint usage patterns.

## When not to use
- Do not use as a replacement for enforceable transaction semantics in contracts.

## Guidance
- R3: When an inner stored procedure is invoked under an existing outer transaction, avoid unconditionally committing or rolling back the outer transaction; use savepoints or signal failure to the caller.
- R4: If a stored procedure is designed to own its transaction when called standalone, start and commit that transaction only when no caller transaction is active (checked via @@TRANCOUNT).
- D1: Procedure-owned transactions are allowed where the system is intentionally T-SQL-centric and transaction ownership is documented and consistent.

## Pitfalls
- Hidden commits or rollbacks that break caller-owned transaction semantics.
- Savepoint usage that is not coordinated with caller expectations.

## Cross-references
- contracts/sql/transactions-ownership.md
