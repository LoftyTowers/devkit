# Cross-database ownership chaining contract (SQL Server)

## Scope
Defines enforceable rules for cross-database ownership chaining.

## Rules (R#)
- R2: Cross-database ownership chaining MUST NOT be enabled unless there is explicit justification and documentation.

## Prohibited patterns (P#)
- P2: Enabling cross-database ownership chaining as a convenience shortcut without explicit justification.

## Allowed deviations (D#)
- D1: Cross-database ownership chaining can be enabled only with explicit justification and documentation.

## Notes
- Treat cross-database chaining as a security boundary requiring review.

## Cross-references
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
