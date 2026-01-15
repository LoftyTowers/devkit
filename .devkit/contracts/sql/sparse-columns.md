# SQL Server sparse columns contract

## Sparse columns
- R2: A sparse column MUST be nullable and MUST NOT have ROWGUIDCOL or IDENTITY properties.
- R3: Sparse columns MUST NOT be of disallowed types and MUST NOT use FILESTREAM.
- R4: Sparse columns MUST NOT be part of a clustered index or unique PRIMARY KEY index.
- R5: Sparse columns MUST NOT be used as a partition key of a clustered index or heap.

## Prohibited patterns
- P2: Using sparse columns in clustered key or unique PRIMARY KEY where disallowed is prohibited.

## Deviations
- D1: Persisted computed columns defined on sparse columns MAY be used to participate in the clustered key.
