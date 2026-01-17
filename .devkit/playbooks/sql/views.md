# Views playbook (SQL Server)

## Scope
Guidance for views as logical read surfaces and security abstractions.

## When to use
- This guidance SHOULD be applied when encapsulating read logic or exposing a stable read surface.
- This guidance SHOULD be applied when mediating access to base tables through a controlled interface.

## Default guidance
- Views SHOULD be treated as logical read abstractions (stored SELECT definitions), not as inherent performance features.

## Anti-patterns
- Non-indexed views SHOULD NOT be assumed to inherently improve query performance.

## Examples/pitfalls
See .devkit/playbooks/sql/permissions-and-ownership-chaining.md for view-permissions examples.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
