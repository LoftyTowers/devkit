# SQL Server MERGE contract

## Scope
Applies to MERGE rowcount correctness expectations.

## Rules (R#)
- R1: When using MERGE and action-specific affected row counts are required, use the MERGE OUTPUT clause rather than relying on @@ROWCOUNT alone.

## Prohibited patterns (P#)
- P1: Using @@ROWCOUNT alone to infer per-action counts where action-level correctness matters is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-hints.md
