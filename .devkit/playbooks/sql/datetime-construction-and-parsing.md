# Datetime construction and parsing

## Scope
Guidance for choosing between deterministic datetime construction and string parsing based on the source of the value.

## When to use
Use when writing scripts that create deterministic timestamps, or when parsing timestamps received as strings.

## Guidance
- Use `DATETIME2FROMPARTS` when you need deterministic script values (migrations, verification scripts, fixtures).
- Use `CONVERT(datetime2(n), <iso string>, 126)` when you are parsing an ISO 8601 timestamp that arrives as text.
- Use `TRY_CONVERT` or `TRY_CAST` when you must not throw on invalid input and you want to handle invalid values explicitly.
- If a tool or execution context rejects an inline `DATETIME2FROMPARTS(...)` expression, you SHOULD assign it to a variable first and then use the variable.

## Trade-offs and pitfalls
- Parsing strings can fail due to unexpected formats; explicit ISO + style reduces this risk.
- `TRY_CONVERT` can hide bad data if you do not explicitly check for `NULL` afterwards.
- Inline use of `DATETIME2FROMPARTS` can be harder to debug in some tooling; variables can make failures clearer.

## Examples
Deterministic construction:
- `DECLARE @dt datetime2(0) = DATETIME2FROMPARTS(2026, 1, 5, 0, 0, 0, 0, 0);`

ISO parsing:
- `DECLARE @dt datetime2(0) = CONVERT(datetime2(0), '2026-01-05T00:00:00', 126);`

Non-throwing parse + explicit failure:
- `DECLARE @dt datetime2(0) = TRY_CONVERT(datetime2(0), @input, 126);`
- `IF @dt IS NULL THROW 51000, 'Invalid datetime input (expected ISO 8601).', 1;`

## Cross-references
- .devkit/contracts/sql/datetime-types-and-literals.md
- .devkit/how-to/sql/datetime-literal-construction.md
- .devkit/how-to/sql/datetime-parsing-iso8601.md