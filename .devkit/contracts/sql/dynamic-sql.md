# SQL Server dynamic SQL contract

## Scope

Applies to dynamic SQL, including:
- dynamic SQL that can include user input
- dynamic SQL used for identifier substitution (table/column names)

### Notes

- Parameters can only represent constant expressions (values), not object identifiers.
- Identifier substitution requires dynamic SQL with controlled construction; identifiers cannot be parameterised.

## Rules

- Dynamic SQL that includes user input MUST use sp_executesql with explicit parameters rather than concatenating input into SQL text.
- EXEC(@sql) MUST NOT be used with concatenated user input.
- Stored procedure parameters MUST NOT be used to substitute object identifiers (for example, table or column names); parameters MUST be used only for constant expressions.

## Prohibited patterns

- User input MUST NOT be concatenated into dynamic SQL strings.
- Concatenated SQL MUST NOT be executed with EXEC(@sql) when user input can influence the query.
- Object names MUST NOT be parameterised as if parameters can replace identifiers (for example, FROM @TableName).

## Allowed deviations

- None.

## Cross-references

- .devkit/how-to/sql/dynamic-sql-safe-forms.md
- .devkit/playbooks/sql/stored-procedures-calls.md
