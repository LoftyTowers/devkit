# SQL Server query shape contract

## Scope

Applies to SELECT projection choices that affect client-facing correctness and stability.

## Rules

### Rules (R#)

- None. See playbook guidance for projection practices.

## Prohibited patterns

### Prohibited patterns (P#)

- SELECT * MUST NOT be used in production queries that feed application clients.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/query-shape.md
- .devkit/how-to/sql/diagnostic-queries.md
