# Transaction ownership (SQL Server contract)

## Scope
Defines enforceable semantics for nested transactions, savepoints, and ownership boundaries.

## Rules (R#)
- R1: Treat nested BEGIN TRANSACTION as increasing @@TRANCOUNT rather than creating independent transactions; only the outermost commit completes the transaction.
- R2: Treat ROLLBACK TRANSACTION (without a savepoint name) as rolling back the entire transaction regardless of nesting depth.
- R5: Treat SAVE TRANSACTION as creating a savepoint and ROLLBACK TRANSACTION savepoint_name as rolling back only to that point without changing @@TRANCOUNT.

## Prohibited patterns (P#)
- P1: Inner procedures issuing ROLLBACK that unintentionally aborts a caller-owned outer transaction.
- P2: Assuming nested transactions are independent (for example, committing an inner "transaction" guarantees permanence despite an outer rollback).

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/transactions-ownership.md
