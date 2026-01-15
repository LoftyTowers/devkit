# SQL Server constraints playbook

- UNIQUE constraints allow one NULL per column (unlike PRIMARY KEY).
- UNIQUE constraints create a unique nonclustered index automatically unless CLUSTERED is specified.
- Use a UNIQUE constraint to express a business rule in the logical model; use a unique index when options like filtering or INCLUDE columns are needed.
- CHECK constraints evaluate to TRUE or FALSE; NULL evaluates to UNKNOWN and passes unless explicitly handled.
- DEFAULT constraints apply on INSERT when no value is provided.
- DEFAULT constraints SHOULD be explicitly named.
- Columns that must always have a value SHOULD be defined as NOT NULL.
- Before adding a constraint, ensure existing data satisfies the constraint conditions (for example, validate or remediate violations before applying).
- Before adding NOT NULL to an existing column, update existing NULL values to non-NULL (for example, backfill defaults prior to altering).

See also: .devkit/how-to/sql/filtered-unique-indexes.md
