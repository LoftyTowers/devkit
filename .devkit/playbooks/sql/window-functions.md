# SQL Server window functions playbook

## Scope

Covers ROW_NUMBER ordering determinism for pagination and ordering-sensitive queries.

## When to use

- None.

## Guidance

### Guidance (mapped to relevant R#)

- When using ROW_NUMBER() for pagination or any order-sensitive operation, ORDER BY SHOULD be unique to ensure deterministic results.
- ROW_NUMBER() with a non-unique ORDER BY SHOULD NOT be used when deterministic paging is required.

## Trade-offs and pitfalls

- Non-unique ORDER BY can cause unstable paging when ties exist.
- Adding a unique tie-breaker improves determinism but may change result expectations.

## Examples

### Examples (good vs bad)

Good:
ROW_NUMBER() OVER (ORDER BY CreatedAt DESC, OrderId DESC)
Bad:
ROW_NUMBER() OVER (ORDER BY CreatedAt DESC)

## Cross-references

- .devkit/contracts/sql/order-determinism.md
- .devkit/how-to/sql/determinism-and-ties.md
