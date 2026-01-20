# Dynamic SQL safe forms (SQL Server)

## When to use this
Use when building dynamic SQL that may include user input.

## Steps
1) Use sp_executesql with explicit parameters for all user-controlled values.
2) Avoid concatenating user input into SQL text.
3) If EXEC(@sql) is used, ensure the SQL text is constant and contains no user input.

## Evidence to capture (what to record in PR / review)
- Parameter list and types.
- Statement showing user input is parameterized.
- Justification for any EXEC(@sql) usage.

## Examples
Good:
EXEC sp_executesql N'SELECT * FROM dbo.T WHERE Status = @Status', N'@Status int', @Status = @Status;
Bad:
EXEC('SELECT * FROM dbo.T WHERE Status = ' + @Status);

## Cross-references
- .devkit/contracts/sql/dynamic-sql.md
