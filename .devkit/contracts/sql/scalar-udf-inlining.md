# Scalar UDF inlining contract (SQL Server)

## Scope

Defines enforceable constraints for scalar UDF inlining assumptions.

### Notes

- Treat inlining eligibility as conditional and documented, not guaranteed.

## Rules

- Scalar UDF inlining MUST NOT be assumed to apply universally; applicability depends on documented eligibility constraints and can be disabled or blocked.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/functions.md
