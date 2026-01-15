# SQL Server data types playbook

- Integer columns SHOULD use the smallest integer type that reliably fits all possible values.
- VARCHAR stores 8-bit codepage characters; NVARCHAR stores Unicode (UCS-2). Choose based on data requirements.
- Queries SHOULD avoid VARCHAR/NVARCHAR mismatches between columns and predicates to prevent implicit conversions and index loss.
- The following types cannot be index key columns (but can be included columns): ntext, text, image, varchar(max), nvarchar(max), varbinary(max), json, vector.
- Large or special types MAY be used as included columns where appropriate.

## Cross-references
- .devkit/contracts/sql/type-correctness.md
- .devkit/how-to/sql/type-alignment.md
