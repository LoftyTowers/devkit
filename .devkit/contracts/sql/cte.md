# SQL Server CTE contract

## Scope

Applies to CTE syntax and recursive CTE structure correctness.

## Rules

- CTE definitions MUST follow documented syntax: a CTE MUST immediately precede a single statement, and WITH clauses MUST NOT be nested inside the CTE definition.
- Recursive CTEs MUST place the anchor member before the recursive member.

## Prohibited patterns

- WITH clauses MUST NOT be nested inside CTE definitions.
- Recursive CTEs MUST NOT omit a base or anchor member preceding the recursive member.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/pagination-stability.md
- .devkit/how-to/sql/cte-recursion-safety.md
