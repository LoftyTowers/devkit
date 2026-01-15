# SQL Server subquery semantics contract

## Scope
Applies to NOT IN and NULL semantics in subquery comparisons.

## Rules (R#)
- None. See playbook guidance for safe alternatives.

## Prohibited patterns (P#)
- P1: MUST NOT use NOT IN against a nullable subquery result without explicitly addressing NULL semantics.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-hints.md
- .devkit/how-to/sql/exists-in-join-selection.md
