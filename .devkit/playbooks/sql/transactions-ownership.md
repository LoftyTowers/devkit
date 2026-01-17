# Transaction ownership playbook (SQL Server)

## Scope
Guidance for caller-owned vs procedure-owned transactions, nesting, and savepoints.

## When to use
- When stored procedures can be called both standalone and inside an outer transaction.
- When defining savepoint usage patterns.

## When not to use
- This guidance SHOULD NOT be used as a replacement for enforceable transaction semantics in contracts.

## Guidance
- When an inner stored procedure is invoked under an existing outer transaction, unconditionally committing or rolling back the outer transaction SHOULD be avoided; savepoints SHOULD be used or failure SHOULD be signalled to the caller.
- If a stored procedure is designed to own its transaction when called standalone, that transaction SHOULD be started and committed only when no caller transaction is active (checked via @@TRANCOUNT).
- Procedure-owned transactions MAY be used where the system is intentionally T-SQL-centric and transaction ownership is documented and consistent.

## Pitfalls
- Hidden commits or rollbacks that break caller-owned transaction semantics.
- Savepoint usage that is not coordinated with caller expectations.

## Cross-references
- contracts/sql/transactions-ownership.md
