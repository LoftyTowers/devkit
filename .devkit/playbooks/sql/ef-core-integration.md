# EF Core integration playbook (SQL Server artefacts)

## Scope
Guidance for SQL artefacts only when EF Core consumes results from this SQL artefact or stored procedure.

## When to use
- This guidance SHOULD be applied only when EF Core maps results from raw SQL, views, functions, or stored procedures.

## Default guidance
- Stored procedure result-set column names or shapes SHOULD NOT be changed without considering EF Core’s documented mapping requirements.

## Anti-patterns
- Result set shapes SHOULD NOT be modified without validating EF Core mappings.

## Examples/pitfalls
Good:
- EF Core mapping expectations SHOULD be reviewed before altering result set shapes.
Bad:
- Result columns SHOULD NOT be renamed without updating EF Core mappings.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/how-to/sql/ef-core-result-shape-contracts.md
- .devkit/how-to/sql/ef-core-stored-procedure-conventions.md
