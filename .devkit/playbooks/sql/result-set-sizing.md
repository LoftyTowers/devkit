# SQL Server result set sizing playbook

## Scope
Covers result set sizing for user-facing queries.

## Guidance (mapped to relevant R#)
- R2: Queries returning user-facing data SHOULD limit result set size (TOP or OFFSET/FETCH) to avoid unbounded results.

## Trade-offs and pitfalls
- Unbounded queries can exhaust resources and create poor user experiences.
- Size limits must align with product expectations and paging behavior.

## Examples (good vs bad)
Good:
SELECT TOP (50) OrderId, Status FROM dbo.Orders ORDER BY CreatedAt DESC;
Bad:
SELECT OrderId, Status FROM dbo.Orders;

## Cross-references
- .devkit/contracts/sql/result-set-sizing.md
- .devkit/how-to/sql/exports-and-bulk-reads.md
