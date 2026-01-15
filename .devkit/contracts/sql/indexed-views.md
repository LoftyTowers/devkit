# Indexed views contract (SQL Server)

## Scope
Defines enforceable requirements for indexed view creation.

## Rules (R#)
- R1: Indexed views MUST NOT be created unless the view definition satisfies SQL Server's documented indexed-view requirements and limitations.

## Prohibited patterns (P#)
- P1: Creating indexed views without meeting documented requirements.

## Allowed deviations (D#)
- None.

## Notes
- Use indexed views only when requirements are fully satisfied.

## Cross-references
- .devkit/playbooks/sql/indexed-views.md
