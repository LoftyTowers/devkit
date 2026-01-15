# SQL Server CTE contract

## Scope
Applies to CTE syntax and recursive CTE structure correctness.

## Rules (R#)
- R1: CTE definitions MUST follow documented syntax: a CTE must immediately precede a single statement (no nesting WITH clauses inside the CTE definition).
- R2: Recursive CTEs MUST place the anchor member before the recursive member.

## Prohibited patterns (P#)
- P1: Nesting WITH clauses in CTE definitions is prohibited.
- P2: Recursive CTEs without a base/anchor member preceding recursion is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/pagination-stability.md
- .devkit/how-to/sql/cte-recursion-safety.md
