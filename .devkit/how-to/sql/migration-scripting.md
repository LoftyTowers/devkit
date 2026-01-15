# Migration scripting (EF Core)

## Scope
Step-by-step procedures for generating idempotent migration scripts and handling EXEC wrappers.

## Generate idempotent migration scripts
1) Use the EF Core idempotent script option when the last applied migration is unknown or multiple databases are targeted.
2) Generate the script with the idempotent option enabled so it guards each migration with checks.
3) Review the script output to confirm it uses the migrations history table for conditional execution.

Example (CLI):
- dotnet ef migrations script --idempotent

## EXEC wrapper for single-statement batches
1) When a SQL statement must be first or only in a batch, wrap it in EXEC to avoid batch constraints.
2) Keep the wrapped statement in a single string literal.
3) Review that the EXEC wrapper preserves required semantics.

Example:
EXEC('CREATE PROCEDURE dbo.usp_DoWork AS SELECT 1;');
