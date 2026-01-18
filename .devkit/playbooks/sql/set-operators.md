# SQL Server set operators playbook

## Scope

Covers UNION/UNION ALL selection and intent clarity.

## When to use

- None.

## Guidance

### Guidance (mapped to relevant R#)

- UNION ALL SHOULD be used when deduplication is not required, and UNION SHOULD be used only when deduplication is required.
- UNION SHOULD be avoided when deduplication is not required, because it introduces unnecessary sort or aggregate work.
- UNION MAY be used when business logic requires de-duplicated results.

## Trade-offs and pitfalls

- UNION incurs extra work to remove duplicates; UNION ALL preserves row counts.
- Misusing UNION can hide data quality problems or change expected counts.

## Examples

### Examples (good vs bad)

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
