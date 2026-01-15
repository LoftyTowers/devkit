# Keyset pagination (SQL Server)

## When to use this
Use for forward/back navigation where random page access is not required.

## Steps
1) Identify a stable ordering key (ideally unique).
2) Implement WHERE + ORDER BY pattern for seek pagination.
3) Document that it is not a native SQL Server pagination feature.

## Evidence to capture (what to record in PR / review)
- Ordering key and comparison predicate.
- Confirmation of forward/back navigation only.
- Statement that keyset is a pattern, not native syntax.

## Examples
Good:
WHERE (CreatedAt, OrderId) < (@CreatedAt, @OrderId)
ORDER BY CreatedAt DESC, OrderId DESC
Bad:
-- Claiming SQL Server has native keyset pagination syntax

## Cross-references
- .devkit/contracts/sql/pagination.md
- .devkit/playbooks/sql/pagination-stability.md
