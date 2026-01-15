# Dynamic SQL and identifiers contract (SQL Server)

## Scope
Defines enforceable rules for parameter usage and identifier substitution.

## Rules (R#)
- R3: Stored procedure parameters MUST NOT be used to substitute object identifiers (for example, table or column names); parameters are only for constant expressions.

## Prohibited patterns (P#)
- P2: Attempting to parameterize object names (for example, FROM @TableName) as if parameters can replace identifiers.

## Allowed deviations (D#)
- None.

## Notes
- Identifier substitution requires dynamic SQL with controlled construction, not parameters.

## Cross-references
- .devkit/playbooks/sql/stored-procedures-calls.md
