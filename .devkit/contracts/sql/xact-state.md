# XACT_STATE usage (SQL Server contract)

## Scope
Defines enforceable rules for transaction state checks inside error handling paths.

## Rules (R#)
- R1: Use XACT_STATE() inside CATCH to distinguish: committable transaction (1), no transaction (0), and uncommittable transaction (-1).
- R2: When XACT_STATE() is -1, treat the transaction as uncommittable and permit only rollback (not commit).
- R3: Treat @@TRANCOUNT as indicating whether a user transaction is active and nesting depth, but not whether the transaction is committable or uncommittable.

## Prohibited patterns (P#)
- P1: Using @@TRANCOUNT alone to decide commit vs rollback inside CATCH.
- P2: Attempting COMMIT when no corresponding BEGIN exists (for example, after rollback to zero).

## Allowed deviations (D#)
- None.

## Cross-references
- playbooks/sql/error-handling-placement.md
- how-to/sql/xact-state-catch-decision.md
