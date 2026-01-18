# SQL Server aggregation filtering contract

## Scope

Applies to the use of HAVING clauses for predicates that do not depend on aggregate expressions.

## Rules

- Queries MUST NOT use HAVING to apply predicates that do not depend on aggregate expressions; such predicates MUST be applied before GROUP BY.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/aggregation.md
