# Scalar UDF inlining contract (SQL Server)

## Scope
Defines enforceable constraints for scalar UDF inlining assumptions.

## Rules (R#)
- Scalar UDF inlining MUST NOT be assumed to apply universally; applicability depends on documented eligibility constraints and can be disabled or blocked.

## Prohibited patterns (P#)
- None.

## Allowed deviations (D#)
- None.

## Notes
- Treat inlining eligibility as conditional and documented, not guaranteed.

## Cross-references
- .devkit/playbooks/sql/functions.md
