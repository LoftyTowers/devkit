# Filtered unique indexes (SQL Server)

## When to use this
Use when uniqueness applies only to a subset of rows (for example, non-NULL or a specific status).

## Steps
1) Confirm the business rule and whether it applies to all rows or a subset.
2) Account for UNIQUE constraint or index NULL-handling behavior.
3) Use a filtered unique index when uniqueness applies to a subset.

## Evidence to capture (what to record in PR / review)
- Business rule and subset definition.
- Reason a constraint alone is insufficient due to NULL-handling or subset scope.
- Filter predicate used to enforce subset uniqueness.

## Examples
Good:
CREATE UNIQUE INDEX UX_User_Email ON dbo.Users(Email) WHERE Email IS NOT NULL;
Bad:
CREATE UNIQUE INDEX UX_User_Email ON dbo.Users(Email); -- when multiple NULLs are allowed

## Cross-references
- .devkit/contracts/sql/indexing-and-access-paths.md
- .devkit/playbooks/sql/constraints.md
