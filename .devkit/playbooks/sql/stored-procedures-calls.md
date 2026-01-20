# Stored procedure calls playbook (SQL Server)

## Scope

Guidance for calling stored procedures safely and compatibly.

## When to use

- This guidance SHOULD be applied when invoking stored procedures from application or database code.

## Guidance

### Default guidance

- Calls to stored procedures SHOULD specify parameter names explicitly (not positional) to preserve compatibility when parameters are added or reordered.

### Anti-patterns

- Stored procedures SHOULD NOT be called positionally where it creates fragility under signature evolution.

## Allowed deviations

### Deviations/Exceptions

- None identified beyond using named parameters as the compatibility mechanism.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
EXEC dbo.usp_DoWork @ParamA = @A, @ParamB = @B;
Bad:
EXEC dbo.usp_DoWork @A, @B; -- positional

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/stored-procedures.md
- .devkit/contracts/sql/dynamic-sql-and-identifiers.md
