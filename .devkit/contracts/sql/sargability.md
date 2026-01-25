# SQL Server sargability contract

## Scope

Applies to predicate forms that defeat index seeks on indexed columns.

## Rules

- None. See playbook guidance for sargable patterns.

## Prohibited patterns

- Indexed columns MUST NOT be wrapped in functions (including ISNULL or COALESCE) in a way that prevents index seek usage.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/sargability.md
- .devkit/how-to/sql/plan-verification.md
