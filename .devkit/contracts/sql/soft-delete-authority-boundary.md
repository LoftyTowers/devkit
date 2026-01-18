# Soft delete authority boundary contract (SQL Server)

## Scope

Defines enforceable authority boundaries for soft delete guidance.

### Notes

- Soft delete remains a local design choice with no Tier 1 mandated pattern.

## Rules

### Rules (R#)

- DevKit MUST NOT present any specific soft delete pattern as vendor-mandated or universally preferred.

## Prohibited patterns

### Prohibited patterns (P#)

- Soft delete MUST NOT be claimed to be always better than hard delete as an authoritative rule.
- A single soft delete pattern MUST NOT be encoded as mandatory solely on the basis of vendor authority.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/soft-delete.md
