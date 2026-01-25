# Stored procedures contract (SQL Server)

## Scope

Defines enforceable rules for stored procedure parameter contracts.

### Notes

- Parameters are part of the public interface and must be versioned intentionally.

## Rules

- Stored procedure parameters MUST be declared with explicit data types and direction and MUST be treated as part of the procedure's public contract.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/stored-procedures-calls.md
- .devkit/contracts/sql/dynamic-sql-and-identifiers.md
