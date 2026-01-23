# SQL Server subquery semantics contract

## Scope

Applies to NOT IN and NULL semantics in subquery comparisons.

## Rules

- None. See playbook guidance for safe alternatives.

## Prohibited patterns

- NOT IN MUST NOT be used against a nullable subquery result without explicitly addressing NULL semantics.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/query-hints.md
- .devkit/how-to/sql/exists-in-join-selection.md
