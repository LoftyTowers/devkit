# SQL Server joins playbook

## Scope

Covers join syntax clarity and join logic review.

## When to use

- None.

## Guidance

### Guidance (mapped to relevant R#)

- Queries SHOULD use ANSI JOIN syntax (INNER JOIN, LEFT OUTER JOIN) in the FROM clause.
- Non-ANSI join syntax that obscures join logic and filtering SHOULD be avoided.

## Trade-offs and pitfalls

- Non-ANSI joins can hide join predicates and accidentally create cartesian products.
- ANSI joins make join intent and filtering explicit.

## Examples

### Examples (good vs bad)

Good:
SELECT o.OrderId FROM dbo.Orders o INNER JOIN dbo.Customers c ON c.CustomerId = o.CustomerId;
Bad:
SELECT o.OrderId FROM dbo.Orders o, dbo.Customers c WHERE c.CustomerId = o.CustomerId;

## Cross-references

- .devkit/contracts/sql/join-correctness.md
