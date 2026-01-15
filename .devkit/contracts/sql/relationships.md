# SQL Server relationships contract

## Foreign keys
- R1: Foreign key column data types MUST match the referenced column data type exactly.
- R2: A FOREIGN KEY MAY reference a PRIMARY KEY or a UNIQUE constraint.
- R4: SQL Server does NOT automatically create an index on FOREIGN KEY column(s); designs MUST NOT assume one exists.
- R6: A composite FOREIGN KEY MUST have the same number of columns as the referenced constraint, with matching data types in order.

## Prohibited patterns
- P1: Foreign keys with mismatched data types are prohibited.
- P2: Assuming SQL Server auto-indexes FOREIGN KEY columns is prohibited.

## Deviations
- D1: FOREIGN KEY targets that are UNIQUE are explicitly allowed.
