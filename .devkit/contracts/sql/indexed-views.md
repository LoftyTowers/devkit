# Indexed views contract (SQL Server)

## Scope

Defines enforceable requirements for indexed view creation.

### Notes

- Use indexed views only when requirements are fully satisfied.

## Rules

- Indexed views MUST NOT be created unless the view definition satisfies SQL Server's documented indexed-view requirements and limitations.

## Prohibited patterns

- Indexed views MUST NOT be created without meeting documented indexed-view requirements.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/indexed-views.md
