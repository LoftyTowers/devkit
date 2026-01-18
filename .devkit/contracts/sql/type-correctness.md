# SQL Server type correctness contract

## Scope

Applies to JOIN and WHERE predicate type alignment to avoid implicit conversions.

## Rules

### Rules (R#)

- None. See playbook guidance for type alignment practices.

## Prohibited patterns

### Prohibited patterns (P#)

- Columns and literals or parameters MUST NOT be compared or joined using mismatched data types where an implicit conversion would be introduced.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/query-hints.md
- .devkit/how-to/sql/type-alignment.md
