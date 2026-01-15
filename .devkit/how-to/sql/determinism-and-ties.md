# Determinism and ties (SQL Server)

## When to use this
Use when pagination or ordering-sensitive queries must explain tie handling.

## Steps
1) Identify whether deterministic ordering is required for consumers.
2) If ties are acceptable, document the acceptance explicitly.
3) If determinism is required, add a unique tie-breaker to ORDER BY.

## Evidence to capture (what to record in PR / review)
- Statement on whether ties are acceptable.
- ORDER BY clause with tie-breaker when required.
- Rationale for non-unique ORDER BY if used.

## Examples
Good:
ORDER BY CreatedAt DESC, OrderId DESC
Bad:
ORDER BY CreatedAt DESC -- ties not addressed

## Cross-references
- .devkit/contracts/sql/order-determinism.md
- .devkit/playbooks/sql/window-functions.md
