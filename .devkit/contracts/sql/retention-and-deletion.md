# SQL Server retention and deletion contract

## Scope

Defines enforceable requirements for erasure and deletion semantics.

### Notes

- Soft delete is logical retention, not erasure.

## Rules

### Rules (R#)

- If irreversible erasure is required, physical deletion MUST be used rather than soft delete.

## Prohibited patterns

### Prohibited patterns (P#)

- Soft delete MUST NOT be treated as equivalent to erasure.
- Soft delete MUST NOT be treated as equivalent to an audit trail.
- Anonymisation MUST NOT be conflated with pseudonymisation.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/retention-and-deletion.md
