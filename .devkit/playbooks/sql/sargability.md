# SQL Server sargability playbook

## Scope
Covers predicate forms that preserve index usage.

## Guidance (mapped to relevant R#)
- R1: Queries SHOULD avoid applying functions to indexed columns in WHERE, JOIN, or ORDER BY predicates.
- R2: Queries SHOULD avoid wrapping indexed columns in ISNULL/COALESCE in WHERE predicates; prefer IS NULL / IS NOT NULL where applicable.

## Trade-offs and pitfalls
- Function-wrapped predicates often force scans instead of seeks.
- Coalescing indexed columns in predicates hides NULL semantics and can invalidate index use.

## Examples (good vs bad)
Good:
WHERE OrderDate >= @StartDate AND OrderDate < @EndDate
Bad:
WHERE DATEADD(day, 0, OrderDate) = @Date

## Cross-references
- .devkit/contracts/sql/sargability.md
- .devkit/how-to/sql/plan-verification.md
