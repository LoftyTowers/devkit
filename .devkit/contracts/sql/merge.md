# SQL Server MERGE contract

## Scope
Applies to MERGE rowcount correctness expectations.

## Rules (R#)
- R1: When using MERGE and action-specific affected row counts are required, use the MERGE OUTPUT clause rather than relying on @@ROWCOUNT alone.
- R4: MERGE ON clause MUST contain only matching criteria; avoid non-matching filters or constants there.

## Prohibited patterns (P#)
- P1: Using @@ROWCOUNT alone to infer per-action counts where action-level correctness matters is prohibited.
- P2: Prohibit non-matching filter predicates or constants in the MERGE ON clause.
- P3: MUST NOT claim Microsoft mandates HOLDLOCK for MERGE concurrency safety unless a Tier-1 source is explicitly cited in DevKit content.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-hints.md
