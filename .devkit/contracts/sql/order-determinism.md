# SQL Server order determinism contract

## Scope
Applies to TOP usage when result order matters.

## Rules (R#)
- R1: Queries using TOP MUST specify ORDER BY when result order matters; without ORDER BY, result order is undefined.

## Prohibited patterns (P#)
- P1: TOP without ORDER BY where the consumer expects a stable order is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/playbooks/sql/window-functions.md
- .devkit/how-to/sql/determinism-and-ties.md
