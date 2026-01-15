# SQL Server keys contract

## Primary keys
- R1: Each table MUST have a PRIMARY KEY constraint.
- R3: A PRIMARY KEY MUST NOT exceed SQL Server limits (32 columns or 900 bytes total key length).
- R4: All columns that participate in a PRIMARY KEY are NOT NULL.

## Clustered index (contract items only)
- R9: NEWSEQUENTIALID() MUST only be used where SQL Server allows it (as a DEFAULT constraint; not application-generated).

## Prohibited patterns
- P1: Tables without a PRIMARY KEY are prohibited.
- P2: PRIMARY KEY definitions that exceed SQL Server limits are prohibited.

## Deviations
- D1: PRIMARY KEY MAY be NONCLUSTERED while a separate clustered index exists on another column.
- D2: PRIMARY KEY MAY be NONCLUSTERED while a different clustered index exists.
