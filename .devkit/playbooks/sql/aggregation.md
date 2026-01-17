# SQL Server aggregation playbook

## Scope
Covers filtering placement relative to GROUP BY and aggregate expressions.

## Guidance (mapped to relevant R#)
- Filtering SHOULD use WHERE to restrict rows before aggregation and HAVING to restrict aggregated results.
- HAVING MAY be used when a filter depends on aggregate expressions.

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
