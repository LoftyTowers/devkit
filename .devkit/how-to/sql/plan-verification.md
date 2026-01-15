# Plan verification (SQL Server)

## When to use this
Use when a query uses functions on indexed columns or relies on hints and you must verify plan impact.

## Steps
1) Capture the estimated and actual execution plans.
2) Verify index seeks are still used where required.
3) Record any accepted scan behavior and justify the trade-off.

## Evidence to capture (what to record in PR / review)
- Execution plan screenshots or extracted plan XML.
- Notes on index usage and why the plan is acceptable.
- Link to test results or workload samples used for verification.

## Examples
Good:
-- Capture actual plan and confirm seeks on indexed columns
Bad:
-- Assume the optimizer will handle function-wrapped predicates

## Cross-references
- .devkit/contracts/sql/sargability.md
- .devkit/playbooks/sql/sargability.md
- .devkit/playbooks/sql/query-hints.md
