# Statement termination

## Scope
Authoritative rules for T-SQL statement termination and batch-safe statement boundaries.

## Rules
- Every T-SQL statement MUST end with `;`.
- A statement that begins with a CTE (`WITH`) MUST be preceded by a statement terminator.
- A `MERGE` statement MUST be terminated with `;`.
- A `THROW` statement MUST be a standalone statement and MUST be terminated with `;`.

## Prohibited patterns
- Omitting `;` at the end of a T-SQL statement.
- Writing a CTE beginning with `WITH` that is not preceded by a statement terminator.
- Writing a `MERGE` statement that is not terminated with `;`.
- Writing `THROW` such that it can be token-attached to a preceding statement due to missing termination.

## Allowed deviations
- None.

## Cross-references
- .devkit/how-to/sql/statement-termination-patterns.md
- .devkit/playbooks/sql/tsql-formatting-conventions.md
- .devkit/contracts/sql/statement-batches.md