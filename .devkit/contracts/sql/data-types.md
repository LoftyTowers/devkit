# SQL Server data types contract

## Data type consistency
- R4: The same logical attribute MUST use the same data type across all tables.
- R5: Schemas MUST avoid deprecated TEXT, NTEXT, IMAGE data types; use VARCHAR(MAX), NVARCHAR(MAX), VARBINARY(MAX).

## Prohibited patterns
- P1: Using TEXT, NTEXT, or IMAGE is prohibited.
- P2: Defining the same attribute with different data types across tables is prohibited.
