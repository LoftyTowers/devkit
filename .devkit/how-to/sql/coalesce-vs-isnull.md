# COALESCE vs ISNULL (SQL Server)

## When to use this
Use when choosing between COALESCE and ISNULL for correctness and evaluation behavior.

## Steps
1) Determine whether ANSI behavior or multi-argument support is required.
2) Identify whether repeated evaluation of an expression would be incorrect.
3) Choose the function that matches evaluation and datatype expectations.

## Evidence to capture (what to record in PR / review)
- Expression evaluation considerations.
- Expected datatype/nullability outcomes.
- Reason for selecting COALESCE or ISNULL.

## Examples
Good:
-- Use ISNULL when single evaluation of a non-idempotent expression is required
Bad:
-- Use COALESCE on a volatile expression without considering repeated evaluation

## Cross-references
- .devkit/playbooks/sql/null-functions.md
