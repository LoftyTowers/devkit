# Executing scripts without GO support playbook (SQL Server)

## Scope
Guidance for executing SQL scripts through APIs or execution paths that do not recognise GO.

## When to use
Use when executing SQL through ADO.NET, JDBC, or other single-batch execution mechanisms.

## Guidance
- Scripts must not contain GO.
- Scripts must be split into executable batches using the execution mechanism provided by the API.
- First-in-batch requirements must be satisfied by execution ordering, not GO.

## Trade-offs and pitfalls
- Sending GO-delimited scripts directly to single-batch APIs will fail.
- Manual batch splitting increases operational complexity.

## Cross-references
- contracts/sql/statement-batches.md

