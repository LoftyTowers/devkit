# Stored procedures contract (SQL Server)

## Scope
Defines enforceable rules for stored procedure parameter contracts.

## Rules (R#)
- R1: Stored procedure parameters MUST be declared with explicit data types and direction, and treated as part of the procedure's public contract.

## Prohibited patterns (P#)
- None.

## Allowed deviations (D#)
- None.

## Notes
- Parameters are part of the public interface and must be versioned intentionally.

## Cross-references
- .devkit/playbooks/sql/stored-procedures-calls.md
- .devkit/contracts/sql/dynamic-sql-and-identifiers.md
