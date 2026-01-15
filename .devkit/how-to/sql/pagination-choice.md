# Pagination choice (SQL Server)

## When to use this
Use when deciding between OFFSET/FETCH and keyset pagination.

## Steps
1) Determine whether random page jumps are required.
2) If random access is required, prefer OFFSET/FETCH with required ordering.
3) If forward/back navigation is sufficient, consider keyset pagination.

## Evidence to capture (what to record in PR / review)
- Consumer navigation requirements.
- Selected pattern and justification.
- Confirmation of ordering and stability expectations.

## Examples
Good:
-- Random access needed, use OFFSET/FETCH with ORDER BY
Bad:
-- Random access needed, but only keyset pagination provided

## Cross-references
- .devkit/contracts/sql/pagination.md
- .devkit/playbooks/sql/pagination-stability.md
