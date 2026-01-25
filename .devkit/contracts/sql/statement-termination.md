# Statement termination

## Scope
Authoritative engine rules for Transact-SQL statement termination semantics and engine-required semicolon usage.

## Rules
- `;` MUST be treated as a Transact-SQL statement terminator that terminates statements, not arbitrary lines.
- Termination requirements MUST be applied to T-SQL statements (`sql_statement` units), not to control-of-flow delimiters.
- A `statement_block` MUST be treated as a grouping of one or more statements delimited by BEGIN…END.
- BEGIN and END MUST be treated as statement block delimiters, not standalone statements that require their own terminator.
- A MERGE statement MUST be terminated by a semicolon (`;`).
- When a statement begins with WITH (common table expression, xmlnamespaces clause, or change tracking context clause) and is not the first statement in a batch, the immediately preceding statement MUST be terminated with a semicolon (`;`).
- WITH (common table expression) MUST be treated as a clause embedded into a following single statement (SELECT, INSERT, UPDATE, MERGE, DELETE, or defining SELECT for CREATE VIEW), not as a standalone statement.
- If THROW is not the first statement in its batch or statement block, the immediately preceding statement MUST be terminated with a semicolon (`;`).
- If SEND is not the first statement in a batch or stored procedure, the immediately preceding statement MUST be terminated with a semicolon (`;`).
- If MOVE CONVERSATION is not the first statement in a batch or stored procedure, the immediately preceding statement MUST be terminated with a semicolon (`;`).

## Prohibited patterns
- Treating BEGIN or END as standalone statements that must be terminated with `;`.
- Applying “semicolon on every line” as a proxy for statement termination.
- Writing MERGE without a terminating semicolon.
- Using WITH (common table expression, xmlnamespaces clause, or change tracking context clause) not first in batch where the immediately preceding statement is not terminated with `;`.
- Writing THROW not first in batch/block where the immediately preceding statement is not terminated with `;`.
- Writing SEND not first in batch/procedure where the immediately preceding statement is not terminated with `;`.
- Writing MOVE CONVERSATION not first in batch/procedure where the immediately preceding statement is not terminated with `;`.

## Allowed deviations
- Semicolons MAY be omitted for statements where SQL Server does not currently require them, except where an engine-required rule in this contract applies.
- Teams MAY choose a stricter local convention (for example, always terminate statements with `;`) as a house style; this is distinct from engine-required rules.

## Cross-references
- .devkit/contracts/sql/try-catch-structure.md
- .devkit/contracts/sql/statement-batches.md
- .devkit/playbooks/sql/tsql-formatting-conventions.md