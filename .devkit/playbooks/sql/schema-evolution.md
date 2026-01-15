# SQL Server schema evolution playbook

- Do not rely on physical column order.
- Avoid SELECT * for schema-change safety.
- Adding columns mid-table may require a table rebuild.
