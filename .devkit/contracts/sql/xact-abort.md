# XACT_ABORT behavior (SQL Server contract)

## Scope
Defines enforceable behaviors for XACT_ABORT and error propagation.

## Rules (R#)
- R1: Treat SET XACT_ABORT ON as causing any runtime error to terminate and roll back the entire transaction.
- R2: Treat XACT_ABORT as ON by default in triggers and OFF by default elsewhere.
- R4: Treat THROW as honoring XACT_ABORT and RAISERROR as not consistently honoring XACT_ABORT.

## Prohibited patterns (P#)
- P1: Assuming XACT_ABORT covers compile-time errors.
- P2: Combining XACT_ABORT ON with RAISERROR while assuming RAISERROR reliably triggers XACT_ABORT semantics.

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/error-handling-placement.md
