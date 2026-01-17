# SQL Server pagination stability playbook

## Scope
Covers pagination safety, ordering, and stability under concurrency.

## Guidance (mapped to relevant R#)
- For stable pagination across concurrent data changes, SNAPSHOT or SERIALIZABLE isolation SHOULD be used together with a unique ORDER BY, and only when stability is required and validated.
- Recursive CTE usage SHOULD include an explicit MAXRECURSION safeguard to prevent infinite recursion.

## Trade-offs and pitfalls
- Stronger isolation improves stability but can increase contention.
- MAXRECURSION limits prevent runaway queries but can truncate results if set too low.

## Examples (good vs bad)
Good:
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
SELECT ... ORDER BY CreatedAt DESC, OrderId DESC OFFSET 0 ROWS FETCH NEXT 50 ROWS ONLY;
Bad:
SELECT ... ORDER BY CreatedAt DESC OFFSET 0 ROWS FETCH NEXT 50 ROWS ONLY;

## Cross-references
- .devkit/contracts/sql/pagination.md
- .devkit/contracts/sql/cte.md
- .devkit/how-to/sql/cte-recursion-safety.md
