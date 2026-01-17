# Transaction ownership (SQL Server contract)

## Scope
Defines enforceable semantics for nested transactions, savepoints, and ownership boundaries.

## Rules (R#)
- Treat nested BEGIN TRANSACTION as increasing @@TRANCOUNT rather than creating independent transactions; only the outermost commit completes the transaction.
- Treat ROLLBACK TRANSACTION (without a savepoint name) as rolling back the entire transaction regardless of nesting depth.
- Treat SAVE TRANSACTION as creating a savepoint and ROLLBACK TRANSACTION savepoint_name as rolling back only to that point without changing @@TRANCOUNT.

## Prohibited patterns (P#)
- Inner procedures MUST NOT issue ROLLBACK statements that unintentionally abort a caller-owned outer transaction.
- Nested transactions MUST NOT be assumed to be independent; committing an inner transaction MUST NOT be treated as guaranteeing permanence if an outer transaction is rolled back.

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/transactions-ownership.md
