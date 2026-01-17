# Cross-database ownership chaining contract (SQL Server)

## Scope
Defines enforceable rules for cross-database ownership chaining.

## Rules (R#)
- Cross-database ownership chaining MUST NOT be enabled unless there is explicit justification and documentation.

## Prohibited patterns (P#)
- Cross-database ownership chaining MUST NOT be enabled as a convenience shortcut without explicit justification.

## Allowed deviations (D#)
- Cross-database ownership chaining MAY be enabled only if there is explicit justification and documentation.

## Notes
- Treat cross-database chaining as a security boundary requiring review.

## Cross-references
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
