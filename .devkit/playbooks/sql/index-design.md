# SQL Server index design playbook

Guidance below uses SHOULD language and describes engine behavior. These are not mandates.

## Clustered index keys
- Clustered index keys SHOULD be narrow, unique, immutable, NOT NULL, and fixed-width.
- Insert-heavy tables SHOULD use ever-increasing clustered keys to reduce page splits and fragmentation.
- When a clustered key is not unique, SQL Server adds a 4-byte uniqueifier.
- INT or BIGINT with IDENTITY aligns with the desirable clustered key properties.
- uniqueidentifier clustered keys trade off width and non-sequential inserts; NEWSEQUENTIALID() can improve sequentiality but values remain 16 bytes.
- Avoid random GUIDs as clustered keys in insert-heavy tables that require ever-increasing behavior.
- Avoid frequently updating clustered key values.

## Index design and maintenance
- Many indexes add DML overhead because all indexes must be updated.
- Avoid over-indexing heavily updated tables.
- Create nonclustered indexes on columns frequently used in predicates and joins.
- Avoid adding unnecessary columns to indexes.
- Monitor index usage and remove unused indexes over time.
