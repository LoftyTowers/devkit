# Cross-database ownership chaining contract (SQL Server)

## Scope

Defines enforceable rules for cross-database ownership chaining.

### Notes

- Treat cross-database chaining as a security boundary requiring review.

## Rules

### Rules (R#)

- Cross-database ownership chaining MUST NOT be enabled unless there is explicit justification and documentation.

## Prohibited patterns

### Prohibited patterns (P#)

- Cross-database ownership chaining MUST NOT be enabled as a convenience shortcut without explicit justification.

## Allowed deviations

### Allowed deviations (D#)

- Cross-database ownership chaining MAY be enabled only if there is explicit justification and documentation.

## Cross-references

- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
