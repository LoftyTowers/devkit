# Temporal tables contract (SQL Server)

## Scope
Defines enforceable constraints for system-versioned temporal tables.

## Rules (R#)
- Temporal-table operational constraints MUST be respected, including restrictions on modifying history while SYSTEM_VERSIONING is ON and documented enabling requirements.

## Prohibited patterns (P#)
- History data MUST NOT be modified directly while SYSTEM_VERSIONING is ON.

## Allowed deviations (D#)
- None.

## Notes
- Temporal tables require primary key and period columns and enforce history constraints.

## Cross-references
- .devkit/playbooks/sql/temporal-tables.md
