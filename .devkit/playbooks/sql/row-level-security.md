# SQL Server row-level security playbook

## Scope

Guidance for RLS behavior and design constraints.

## When to use

- This guidance SHOULD be applied when evaluating or implementing Row-Level Security.

## Guidance

### Default guidance

- Filter predicates silently filter rows for read and certain write operations.
- Block predicates prevent write operations that violate the predicate and fail with an error.
- Designs SHOULD account for bypass behavior for principals with CONTROL (including db_owner or sysadmin).
- Designs SHOULD account for compatibility limitations and edge cases (for example, indexed views, CDC leakage, cross-database joins not enforced).
- Designs SHOULD account for side-channel or inference risks and mitigation direction (restrict ad hoc query permissions and prefer procedures or views).

### Anti-patterns

- Treating RLS as the only authorization layer.

## Allowed deviations

### Deviations/Exceptions

- None explicitly identified.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- RLS SHOULD be used with procedures or views to limit ad hoc access.
Bad:
- RLS alone SHOULD NOT be assumed to provide complete authorization.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/row-level-security.md
