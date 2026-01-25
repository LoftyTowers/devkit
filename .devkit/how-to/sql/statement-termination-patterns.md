# Statement termination patterns

## When to use this
Use when writing or reviewing T-SQL scripts to ensure statement termination and CTE usage is batch-safe and unambiguous.

## Steps
1) Terminate statements with `;` where required by engine rules; if using a house style, terminate all statements consistently.
2) If the next statement begins with a CTE and is not the first statement in a batch, ensure the preceding statement is terminated; write it as `;WITH ...` for clarity.
3) If THROW is not the first statement in its batch or statement block, ensure the preceding statement is terminated; `THROW ...;` may be used for house style consistency.
4) Ensure `MERGE ...;` is terminated.

## Evidence to capture (what to record in PR / review)
- Example snippet showing `;WITH` for CTE usage.
- Example snippet showing `THROW ...;` on its own line.
- Example snippet showing `MERGE ...;` terminated.

## Examples
Good:
- `SELECT 1;`
- `;WITH cte AS (SELECT 1 AS x) SELECT x FROM cte;`
- `THROW 51000, 'Message', 1;`
- `MERGE dbo.T AS t USING dbo.S AS s ON t.Id = s.Id WHEN MATCHED THEN UPDATE SET t.Val = s.Val;`

Bad:
- `SELECT 1 WITH cte AS (SELECT 1 AS x) SELECT x FROM cte;`  (missing terminator before WITH)
- `MERGE dbo.T AS t USING dbo.S AS s ON t.Id = s.Id WHEN MATCHED THEN UPDATE SET t.Val = s.Val`  (missing terminator)
- `SELECT 1 THROW 51000, 'Message', 1;`  (missing terminator before THROW)

## Cross-references
- .devkit/contracts/sql/statement-termination.md
- .devkit/contracts/sql/statement-batches.md
