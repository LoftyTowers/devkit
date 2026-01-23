## Scope
Authoritative rules governing SQL Server statement batches, batch boundaries, first-in-batch requirements, and client-side batch separator semantics.

## Rules
- A batch MUST be treated as the unit that SQL Server parses, compiles, optimises, and executes as a single execution unit.
- Compilation MUST occur before execution for a submitted batch, producing an execution plan for the batch.
- CREATE OR ALTER PROCEDURE MUST be the first statement in its batch.
- CREATE OR ALTER FUNCTION MUST be the first statement in its batch.
- CREATE OR ALTER VIEW MUST be the first statement in its batch.
- CREATE OR ALTER TRIGGER MUST be the first statement in its batch.
- CREATE OR ALTER RULE MUST be the first statement in its batch (legacy object types).
- CREATE OR ALTER DEFAULT MUST be the first statement in its batch (legacy object types).
- CREATE SCHEMA MUST be the first statement in its batch.
- No statement (including USE, SET options, or DECLARE) MUST appear before a statement that requires first-in-batch positioning.
- GO MUST be treated as a client-tool command that instructs the client to send the current batch to SQL Server.
- GO MUST NOT be used inside dynamic SQL executed via EXEC() or sp_executesql.

## Prohibited patterns
- Treating client-side batch separators (for example, GO) as if they were executed by the SQL Server engine as T-SQL.
- Prepending any statement (including USE, SET, or DECLARE) before a CREATE OR ALTER PROCEDURE, FUNCTION, VIEW, or TRIGGER in the same batch.
- Combining DROP and CREATE of a procedure in the same batch when the subsequent CREATE must be first in its batch.
- Assuming GO will be honoured when executing scripts through mechanisms that do not recognise GO.
- Including GO inside a string passed to EXEC() or sp_executesql.

## Allowed deviations
- None.

## Cross-references
- how-to/sql/batch-separators-go-aware-clients.md
- playbooks/sql/executing-scripts-without-go-support.md
- contracts/sql/validation-authority.md
