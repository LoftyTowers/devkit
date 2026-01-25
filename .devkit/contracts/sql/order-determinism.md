# SQL Server order determinism contract

## Scope

Applies to TOP usage when result order matters.

## Rules

- Queries using TOP MUST specify ORDER BY when result order matters; without ORDER BY, result order is undefined.

## Prohibited patterns

- TOP MUST NOT be used without ORDER BY where the consumer expects a stable result order.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/window-functions.md
- .devkit/how-to/sql/determinism-and-ties.md
