# Statement termination patterns

## When to use this
Use when writing or reviewing T-SQL scripts to ensure statement termination and CTE usage is batch-safe and unambiguous.

## Steps
1) End the current statement with `;`.
2) If the next statement begins with a CTE, write it as `;WITH ...` even if the previous line already ends with `;`.
3) Write `THROW ...;` as its own terminated statement.
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
- `SELECT 1`
- `WITH cte AS (...) SELECT ...`
- `IF @x = 1 THROW 51000, 'Message', 1`  (missing termination)

## Cross-references
- .devkit/contracts/sql/statement-termination.md
- .devkit/contracts/sql/statement-batches.md