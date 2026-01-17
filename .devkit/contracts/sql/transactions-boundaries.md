# Transactions boundaries (SQL Server contract)

## Scope
Defines enforceable rules for transaction boundaries and modes (autocommit, explicit, implicit).

## Rules (R#)
- Treat SQL Server autocommit as the default mode where each individual statement is committed or rolled back as a unit when it completes.
- Treat an explicit transaction as beginning at BEGIN TRANSACTION and ending only when committed or rolled back.
- Treat locks and resources required for modifications as held until explicit transaction completion (commit or rollback).
- If SET IMPLICIT_TRANSACTIONS is ON, treat transactions as automatically starting after each commit or rollback for certain statements, and require explicit commit or rollback for each implicit transaction to end it.

## Prohibited patterns (P#)
- Multiple statements MUST NOT be assumed to be atomic in autocommit mode without an explicit transaction.
- Implicit transactions MUST NOT be enabled without explicit commit or rollback logic for each implicit transaction.

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/transactions-boundaries.md
