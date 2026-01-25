# Datetime literal construction

## When to use this
Use when you need deterministic `datetime2` values in migrations, verification scripts, or test fixtures.

## Steps
1) Choose an explicit precision for the value (for example `datetime2(0)` or `datetime2(3)`).
2) Construct the value using `DATETIME2FROMPARTS`.
3) Assign the value to a variable.
4) Use the variable in `INSERT`, `UPDATE`, `WHERE`, or comparisons.

## Evidence to capture (what to record in PR / review)
- Chosen `datetime2(n)` precision and why.
- Example snippet showing `DATETIME2FROMPARTS` assigned to a variable.
- Example snippet showing the variable used in the target statement.

## Examples
- `DECLARE @dt datetime2(0) = DATETIME2FROMPARTS(2026, 1, 5, 0, 0, 0, 0, 0);`
- `INSERT INTO dbo.Events (OccurredAtUtc) VALUES (@dt);`

## Cross-references
- .devkit/contracts/sql/datetime-types-and-literals.md
- .devkit/playbooks/sql/datetime-construction-and-parsing.md