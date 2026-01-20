# XACT_ABORT behavior (SQL Server contract)

## Scope

Defines enforceable behaviors for XACT_ABORT and error propagation.

## Rules

### Rules (R#)

- When SET XACT_ABORT ON is in effect, any runtime error MUST terminate and roll back the entire transaction.
- XACT_ABORT MUST be treated as ON by default in triggers and OFF by default in non-trigger contexts.
- THROW MUST be treated as honoring XACT_ABORT semantics, and RAISERROR MUST NOT be treated as consistently honoring XACT_ABORT.

## Prohibited patterns

### Prohibited patterns (P#)

- XACT_ABORT MUST NOT be assumed to cover compile-time errors.
- XACT_ABORT ON MUST NOT be combined with RAISERROR while assuming RAISERROR reliably triggers XACT_ABORT semantics.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- playbooks/sql/error-handling-placement.md
