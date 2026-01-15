# Transactions boundaries (SQL Server contract)

## Scope
Defines enforceable rules for transaction boundaries and modes (autocommit, explicit, implicit).

## Rules (R#)
- R1: Treat SQL Server autocommit as the default mode where each individual statement is committed or rolled back as a unit when it completes.
- R2: Treat an explicit transaction as beginning at BEGIN TRANSACTION and ending only when committed or rolled back.
- R3: Treat locks and resources required for modifications as held until explicit transaction completion (commit or rollback).
- R4: If SET IMPLICIT_TRANSACTIONS is ON, treat transactions as automatically starting after each commit or rollback for certain statements, and require explicit commit or rollback for each implicit transaction to end it.

## Prohibited patterns (P#)
- P1: Assuming multiple statements are atomic in autocommit mode without an explicit transaction.
- P2: Enabling implicit transactions without explicit commit or rollback logic for each implicit transaction.

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/transactions-boundaries.md
