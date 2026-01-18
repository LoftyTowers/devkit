# SQL Server ownership chaining contract

## Scope

Defines enforceable ownership chaining requirements for procedures and views.

### Notes

- If ownership cannot be unified, explicit permissions must be considered.

## Rules

### Rules (R#)

- Ownership chaining requires the procedure or view and the underlying table to share the same owner.

## Prohibited patterns

### Prohibited patterns (P#)

- None.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
