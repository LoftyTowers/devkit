# TRY...CATCH and error handling (SQL Server contract)

## Scope

Defines enforceable semantics for TRY...CATCH behavior and transaction error handling.

## Rules

- Treat TRY...CATCH as trapping execution errors of severity > 10 that do not terminate the connection; CATCH runs only when an error occurs in TRY.
- Treat TRY...CATCH as not automatically rolling back a transaction; CATCH logic must decide whether to commit or roll back.

## Prohibited patterns

- TRY...CATCH MUST NOT be assumed to automatically roll back the transaction on error.
- TRY...CATCH MUST NOT be assumed to catch compile-time errors.
- TRY...CATCH MUST NOT be assumed to see every error or to always be able to perform cleanup.

## Allowed deviations

- None.

## Cross-references

- playbooks/sql/error-handling-placement.md
- how-to/sql/try-catch-transaction-pattern.md
