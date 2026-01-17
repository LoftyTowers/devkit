# SQL Server sparse columns contract

## Sparse columns
- A sparse column MUST be nullable and MUST NOT have ROWGUIDCOL or IDENTITY properties.
- Sparse columns MUST NOT be of disallowed types and MUST NOT use FILESTREAM.
- Sparse columns MUST NOT be part of a clustered index or a unique PRIMARY KEY index.
- Sparse columns MUST NOT be used as a partition key of a clustered index or heap.

## Prohibited patterns
- Sparse columns MUST NOT be used in clustered keys or unique PRIMARY KEY indexes where disallowed.

## Deviations
- Persisted computed columns defined on sparse columns MAY be used to participate in the clustered key.
