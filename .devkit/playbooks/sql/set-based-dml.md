# SQL Server set-based DML playbook

## Scope

Covers preference for set-based DML over row-by-row processing.

## When to use

- None.

## Guidance

### Guidance (mapped to relevant R#)

- Set-based UPDATE or DELETE with JOINs SHOULD be preferred over cursors or row-by-row loops.
- Row-by-row loops or cursors SHOULD be avoided for operations that can be expressed as set-based DML.

## Trade-offs and pitfalls

- Row-by-row processing is often slower and harder to reason about for correctness.
- Set-based statements may need careful join conditions to avoid unintended changes.

## Examples

### Examples (good vs bad)

Good:
UPDATE t
SET Status = 'Closed'
FROM dbo.Tasks t
INNER JOIN dbo.TaskArchive a ON a.TaskId = t.TaskId;
Bad:
DECLARE c CURSOR FOR SELECT TaskId FROM dbo.Tasks;

## Cross-references

- .devkit/how-to/sql/row-by-row-exceptions.md
