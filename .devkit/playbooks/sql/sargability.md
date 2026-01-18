# SQL Server sargability playbook

## Scope

Covers predicate forms that preserve index usage.

## When to use

- None.

## Guidance

### Guidance (mapped to relevant R#)

- Queries SHOULD avoid applying functions to indexed columns in WHERE, JOIN, or ORDER BY predicates.
- Queries SHOULD avoid wrapping indexed columns in ISNULL or COALESCE in WHERE predicates, and IS NULL or IS NOT NULL SHOULD be preferred where applicable.

## Trade-offs and pitfalls

- Function-wrapped predicates often force scans instead of seeks.
- Coalescing indexed columns in predicates hides NULL semantics and can invalidate index use.

## Examples

### Examples (good vs bad)

Good:
WHERE OrderDate >= @StartDate AND OrderDate < @EndDate
Bad:
WHERE DATEADD(day, 0, OrderDate) = @Date

## Cross-references

- .devkit/contracts/sql/sargability.md
- .devkit/how-to/sql/plan-verification.md
