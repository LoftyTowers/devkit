# SQL Server set operators playbook

## Scope
Covers UNION/UNION ALL selection and intent clarity.

## Guidance (mapped to relevant R#)
- R1: Use UNION ALL when deduplication is not required; use UNION only when deduplication is required.
- P1: Using UNION when deduplication is not required is discouraged because of unnecessary sort/aggregate work.
- D1: UNION (deduplication) is explicitly allowed when business logic requires de-duplicated results.

## Trade-offs and pitfalls
- UNION incurs extra work to remove duplicates; UNION ALL preserves row counts.
- Misusing UNION can hide data quality problems or change expected counts.

## Examples (good vs bad)
Good:
SELECT Col1 FROM T1
UNION ALL
SELECT Col1 FROM T2;
Bad:
SELECT Col1 FROM T1
UNION
SELECT Col1 FROM T2; -- when duplicates are acceptable

## Cross-references
- .devkit/contracts/sql/set-operators.md
