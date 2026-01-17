# SQL Server dynamic SQL contract

## Scope
Applies to dynamic SQL that can include user input.

## Rules (R#)
- Dynamic SQL that includes user input MUST use sp_executesql with explicit parameters rather than concatenating input into SQL text.
- EXEC(@sql) MUST NOT be used with concatenated user input.

## Prohibited patterns (P#)
- User input MUST NOT be concatenated into dynamic SQL strings.
- Concatenated SQL MUST NOT be executed with EXEC(@sql) when user input can influence the query.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/how-to/sql/dynamic-sql-safe-forms.md
