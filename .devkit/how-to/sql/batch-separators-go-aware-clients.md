# Batch separators in GO-aware clients (SQL Server)

## When to use this
Use when authoring or executing SQL scripts through tools that recognise the GO batch separator (for example VS Code, SSMS, Azure Data Studio, sqlcmd).

## Steps
1) Identify whether the execution path recognises GO as a batch separator.
2) Insert GO where batch boundaries are required (for example, before statements that must be first in their batch).
3) Ensure any statements preceding a first-in-batch statement are placed in a separate batch.

## Evidence to capture (what to record in PR / review)
- Tool or execution path used to run the script.
- Location of GO separators relative to first-in-batch statements.
- Confirmation that execution path recognises GO.

## Examples
Valid:
USE MyDatabase;
SET NOCOUNT ON;
GO
CREATE OR ALTER PROCEDURE dbo.P AS SELECT 1;

Invalid:
USE MyDatabase;
CREATE OR ALTER PROCEDURE dbo.P AS SELECT 1;

## Cross-references
- contracts/sql/statement-batches.md

