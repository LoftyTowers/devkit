# Views playbook (SQL Server)

## Scope
Guidance for views as logical read surfaces and security abstractions.

## When to use
- When encapsulating read logic or exposing a stable read surface.
- When mediating access to base tables through a controlled interface.

## Default guidance
- R1: Views SHOULD be treated as logical read abstractions (stored SELECT definitions), not as inherent performance features.

## Anti-patterns
- P1: Assuming non-indexed views inherently improve query performance.

## Examples/pitfalls
See .devkit/playbooks/sql/permissions-and-ownership-chaining.md for view-permissions examples.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
