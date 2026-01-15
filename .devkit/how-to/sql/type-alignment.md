# Type alignment (SQL Server)

## When to use this
Use when JOIN or WHERE predicates require explicit conversion for correctness.

## Steps
1) Align parameter and column types to the same SQL type where possible.
2) If a conversion is required, apply it to literals/parameters instead of indexed columns.
3) Validate index usage and correctness with plan inspection.

## Evidence to capture (what to record in PR / review)
- Before/after type mapping notes.
- Execution plan showing conversion placement.
- Rationale for any remaining conversions.

## Examples
Good:
WHERE OrderId = CAST(@OrderIdText AS int)
Bad:
WHERE CAST(OrderId AS nvarchar(20)) = @OrderIdText

## Cross-references
- .devkit/contracts/sql/type-correctness.md
- .devkit/playbooks/sql/query-hints.md
