# SQL Server pagination contract

## Scope
Applies to pagination patterns and correctness expectations.

## Rules (R#)
- R1: OFFSET/FETCH pagination MUST include ORDER BY (see R2).
- R2: Keyset/seek pagination MUST NOT be described as a native SQL Server pagination feature.

## Prohibited patterns (P#)
- P1: Claiming SQL Server provides native keyset pagination syntax is prohibited.
- P2: Assuming OFFSET pagination is stable under concurrent modifications without additional consistency controls is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/pagination-stability.md
- .devkit/how-to/sql/pagination-choice.md
- .devkit/how-to/sql/keyset-pagination.md
