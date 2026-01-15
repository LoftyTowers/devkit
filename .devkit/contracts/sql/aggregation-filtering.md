# SQL Server aggregation filtering contract

## Scope
Applies to HAVING usage for non-aggregate predicates.

## Rules (R#)
- None. See playbook guidance for correct filtering placement.

## Prohibited patterns (P#)
- P1: Using HAVING for non-aggregate filters that should be applied before GROUP BY is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/aggregation.md
