# SQL Server row-level security playbook

## Scope
Guidance for RLS behavior and design constraints.

## When to use
- When evaluating or implementing Row-Level Security.

## Default guidance
- G-RLS-R1: Filter predicates silently filter rows for read and certain write operations.
- G-RLS-R2: Block predicates prevent write operations that violate the predicate, failing with an error.
- G-RLS-R4: Designs must account for bypass behavior for principals with CONTROL (including db_owner or sysadmin).
- G-RLS-R5: Designs must account for compatibility limitations and edge cases (for example, indexed views, CDC leakage, cross-database joins not enforced).
- G-RLS-R6: Designs must account for side-channel or inference risks and mitigation direction (restrict ad hoc query permissions; prefer procedures or views).

## Anti-patterns
- Treating RLS as the only authorization layer.

## Examples/pitfalls
Good:
- Use RLS with procedures or views to limit ad hoc access.
Bad:
- Assume RLS alone provides complete authorization.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/row-level-security.md
