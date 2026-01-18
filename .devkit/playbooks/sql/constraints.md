# SQL Server constraints playbook

## Scope

- UNIQUE constraints allow one NULL per column (unlike PRIMARY KEY).
- UNIQUE constraints create a unique nonclustered index automatically unless CLUSTERED is specified.
- A UNIQUE constraint SHOULD be used to express a business rule in the logical model; a unique index SHOULD be used when options such as filtering or INCLUDE columns are needed.
- CHECK constraints evaluate to TRUE or FALSE; NULL evaluates to UNKNOWN and passes unless explicitly handled.
- DEFAULT constraints apply on INSERT when no value is provided.
- DEFAULT constraints SHOULD be explicitly named.
- Columns that must always have a value SHOULD be defined as NOT NULL.
- Before adding a constraint, existing data SHOULD be validated to ensure it satisfies the constraint conditions (for example, remediate violations before applying).
- Before adding NOT NULL to an existing column, existing NULL values SHOULD be updated to non-NULL (for example, backfilling defaults prior to altering).

See also: .devkit/how-to/sql/filtered-unique-indexes.md

## When to use

- None.

## Guidance

- None.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
