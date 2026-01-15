# SQL Server index design playbook

Guidance below uses SHOULD language and describes engine behavior. These are not mandates.

## Clustered index keys
- Clustered index keys SHOULD be narrow, unique, immutable, NOT NULL, and fixed-width; the clustered key is replicated into nonclustered indexes, so wider keys increase storage and IO.
- Insert-heavy tables SHOULD use ever-increasing clustered keys to reduce page splits and fragmentation.
- When a clustered key is not unique, SQL Server adds a 4-byte uniqueifier.
- INT or BIGINT with IDENTITY aligns with the desirable clustered key properties.
- uniqueidentifier clustered keys trade off width and non-sequential inserts; NEWSEQUENTIALID() can improve sequentiality but values remain 16 bytes.
- Avoid random GUIDs as clustered keys in insert-heavy tables that require ever-increasing behavior.
- Avoid frequently updating clustered key values.

## Index design and maintenance
- Many indexes add DML overhead because all indexes must be updated.
- Avoid over-indexing heavily updated tables; every additional index increases INSERT/UPDATE/DELETE work and contention risk.
- Create nonclustered indexes on columns frequently used in predicates and joins.
- Avoid adding unnecessary columns to indexes.
- Monitor index usage and remove unused indexes over time.

## Composite keys and ordering
- Index sort order (ASC/DESC) SHOULD match frequent ORDER BY patterns to reduce or avoid explicit sorts.

## Covering indexes
- INCLUDE columns SHOULD be used to cover SELECT-list columns needed for results but not used for WHERE/JOIN/ORDER BY logic.
- For frequently used queries, prefer covering indexes to avoid lookups, acknowledging space and write trade-offs.

## Filtered indexes
- Filtered indexes SHOULD be used where queries match the filter (for example, many NULLs with IS NOT NULL queries, workflow/status subsets, or soft-delete rows).
- When complex predicates are required, consider indexed views as a conceptual workaround.

## Index count anti-patterns
- Avoid excessive nonclustered indexes on heavily updated tables without workload-driven need; document the reason when adding many indexes.

## Deviations
- Heaps are allowed for staging or ETL, bulk load and truncate workflows, or scan-intended cases; state the scenario explicitly.
