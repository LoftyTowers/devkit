# Indexed views playbook (SQL Server)

## Scope

Guidance for evaluating indexed view use and write-path impact.

## When to use

- This guidance SHOULD be applied when considering indexed views for read performance under strict requirements.

## Guidance

### Default guidance

- Before relying on an indexed view in production, the DML overhead on participating base tables SHOULD be evaluated and tested under realistic workloads.

### Anti-patterns

- Indexed views SHOULD NOT be introduced without testing write-path impact.

## Allowed deviations

### Deviations/Exceptions

- Indexed views MAY be used only when requirements are met and the need is proven.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- Write paths SHOULD be tested under realistic load before deploying indexed views.
Bad:
- Indexed views SHOULD NOT be assumed to be safe without measuring DML impact.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/indexed-views.md
