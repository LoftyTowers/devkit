# Scalar UDF inlining contract (SQL Server)

## Scope

Defines enforceable constraints for scalar UDF inlining assumptions.

### Notes

- Treat inlining eligibility as conditional and documented, not guaranteed.

## Rules

### Rules (R#)

- Scalar UDF inlining MUST NOT be assumed to apply universally; applicability depends on documented eligibility constraints and can be disabled or blocked.

## Prohibited patterns

### Prohibited patterns (P#)

- None.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/functions.md
