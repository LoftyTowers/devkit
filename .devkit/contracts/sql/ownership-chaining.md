# SQL Server ownership chaining contract

## Scope
Defines enforceable ownership chaining requirements for procedures and views.

## Rules (R#)
- Ownership chaining requires the procedure or view and the underlying table to share the same owner.

## Prohibited patterns (P#)
- None.

## Allowed deviations (D#)
- None.

## Notes
- If ownership cannot be unified, explicit permissions must be considered.

## Cross-references
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
