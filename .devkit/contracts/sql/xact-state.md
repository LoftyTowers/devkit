# XACT_STATE usage (SQL Server contract)

## Scope

Defines enforceable rules for transaction state checks inside error handling paths.

## Rules

- XACT_STATE() MUST be used inside CATCH to distinguish between a committable transaction (1), no transaction (0), and an uncommittable transaction (-1).
- When XACT_STATE() returns -1, the transaction MUST be treated as uncommittable and MUST only be rolled back.
- @@TRANCOUNT MUST be treated as indicating whether a user transaction is active and its nesting depth, and MUST NOT be used to determine whether a transaction is committable or uncommittable.

## Prohibited patterns

- @@TRANCOUNT MUST NOT be used alone to decide between COMMIT and ROLLBACK inside CATCH.
- COMMIT MUST NOT be attempted when no corresponding BEGIN TRANSACTION exists.

## Allowed deviations

- None.

## Cross-references

- playbooks/sql/error-handling-placement.md
- how-to/sql/xact-state-catch-decision.md
