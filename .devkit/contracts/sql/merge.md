# SQL Server MERGE contract

## Scope
Applies to MERGE rowcount correctness expectations.

## Rules (R#)
- When using MERGE and action-specific affected row counts are required, the MERGE OUTPUT clause MUST be used rather than relying on @@ROWCOUNT alone.
- The MERGE ON clause MUST contain only matching criteria and MUST NOT include non-matching filter predicates or constants.

## Prohibited patterns (P#)
- @@ROWCOUNT MUST NOT be used alone to infer per-action counts where action-level correctness matters.
- Non-matching filter predicates or constants MUST NOT be used in the MERGE ON clause.
- Microsoft MUST NOT be claimed to mandate HOLDLOCK for MERGE concurrency safety unless a Tier-1 source is explicitly cited in DevKit content.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-hints.md
