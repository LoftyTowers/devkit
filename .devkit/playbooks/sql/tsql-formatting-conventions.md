# Tsql formatting conventions

## Scope
Non-enforceable guidance for consistent, review-friendly T-SQL formatting.

## When to use
Use when establishing or applying consistent formatting in SQL scripts and migrations.

## Guidance
- Column lists in `SELECT` statements SHOULD use leading commas.
- Column lists in `INSERT` and `VALUES` blocks SHOULD use leading commas.
- When a statement requires a leading terminator for safety (for example CTEs), scripts SHOULD use a leading terminator form such as `;WITH`.
- If a multi-line statement is edited frequently, leading separators (commas/terminators) SHOULD be used to reduce diff noise and make changes clearer.

## Trade-offs and pitfalls
- Leading commas can be unfamiliar to some reviewers; agree the convention across the repo.
- Over-formatting can reduce readability if lines become too fragmented.

## Examples
Preferred:
- `SELECT`
  - `  Id`
  - `, Name`
  - `, Email`
  - `FROM dbo.Users;`

Also preferred for CTE safety:
- `;WITH cte AS (...) SELECT ...;`

## Cross-references
- .devkit/contracts/sql/statement-termination.md
- .devkit/how-to/sql/statement-termination-patterns.md