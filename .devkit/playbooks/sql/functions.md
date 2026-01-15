# Functions playbook (SQL Server)

## Scope
Guidance for choosing between inline TVFs, multi-statement TVFs, and scalar UDFs.

## When to use
- When implementing composable query logic or performance-critical calculations.

## Default guidance
- R1: For performance-critical logic, inline TVFs SHOULD be preferred over scalar UDFs and multi-statement TVFs.
- R2: When exposing composable query logic to callers (including EF Core only when it consumes results), inline TVFs or views SHOULD be used rather than multi-statement TVFs.
- R4: Scalar UDFs SHOULD be treated as a last resort in hot paths; do not rely on inlining alone as the performance strategy.

## Anti-patterns
- P1: Designing hot-path query logic around scalar UDFs on the assumption that inlining will always make them performant.
- P2: Using multi-statement TVFs for composable or performance-critical query logic without profiling evidence of acceptable behavior.

## Examples/pitfalls
Good:
- Use an inline TVF for reusable filtering logic in hot paths.
Bad:
- Use a scalar UDF in a hot path and assume inlining will always apply.

## Deviations/Exceptions
- D1: Scalar UDF use is not prohibited; the caution is about assuming inlining and hot-path reliance.

## Cross-references
- .devkit/contracts/sql/scalar-udf-inlining.md
