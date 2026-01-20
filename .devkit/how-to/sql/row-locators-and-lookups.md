# Row locators and lookups (SQL Server)

## When to use this
Use when explaining how nonclustered indexes locate rows in heaps and clustered tables.

## Steps
1) Identify whether the table is a heap or has a clustered index.
2) Explain the row locator used by nonclustered indexes (RID for heaps, clustered key for clustered tables).
3) Describe how key or RID lookups occur and why locator width affects IO.

## Evidence to capture (what to record in PR / review)
- Table access path (heap vs clustered).
- Locator type used by nonclustered indexes.
- Note on lookup cost implications if locator width is large.

## Examples
Heaps:
Nonclustered index entries include an RID locator to find rows in the heap.
Clustered tables:
Nonclustered index entries include the clustered key as the locator.

## Cross-references
- .devkit/contracts/sql/indexing-and-access-paths.md
- .devkit/playbooks/sql/index-design.md
