# Temporal tables contract (SQL Server)

## Scope

Defines enforceable constraints for system-versioned temporal tables.

### Notes

- Temporal tables require primary key and period columns and enforce history constraints.

## Rules

- Temporal-table operational constraints MUST be respected, including restrictions on modifying history while SYSTEM_VERSIONING is ON and documented enabling requirements.

## Prohibited patterns

- History data MUST NOT be modified directly while SYSTEM_VERSIONING is ON.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/temporal-tables.md
