# SQL Server retention and deletion contract

## Scope
Defines enforceable requirements for erasure and deletion semantics.

## Rules (R#)
- G-RET-R3: If irreversible erasure is required, physical deletion MUST be used rather than soft delete.

## Prohibited patterns (P#)
- G-RET-P1: Treating soft delete as equivalent to erasure.
- G-RET-P2: Treating soft delete as equivalent to an audit trail.
- G-RET-P3: Conflating anonymisation with pseudonymisation.

## Allowed deviations (D#)
- None.

## Notes
- Soft delete is logical retention, not erasure.

## Cross-references
- .devkit/playbooks/sql/retention-and-deletion.md
