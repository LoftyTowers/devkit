# EXISTS vs IN vs JOIN selection (SQL Server)

## When to use this
Use when selecting between EXISTS, IN, and JOIN based on correctness and measured performance.

## Steps
1) Identify NULL semantics and correctness requirements.
2) Compare candidate forms with execution plans under representative data.
3) Select the form based on correctness and measured plan quality, not thresholds.

## Evidence to capture (what to record in PR / review)
- Plan comparisons and key metrics.
- Correctness rationale for chosen form.
- Statement that no row-count threshold was used.

## Examples
Good:
WHERE EXISTS (SELECT 1 FROM dbo.Child c WHERE c.ParentId = p.ParentId)
Bad:
-- "Use EXISTS when N > 1000" (threshold-based rule)

## Cross-references
- .devkit/contracts/sql/authority-boundaries.md
- .devkit/contracts/sql/subquery-semantics.md
- .devkit/playbooks/sql/query-hints.md
