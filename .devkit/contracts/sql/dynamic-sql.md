# SQL Server dynamic SQL contract

## Scope
Applies to dynamic SQL that can include user input.

## Rules (R#)
- R1: Dynamic SQL that includes user input MUST use sp_executesql with explicit parameters rather than concatenating input into SQL text.
- R2: EXEC(@sql) with concatenated user input MUST NOT be used.

## Prohibited patterns (P#)
- P1: Concatenating user input into dynamic SQL strings is prohibited.
- P2: Executing concatenated SQL with EXEC(@sql) where user input can influence the query is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/how-to/sql/dynamic-sql-safe-forms.md
