# Row-by-row exceptions (SQL Server)

## When to use this
Use when the operation cannot be expressed correctly as a set-based statement.

## Steps
1) Demonstrate why a set-based statement is not correct for the requirement.
2) Use the minimal row-by-row scope and guard it with batching where possible.
3) Document expected performance impact.

## Evidence to capture (what to record in PR / review)
- Reason set-based DML is not correct or feasible.
- Expected row counts and impact.
- Mitigations (batching, indexing) to reduce harm.

## Examples
Good:
-- Cursor used only for per-row external side effects
Bad:
-- Cursor used for simple updates that can be JOINed

## Cross-references
- .devkit/playbooks/sql/set-based-dml.md
