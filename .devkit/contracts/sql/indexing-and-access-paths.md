# Blob C — Indexing & Access Paths (SQL Server 2022)

## Scope
Defines enforceable indexing rules for SQL Server 2022 access-path correctness.

## Out of scope
Operational index maintenance, DMVs, and tuning procedures.

## Slice 1: Clustered vs Nonclustered
- R1: A table MUST have zero or one clustered index.
- P1: MUST NOT attempt to define multiple clustered indexes on one table.

Cross-reference: .devkit/how-to/sql/row-locators-and-lookups.md

## Slice 2: Composite Index Design and Column Ordering
- R1: Composite index keys MUST be ordered to support access patterns: equality predicates first, then range predicates, then sort columns; order by distinctness most to least.
- P1: MUST NOT place range predicate columns before equality predicate columns when the intent is to support seeks for the equality predicates.

## Slice 3: Covering Indexes (INCLUDE) and Lookup Avoidance
- R1: Index key columns MUST NOT exceed 16 key columns or 900 bytes total key size.
- R2: INCLUDE columns MUST NOT exceed 1,023 columns.
- P1: MUST NOT treat INCLUDE columns as key columns for seeks or range scans.
- P2: MUST NOT exceed engine limits for key columns, key size, or INCLUDE columns.

## Slice 4: Filtered Indexes (Patterns and Constraints)
- R1: Filtered index predicates MUST use only allowed simple forms; MUST NOT use LIKE, OR, computed columns in the predicate, or multi-table references.
- P1: MUST NOT use disallowed constructs in filtered index predicates.

## Slice 5: Unique Indexes vs UNIQUE Constraints
- R2: UNIQUE constraint or index NULL-handling behavior MUST be accounted for in design decisions.
- P1: MUST NOT create both a UNIQUE constraint and a unique index on the same columns.

## Slice 6: Indexing Anti-Patterns for Code Generation
- R1: MUST NOT create duplicate or superseded indexes when an existing index supports the same leading key usage.
- R3: MUST NOT present numeric selectivity thresholds as authoritative rules; there is no Tier 1 official numeric threshold.
- P1: MUST NOT create duplicate or overlapping indexes that do not add a distinct access path.
- P2: MUST NOT state numeric selectivity thresholds (e.g., "<30%", "25–30%") as authoritative requirements.
