# SQL Server type correctness contract

## Scope
Applies to JOIN and WHERE predicate type alignment to avoid implicit conversions.

## Rules (R#)
- None. See playbook guidance for type alignment practices.

## Prohibited patterns (P#)
- P1: MUST NOT compare/join columns and literals/parameters of mismatched types such that an implicit conversion is introduced.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-hints.md
- .devkit/how-to/sql/type-alignment.md
