# SQL Server data types contract

## Data type consistency
- The same logical attribute MUST use the same data type across all tables.
- Schemas MUST NOT use deprecated TEXT, NTEXT, or IMAGE data types.

## Prohibited patterns
- TEXT, NTEXT, and IMAGE data types MUST NOT be used.
- The same logical attribute MUST NOT be defined with different data types across tables.
