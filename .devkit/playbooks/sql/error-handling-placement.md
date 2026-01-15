# Error handling placement playbook (SQL Server)

## Scope
Guidance for where to place error handling and how to structure TRY...CATCH decisions.

## When to use
- When deciding between boundary-centric handling and layered error handling.
- When designing TRY...CATCH patterns with transaction ownership.

## When not to use
- Do not treat TRY...CATCH as catching compile-time errors or connection-terminating errors.

## Guidance
- R1: Boundary-centric error handling is the preferred baseline framing for OLTP services; inner procedures typically roll back local work (if they own it) and rethrow.
- R2: Layered TRY...CATCH with local compensation is mainly appropriate for administrative or batch workflows, with higher complexity and ownership risks.
- P2: Avoid layering error handlers such that transaction ownership becomes ambiguous.
- D1: Layered handling is allowed where the code’s purpose is administrative or batch maintenance and is intentionally designed for such patterns.
- D1 (XACT_STATE): Use @@TRANCOUNT checks alongside XACT_STATE when the intent is "do I have any active transaction scope?" rather than committable-state decisions.
- R3 (TRY...CATCH): Prefer THROW in new code for raising errors and for rethrowing the current exception while preserving error information.
- R4 (TRY...CATCH): RAISERROR is retained for backward compatibility and does not consistently honor XACT_ABORT; its batch-continuation behavior depends on severity and options.
- P3 (TRY...CATCH): Avoid RAISERROR in new code where THROW behavior is required.
- D1 (TRY...CATCH): Using RAISERROR is allowed when backward compatibility requirements or specific RAISERROR behaviors are required.
- R3 (XACT_ABORT): Where documented as required (for example, certain OLE DB or distributed transaction scenarios), set XACT_ABORT ON for data modification unless the provider supports nested transactions.
- D1 (XACT_ABORT): Leaving XACT_ABORT OFF is allowed when the design intentionally relies on statement-level rollback behavior and explicitly manages transaction state.

## Pitfalls
- Assuming TRY...CATCH catches every error and always allows cleanup.
- Mixing ownership boundaries without a clear rollback/commit decision.

## Cross-references
- contracts/sql/try-catch.md
- contracts/sql/xact-state.md
- contracts/sql/xact-abort.md
- how-to/sql/try-catch-transaction-pattern.md
- how-to/sql/xact-state-catch-decision.md
