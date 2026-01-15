# EF Core stored procedure conventions (SQL Server)

Only applies when EF Core consumes this SQL artefact or result.

## When to use this
Use when EF Core is configured to use stored procedures for insert, update, or delete.

## Steps
1) Review EF Core's documented stored procedure conventions for expected signatures and result shapes.
2) Ensure stored procedure parameters and outputs match those conventions.
3) Record any deviations and update EF Core configuration accordingly.

## Evidence to capture (what to record in PR / review)
- EF Core stored procedure conventions referenced.
- Confirmation of parameter names, directions, and result shapes.
- Notes on any signature changes.

## Examples
Good:
- Keep procedure signatures aligned with EF Core configuration.
Bad:
- Change output shapes without updating EF Core configuration.

## Cross-references
- .devkit/playbooks/sql/ef-core-integration.md
