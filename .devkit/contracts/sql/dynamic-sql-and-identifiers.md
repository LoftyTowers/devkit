# Dynamic SQL and identifiers contract (SQL Server)

## Scope
Defines enforceable rules for parameter usage and identifier substitution.

## Rules (R#)
- Stored procedure parameters MUST NOT be used to substitute object identifiers (for example, table or column names); parameters MUST be used only for constant expressions.

## Prohibited patterns (P#)
- Object names MUST NOT be parameterized as if parameters can replace identifiers (for example, FROM @TableName).

## Allowed deviations (D#)
- None.

## Notes
- Identifier substitution requires dynamic SQL with controlled construction, not parameters.

## Cross-references
- .devkit/playbooks/sql/stored-procedures-calls.md
