# XACT_STATE decision flow (SQL Server)

## When to use this
Use inside CATCH blocks to decide whether rollback is required and whether a transaction is committable.

## Steps
1) Check XACT_STATE() to determine committable vs uncommittable.
2) If XACT_STATE() = -1, rollback only.
3) If XACT_STATE() = 1, decide whether to commit or rollback based on ownership.
4) Use @@TRANCOUNT only to detect active scope, not committable state.

## Evidence to capture (what to record in PR / review)
- XACT_STATE outcome and decision path.
- Whether the procedure owns the transaction.

## Examples
Good:
IF XACT_STATE() = -1
    ROLLBACK TRANSACTION;
ELSE IF XACT_STATE() = 1
    -- commit or rollback based on ownership

Bad:
IF @@TRANCOUNT > 0
    COMMIT TRANSACTION; -- ignoring committable state

## Cross-references
- contracts/sql/xact-state.md
- playbooks/sql/error-handling-placement.md
