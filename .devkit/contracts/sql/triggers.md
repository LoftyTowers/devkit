# Triggers contract (SQL Server)

## Scope

Defines enforceable trigger semantics and correctness requirements.

### Notes

- Trigger logic must be set-based and transaction-aware.

## Rules

### Rules (R#)

- Triggers MUST be designed with the understanding that they execute inside the firing transaction and hold locks.
- Triggers MUST be correct under multi-row DML by using set-based logic over the inserted and deleted pseudo-tables.

## Prohibited patterns

### Prohibited patterns (P#)

- Row-by-row trigger logic that assumes single-row inserted or deleted semantics MUST NOT be used.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/triggers.md
