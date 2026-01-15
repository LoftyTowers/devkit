# EF Core result shape contracts (SQL Server)

Only applies when EF Core consumes this SQL artefact or result.

## When to use this
Use when EF Core maps results from raw SQL, views, functions, or stored procedures.

## Steps
1) Identify the EF Core mapping expectations for column names and shapes.
2) Ensure the SQL result set matches the mapped columns and names.
3) Record any intentional shape changes and update EF Core mappings accordingly.

## Evidence to capture (what to record in PR / review)
- Documented mapping expectations (property names and columns).
- Confirmation that the SQL result shape matches the mapping.
- Notes on any changes to result-set columns.

## Examples
Good:
- Keep column names aligned with EF Core mapped properties.
Bad:
- Rename a column returned by a stored procedure without updating EF Core mapping.

## Cross-references
- .devkit/playbooks/sql/ef-core-integration.md
