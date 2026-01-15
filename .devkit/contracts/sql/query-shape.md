# SQL Server query shape contract

## Scope
Applies to SELECT projection choices that affect client-facing correctness and stability.

## Rules (R#)
- None. See playbook guidance for projection practices.

## Prohibited patterns (P#)
- P1: MUST NOT use SELECT * in production queries that feed application clients.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/query-shape.md
- .devkit/how-to/sql/diagnostic-queries.md
