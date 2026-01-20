# CTE recursion safety (SQL Server)

## When to use this
Use when a recursive CTE is required and recursion depth must be bounded or proven safe.

## Steps
1) Define the anchor member first and validate base cases.
2) Add MAXRECURSION when recursion depth is not provably bounded.
3) If omitting MAXRECURSION, document the structural proof of bounded recursion.

## Evidence to capture (what to record in PR / review)
- Anchor and recursive member logic description.
- MAXRECURSION value or proof of bounded recursion.
- Query test showing expected depth.

## Examples
Good:
WITH cte AS (SELECT ... UNION ALL SELECT ...)
SELECT * FROM cte OPTION (MAXRECURSION 100);
Bad:
WITH cte AS (SELECT ... UNION ALL SELECT ...)
SELECT * FROM cte;

## Cross-references
- .devkit/contracts/sql/cte.md
- .devkit/playbooks/sql/pagination-stability.md
