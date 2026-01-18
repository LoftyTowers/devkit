# SQL Server relationships contract

## Scope

- None.

## Rules

### Foreign keys

- Foreign key column data types MUST match the referenced column data type exactly.
- A FOREIGN KEY MAY reference a PRIMARY KEY or a UNIQUE constraint.
- SQL Server does NOT automatically create an index on FOREIGN KEY column(s); designs MUST NOT assume one exists.
- A composite FOREIGN KEY MUST have the same number of columns as the referenced constraint, with matching data types in order.

## Prohibited patterns

- Foreign keys MUST NOT be defined with mismatched data types.
- SQL Server MUST NOT be assumed to auto-index FOREIGN KEY columns.

## Allowed deviations

### Deviations

- FOREIGN KEY targets MAY be UNIQUE constraints.

## Cross-references

- None.
