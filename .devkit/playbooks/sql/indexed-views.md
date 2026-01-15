# Indexed views playbook (SQL Server)

## Scope
Guidance for evaluating indexed view use and write-path impact.

## When to use
- When considering indexed views for read performance under strict requirements.

## Default guidance
- R2: Before relying on an indexed view in production, the DML overhead on participating base tables MUST be evaluated and tested under realistic workloads.

## Anti-patterns
- P2: Introducing indexed views without testing write-path impact.

## Examples/pitfalls
Good:
- Test write paths under realistic load before deploying indexed views.
Bad:
- Assume indexed views are safe without measuring DML impact.

## Deviations/Exceptions
- D1: Use indexed views only when requirements are met and need is proven.

## Cross-references
- .devkit/contracts/sql/indexed-views.md
