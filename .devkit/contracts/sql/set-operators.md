# SQL Server set operators contract

## Scope
Applies to UNION/UNION ALL/INTERSECT/EXCEPT query correctness.

## Rules (R#)
- Set-operator queries MUST have equal column count and compatible data types.
- ORDER BY in set-operator queries MUST be placed only at the end of the final query.

## Prohibited patterns (P#)
- Set operators MUST NOT be used with mismatched column counts or incompatible data types.
- ORDER BY MUST NOT be placed inside intermediate branches of a set-operator query.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/set-operators.md
