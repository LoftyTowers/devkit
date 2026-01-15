# Triggers contract (SQL Server)

## Scope
Defines enforceable trigger semantics and correctness requirements.

## Rules (R#)
- R1: Triggers MUST be designed understanding they execute inside the firing transaction and hold locks; keep short and fast to minimize blocking.
- R3: Triggers MUST be correct under multi-row DML by using set-based logic over inserted and deleted pseudo-tables.

## Prohibited patterns (P#)
- P3: Writing row-by-row trigger logic that assumes single-row inserted or deleted semantics.

## Allowed deviations (D#)
- None.

## Notes
- Trigger logic must be set-based and transaction-aware.

## Cross-references
- .devkit/playbooks/sql/triggers.md
