# Datetime parsing iso8601

## When to use this
Use when a timestamp arrives as text (imports, JSON text fields, parameters passed as strings).

## Steps
1) Choose the target precision (for example `datetime2(0)`).
2) Parse the ISO 8601 value using `CONVERT` with style `126`.
3) If input can be malformed and you must not throw, use `TRY_CONVERT`.
4) If you used `TRY_CONVERT`, explicitly handle `NULL` (for example, throw a domain error).

## Evidence to capture (what to record in PR / review)
- Confirmation the input format is ISO 8601.
- The style code used (`126`) and the target type (`datetime2(n)`).
- Handling behaviour for invalid input.

## Examples
Strict parse:
- `DECLARE @dt datetime2(0) = CONVERT(datetime2(0), '2026-01-05T00:00:00', 126);`

Validate then fail:
- `DECLARE @dt datetime2(0) = TRY_CONVERT(datetime2(0), @input, 126);`
- `IF @dt IS NULL THROW 51000, 'Invalid datetime input (expected ISO 8601).', 1;`

## Cross-references
- .devkit/contracts/sql/datetime-types-and-literals.md
- .devkit/playbooks/sql/datetime-construction-and-parsing.md