# SQL Server joins playbook

## Scope
Covers join syntax clarity and join logic review.

## Guidance (mapped to relevant R#)
- R1: Queries SHOULD use ANSI JOIN syntax (INNER JOIN, LEFT OUTER JOIN) in the FROM clause.
- P1 (style guidance): Avoid non-ANSI join syntax that obscures join logic and filtering.

## Trade-offs and pitfalls
- Non-ANSI joins can hide join predicates and accidentally create cartesian products.
- ANSI joins make join intent and filtering explicit.

## Examples (good vs bad)
Good:
SELECT o.OrderId FROM dbo.Orders o INNER JOIN dbo.Customers c ON c.CustomerId = o.CustomerId;
Bad:
SELECT o.OrderId FROM dbo.Orders o, dbo.Customers c WHERE c.CustomerId = o.CustomerId;

## Cross-references
- .devkit/contracts/sql/join-correctness.md
