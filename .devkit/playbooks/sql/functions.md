# Functions playbook (SQL Server)

## Scope

Guidance for choosing between inline TVFs, multi-statement TVFs, and scalar UDFs.

## When to use

- This guidance SHOULD be applied when implementing composable query logic or performance-critical calculations.

## Guidance

### Default guidance

- For performance-critical logic, inline TVFs SHOULD be preferred over scalar UDFs and multi-statement TVFs.
- When exposing composable query logic to callers (including EF Core only when it consumes results), inline TVFs or views SHOULD be used rather than multi-statement TVFs.
- Scalar UDFs SHOULD be treated as a last resort in hot paths, and inlining alone SHOULD NOT be relied on as the performance strategy.

### Anti-patterns

- Hot-path query logic SHOULD NOT be designed around scalar UDFs on the assumption that inlining will always make them performant.
- Multi-statement TVFs SHOULD NOT be used for composable or performance-critical query logic without profiling evidence of acceptable behavior.

## Allowed deviations

### Deviations/Exceptions

- Scalar UDFs MAY be used, but caution SHOULD be exercised around assuming inlining and relying on them in hot paths.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- An inline TVF SHOULD be used for reusable filtering logic in hot paths.
Bad:
- Scalar UDFs SHOULD NOT be used in hot paths with the assumption that inlining will always apply.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/scalar-udf-inlining.md
