# SQL Server keys contract

## Scope

- None.

## Rules

### Primary keys

- Each table MUST have a PRIMARY KEY constraint.
- A PRIMARY KEY MUST NOT exceed SQL Server limits of 32 columns or 900 bytes total key length.
- All columns that participate in a PRIMARY KEY MUST be defined as NOT NULL.

### Clustered index (contract items only)

- NEWSEQUENTIALID() MUST be used only where SQL Server allows it, as a DEFAULT constraint, and MUST NOT be application-generated.

## Prohibited patterns

- Tables MUST NOT exist without a PRIMARY KEY.
- PRIMARY KEY definitions MUST NOT exceed SQL Server limits.

## Allowed deviations

### Deviations

- A PRIMARY KEY MAY be NONCLUSTERED only if a separate clustered index exists on another column.
- A PRIMARY KEY MAY be NONCLUSTERED only if a different clustered index exists.

## Cross-references

- None.
