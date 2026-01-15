# SQL Server sargability contract

## Scope
Applies to predicate forms that defeat index seeks on indexed columns.

## Rules (R#)
- None. See playbook guidance for sargable patterns.

## Prohibited patterns (P#)
- P1: MUST NOT wrap an indexed column in a function (including ISNULL/COALESCE) in a way that prevents index seek usage.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/sargability.md
- .devkit/how-to/sql/plan-verification.md
