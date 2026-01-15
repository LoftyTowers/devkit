# SQL Server set operators contract

## Scope
Applies to UNION/UNION ALL/INTERSECT/EXCEPT query correctness.

## Rules (R#)
- R2: Set-operator queries MUST have equal column count and compatible data types.
- R3: ORDER BY in set-operator queries MUST be placed only at the end of the final query.

## Prohibited patterns (P#)
- P2: Using set operators with mismatched column counts or incompatible types is prohibited.
- P3: Placing ORDER BY inside intermediate branches of a set-operator query is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/set-operators.md
