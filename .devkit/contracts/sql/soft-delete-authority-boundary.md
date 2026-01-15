# Soft delete authority boundary contract (SQL Server)

## Scope
Defines enforceable authority boundaries for soft delete guidance.

## Rules (R#)
- R1: DevKit MUST NOT present any specific soft delete pattern as vendor-mandated or universally preferred.

## Prohibited patterns (P#)
- P1: Claiming "soft delete is always better than hard delete" as an authoritative rule.
- P2: Encoding a single soft delete pattern as mandatory solely on the basis of vendor authority.

## Allowed deviations (D#)
- None.

## Notes
- Soft delete remains a local design choice with no Tier 1 mandated pattern.

## Cross-references
- .devkit/playbooks/sql/soft-delete.md
