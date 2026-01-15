# SQL Server set-based DML playbook

## Scope
Covers preference for set-based DML over row-by-row processing.

## Guidance (mapped to relevant R#)
- R1: Prefer set-based UPDATE/DELETE with JOINs instead of cursors or row-by-row loops.
- P1: Row-by-row loops/cursors for operations that can be expressed as set-based DML are discouraged.

## Trade-offs and pitfalls
- Row-by-row processing is often slower and harder to reason about for correctness.
- Set-based statements may need careful join conditions to avoid unintended changes.

## Examples (good vs bad)
Good:
UPDATE t
SET Status = 'Closed'
FROM dbo.Tasks t
INNER JOIN dbo.TaskArchive a ON a.TaskId = t.TaskId;
Bad:
DECLARE c CURSOR FOR SELECT TaskId FROM dbo.Tasks;

## Cross-references
- .devkit/how-to/sql/row-by-row-exceptions.md
