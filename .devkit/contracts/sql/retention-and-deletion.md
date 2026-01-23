# SQL Server retention and deletion contract

## Scope

Defines enforceable requirements for erasure and deletion semantics.

### Notes

- Soft delete is logical retention, not erasure.

## Rules

- If irreversible erasure is required, physical deletion MUST be used rather than soft delete.

## Prohibited patterns

- Soft delete MUST NOT be treated as equivalent to erasure.
- Soft delete MUST NOT be treated as equivalent to an audit trail.
- Anonymisation MUST NOT be conflated with pseudonymisation.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/retention-and-deletion.md
