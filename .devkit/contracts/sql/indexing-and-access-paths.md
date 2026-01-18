# Blob C – Indexing & Access Paths (SQL Server 2022)

## Scope

Defines enforceable indexing rules for SQL Server 2022 access-path correctness.

### Out of scope

Operational index maintenance, DMVs, and tuning procedures.

## Rules

### Slice 1: Clustered vs Nonclustered

- A table MUST have zero or one clustered index.
- Multiple clustered indexes MUST NOT be defined on a single table.

Cross-reference: .devkit/how-to/sql/row-locators-and-lookups.md

### Slice 2: Composite Index Design and Column Ordering

- Composite index keys MUST be ordered to support access patterns: equality predicates first, then range predicates, then sort columns; ordered by distinctness from most to least.
- Range predicate columns MUST NOT be placed before equality predicate columns when the intent is to support seeks for the equality predicates.

### Slice 3: Covering Indexes (INCLUDE) and Lookup Avoidance

- Index key columns MUST NOT exceed 16 columns or a total key size of 900 bytes.
- INCLUDE columns MUST NOT exceed 1,023 columns.
- INCLUDE columns MUST NOT be treated as key columns for seeks or range scans.
- Engine limits for key columns, key size, and INCLUDE columns MUST NOT be exceeded.

### Slice 4: Filtered Indexes (Patterns and Constraints)

- Filtered index predicates MUST use only allowed simple forms and MUST NOT use LIKE, OR, computed columns, or multi-table references.
- Disallowed constructs MUST NOT be used in filtered index predicates.

### Slice 5: Unique Indexes vs UNIQUE Constraints

- UNIQUE constraint or unique index NULL-handling behavior MUST be accounted for in design decisions.
- A UNIQUE constraint and a unique index MUST NOT both be created on the same columns.

## Prohibited patterns

### Slice 6: Indexing Anti-Patterns for Code Generation

- Duplicate or superseded indexes MUST NOT be created when an existing index supports the same leading key usage.
- Numeric selectivity thresholds MUST NOT be presented as authoritative rules; there is no Tier 1 official numeric threshold.
- Duplicate or overlapping indexes that do not add a distinct access path MUST NOT be created.
- Numeric selectivity thresholds (for example, "<30%" or "25–30%") MUST NOT be stated as authoritative requirements.

## Allowed deviations

- None.

## Cross-references

- None.
