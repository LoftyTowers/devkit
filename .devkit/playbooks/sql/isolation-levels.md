# SQL Server isolation levels playbook

## Scope
Covers isolation choices for paging stability and reporting.

## Guidance (mapped to relevant R#)
- R1: Where stable multi-page reads are required under concurrent modifications, SNAPSHOT or SERIALIZABLE isolation SHOULD be used.
- R2: READ UNCOMMITTED (including via NOLOCK) SHOULD be limited to non-critical reporting.
- D1: READ COMMITTED is allowed for general OLTP where paging stability guarantees are not required.

## Trade-offs and pitfalls
- SNAPSHOT and SERIALIZABLE reduce anomalies but increase contention and tempdb usage.
- READ UNCOMMITTED can return inconsistent or missing data.

## Examples (good vs bad)
Good:
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
SELECT ... ORDER BY CreatedAt DESC, OrderId DESC;
Bad:
SELECT ... FROM dbo.Orders WITH (NOLOCK);

## Cross-references
- .devkit/contracts/sql/isolation-and-nolock.md
