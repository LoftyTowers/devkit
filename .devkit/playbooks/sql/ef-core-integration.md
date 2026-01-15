# EF Core integration playbook (SQL Server artefacts)

## Scope
Guidance for SQL artefacts only when EF Core consumes results from this SQL artefact or stored procedure.

## When to use
- Only when EF Core maps results from raw SQL, views, functions, or stored procedures.

## Default guidance
- P1: Changing stored procedure result-set column names or shapes without considering EF Core's documented mapping requirements is prohibited.

## Anti-patterns
- P1: Modifying result set shapes without validating EF Core mappings.

## Examples/pitfalls
Good:
- Review EF Core mapping expectations before altering result set shapes.
Bad:
- Rename a result column without updating EF Core mapping.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/how-to/sql/ef-core-result-shape-contracts.md
- .devkit/how-to/sql/ef-core-stored-procedure-conventions.md
