# SQL Server isolation and NOLOCK contract

## Scope
Applies to READ UNCOMMITTED/NOLOCK usage for correctness-critical reads.

## Rules (R#)
- None. See playbook guidance for isolation selection.

## Prohibited patterns (P#)
- P1: Using READ UNCOMMITTED (including NOLOCK) for correctness-critical reads is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-hints.md
- .devkit/playbooks/sql/isolation-levels.md
