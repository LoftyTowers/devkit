# Indexed views contract (SQL Server)

## Scope

Defines enforceable requirements for indexed view creation.

### Notes

- Use indexed views only when requirements are fully satisfied.

## Rules

### Rules (R#)

- Indexed views MUST NOT be created unless the view definition satisfies SQL Server's documented indexed-view requirements and limitations.

## Prohibited patterns

### Prohibited patterns (P#)

- Indexed views MUST NOT be created without meeting documented indexed-view requirements.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/indexed-views.md
