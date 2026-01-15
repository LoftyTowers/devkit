# SQL Server dynamic data masking playbook

## Scope
Guidance for DDM behavior and limitations.

## When to use
- When using DDM to reduce exposure of sensitive data.

## Default guidance
- G-DDM-R1: DDM masks query results without changing underlying data.
- G-DDM-R3: DDM should not be treated as a primary security control; pair with other controls.
- G-DDM-R4: Designs must account for limitations (updates not masked; incompatibility with Always Encrypted on the same column; type constraints).

## Anti-patterns
- Relying on DDM as the sole control for sensitive data.

## Examples/pitfalls
Good:
- Use DDM alongside encryption and access controls.
Bad:
- Assume DDM alone prevents data theft.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/dynamic-data-masking.md
