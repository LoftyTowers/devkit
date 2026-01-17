# Error handling placement playbook (SQL Server)

## Scope
Guidance for where to place error handling and how to structure TRY...CATCH decisions.

## When to use
- When deciding between boundary-centric handling and layered error handling.
- When designing TRY...CATCH patterns with transaction ownership.

## When not to use
- TRY...CATCH SHOULD NOT be treated as catching compile-time errors or connection-terminating errors.

## Guidance
- Boundary-centric error handling SHOULD be the preferred baseline framing for OLTP services; inner procedures typically roll back local work (if they own it) and rethrow.
- Layered TRY...CATCH with local compensation SHOULD mainly be used for administrative or batch workflows, given the higher complexity and ownership risks.
- Layering error handlers SHOULD be avoided where transaction ownership becomes ambiguous.
- Layered handling MAY be used where the code’s purpose is administrative or batch maintenance and is intentionally designed for such patterns.
- @@TRANCOUNT checks MAY be used alongside XACT_STATE when the intent is to determine whether any transaction scope is active, rather than to make committable-state decisions.
- THROW SHOULD be preferred in new code for raising errors and for rethrowing the current exception while preserving error information.
- RAISERROR MAY be used for backward compatibility and does not consistently honor XACT_ABORT; its batch-continuation behavior depends on severity and options.
- RAISERROR SHOULD be avoided in new code where THROW behavior is required.
- RAISERROR MAY be used when backward compatibility requirements or specific RAISERROR behaviors are required.
- Where documented as required (for example, certain OLE DB or distributed transaction scenarios), XACT_ABORT SHOULD be set ON for data modification unless the provider supports nested transactions.
- XACT_ABORT MAY be left OFF when the design intentionally relies on statement-level rollback behavior and explicitly manages transaction state.

## Pitfalls
- Assuming TRY...CATCH catches every error and always allows cleanup.
- Mixing ownership boundaries without a clear rollback/commit decision.

## Cross-references
- contracts/sql/try-catch.md
- contracts/sql/xact-state.md
- contracts/sql/xact-abort.md
- how-to/sql/try-catch-transaction-pattern.md
- how-to/sql/xact-state-catch-decision.md
