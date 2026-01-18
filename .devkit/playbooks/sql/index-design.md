# SQL Server index design playbook

## Scope

Guidance below uses SHOULD language and describes engine behavior. These are not mandates.

## When to use

- None.

## Guidance

### Clustered index keys

- Clustered index keys SHOULD be narrow, unique, immutable, NOT NULL, and fixed-width; because the clustered key is replicated into nonclustered indexes, wider keys increase storage and IO.
- Insert-heavy tables SHOULD use ever-increasing clustered keys to reduce page splits and fragmentation.
- When a clustered key is not unique, SQL Server adds a 4-byte uniqueifier.
- INT or BIGINT with IDENTITY aligns with the desirable clustered key properties.
- uniqueidentifier clustered keys trade off width and non-sequential inserts; NEWSEQUENTIALID() can improve sequentiality but values remain 16 bytes.
- Random GUIDs SHOULD be avoided as clustered keys in insert-heavy tables that require ever-increasing behavior.
- Frequently updating clustered key values SHOULD be avoided.

### Index design and maintenance

- Many indexes add DML overhead because all indexes must be updated.
- Over-indexing heavily updated tables SHOULD be avoided; every additional index increases INSERT/UPDATE/DELETE work and contention risk.
- Nonclustered indexes SHOULD be created on columns frequently used in predicates and joins.
- Unnecessary columns SHOULD be avoided in indexes.
- Index usage SHOULD be monitored and unused indexes SHOULD be removed over time.

### Composite keys and ordering

- Index sort order (ASC/DESC) SHOULD match frequent ORDER BY patterns to reduce or avoid explicit sorts.

### Covering indexes

- INCLUDE columns SHOULD be used to cover SELECT-list columns needed for results but not used for WHERE, JOIN, or ORDER BY logic.
- For frequently used queries, covering indexes SHOULD be preferred to avoid lookups, acknowledging space and write trade-offs.

### Filtered indexes

- Filtered indexes SHOULD be used where queries match the filter (for example, many NULLs with IS NOT NULL queries, workflow or status subsets, or soft-delete rows).
- When complex predicates are required, indexed views MAY be considered as a conceptual workaround.

### Index count anti-patterns

- Excessive nonclustered indexes on heavily updated tables SHOULD be avoided without workload-driven need; the reason SHOULD be documented when adding many indexes.

## Allowed deviations

### Deviations

- Heaps MAY be used for staging or ETL, bulk load and truncate workflows, or scan-intended cases; the scenario SHOULD be stated explicitly.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
