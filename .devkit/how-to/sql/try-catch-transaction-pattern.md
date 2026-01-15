# TRY...CATCH transaction pattern (SQL Server)

## When to use this
Use when you need explicit transaction control with TRY...CATCH and deterministic rollback or commit behavior.

## Steps
1) Start an explicit transaction only when required.
2) Commit on success.
3) In CATCH, use XACT_STATE to decide rollback vs rethrow.
4) Re-throw with THROW after rollback/decision logic.

## Evidence to capture (what to record in PR / review)
- Why the transaction boundary is required.
- Decision path for commit or rollback.
- Evidence that errors propagate to callers.

## Examples
Good:
BEGIN TRY
    BEGIN TRANSACTION;
    -- work
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH

Bad:
BEGIN TRY
    BEGIN TRANSACTION;
    -- work
END TRY
BEGIN CATCH
    -- assume implicit rollback
END CATCH

## Cross-references
- contracts/sql/try-catch.md
- contracts/sql/xact-state.md
- playbooks/sql/error-handling-placement.md
- how-to/sql/xact-state-catch-decision.md
