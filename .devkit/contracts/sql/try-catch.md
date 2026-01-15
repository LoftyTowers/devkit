# TRY...CATCH and error handling (SQL Server contract)

## Scope
Defines enforceable semantics for TRY...CATCH behavior and transaction error handling.

## Rules (R#)
- R1: Treat TRY...CATCH as trapping execution errors of severity > 10 that do not terminate the connection; CATCH runs only when an error occurs in TRY.
- R2: Treat TRY...CATCH as not automatically rolling back a transaction; CATCH logic must decide whether to commit or roll back.

## Prohibited patterns (P#)
- P1: Assuming TRY...CATCH automatically rolls back the transaction on error.
- P2: Assuming TRY...CATCH will catch compile-time errors.
- P3: Assuming TRY...CATCH sees every error and can always perform cleanup (compile-time errors and connection-terminating errors are excluded).

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/error-handling-placement.md
- how-to/sql/try-catch-transaction-pattern.md
