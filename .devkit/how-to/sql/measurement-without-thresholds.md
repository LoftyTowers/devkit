# Measurement without thresholds (SQL Server)

## When to use this
Use when performance choices are optimizer-dependent and cannot be reduced to numeric thresholds.

## Steps
1) Compare alternatives using execution plans and measured timings.
2) Record trade-offs without asserting numeric cut-offs.
3) Document the decision criteria as workload-specific.

## Evidence to capture (what to record in PR / review)
- Plan comparisons or metrics.
- Explicit statement that no thresholds were used.
- Rationale tied to observed workload behavior.

## Examples
Good:
-- "Chose EXISTS based on plan and correctness; no row-count thresholds used"
Bad:
-- "Use EXISTS when rows > 1000"

## Cross-references
- .devkit/contracts/sql/authority-boundaries.md
