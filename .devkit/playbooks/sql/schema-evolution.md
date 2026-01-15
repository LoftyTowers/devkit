# SQL Server schema evolution playbook

- Do not rely on physical column order.
- Avoid SELECT * for schema-change safety.
- Adding columns mid-table may require a table rebuild.

## Cross-references
- .devkit/contracts/sql/query-shape.md
- .devkit/playbooks/sql/query-shape.md
- .devkit/how-to/sql/diagnostic-queries.md
