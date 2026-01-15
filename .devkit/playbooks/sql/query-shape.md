# SQL Server query shape playbook

## Scope
Covers SELECT projection discipline for application-facing queries.

## Guidance (mapped to relevant R#)
- R1: Queries SHOULD use explicit column lists in SELECT (avoid SELECT *).
- R3: Queries SHOULD project only the required columns rather than retrieving whole entities or rows when not needed.

## Trade-offs and pitfalls
- Over-selecting columns increases IO and can hide breaking changes when schemas evolve.
- SELECT * can be convenient for diagnostics but is fragile in long-lived client queries.

## Examples (good vs bad)
Good:
SELECT OrderId, Status, CreatedAt FROM dbo.Orders;
Bad:
SELECT * FROM dbo.Orders;

## Cross-references
- .devkit/contracts/sql/query-shape.md
- .devkit/how-to/sql/diagnostic-queries.md
