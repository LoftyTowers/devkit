# SQL Server aggregation playbook

## Scope
Covers filtering placement relative to GROUP BY and aggregate expressions.

## Guidance (mapped to relevant R#)
- R1: Use WHERE to filter rows before aggregation and HAVING to filter aggregated results.
- D1: HAVING is allowed for filters that depend on aggregate expressions.

## Trade-offs and pitfalls
- Misusing HAVING for non-aggregate filters can inflate work and produce incorrect results.

## Examples (good vs bad)
Good:
SELECT CustomerId, COUNT(*) AS OrderCount
FROM dbo.Orders
WHERE Status = 'Open'
GROUP BY CustomerId
HAVING COUNT(*) > 3;
Bad:
SELECT CustomerId, COUNT(*) AS OrderCount
FROM dbo.Orders
GROUP BY CustomerId
HAVING Status = 'Open';

## Cross-references
- .devkit/contracts/sql/aggregation-filtering.md
