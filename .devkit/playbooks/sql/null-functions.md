# SQL Server NULL functions playbook

## Scope
Covers COALESCE and ISNULL semantics and correct selection.

## Guidance (mapped to relevant R#)
- R1: Use COALESCE when ANSI-compliant NULL handling is required and/or when more than two arguments are needed.
- R2: Use ISNULL when single evaluation of an expression is required.
- D1: Either function is allowed when the evaluation and datatype/nullability implications are explicitly acceptable.

## Trade-offs and pitfalls
- COALESCE can evaluate an expression more than once depending on usage.
- ISNULL can change result type/length and may not behave like ANSI COALESCE.

## Examples (good vs bad)
Good:
SELECT COALESCE(MiddleName, PreferredName, FirstName) FROM dbo.People;
Bad:
SELECT COALESCE(ExpensiveFunction(), ExpensiveFunction()) FROM dbo.T;

## Cross-references
- .devkit/how-to/sql/coalesce-vs-isnull.md
