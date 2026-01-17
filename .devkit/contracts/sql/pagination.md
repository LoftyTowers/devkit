# SQL Server pagination contract

## Scope
Applies to pagination patterns and correctness expectations.

## Rules (R#)
- OFFSET/FETCH pagination MUST include ORDER BY.
- Keyset or seek pagination MUST NOT be described as a native SQL Server pagination feature.

## Prohibited patterns (P#)
- SQL Server MUST NOT be claimed to provide native keyset pagination syntax.
- OFFSET pagination MUST NOT be assumed to be stable under concurrent modifications without additional consistency controls.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/pagination-stability.md
- .devkit/how-to/sql/pagination-choice.md
- .devkit/how-to/sql/keyset-pagination.md
