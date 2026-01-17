# SQL Server dynamic data masking playbook

## Scope
Guidance for DDM behavior and limitations.

## When to use
- DDM SHOULD be considered when reducing exposure of sensitive data.

## Default guidance
- DDM masks query results without changing the underlying data.
- DDM SHOULD NOT be treated as a primary security control and SHOULD be paired with other controls.
- Designs SHOULD account for limitations such as updates not being masked, incompatibility with Always Encrypted on the same column, and type constraints.

## Anti-patterns
- Relying on DDM as the sole control for sensitive data.

## Examples/pitfalls
Good:
- DDM SHOULD be used alongside encryption and access controls.
Bad:
- DDM alone SHOULD NOT be assumed to prevent data theft.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/dynamic-data-masking.md
