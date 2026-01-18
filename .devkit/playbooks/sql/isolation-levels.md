# SQL Server isolation levels playbook

## Scope

Covers isolation choices for paging stability and reporting.

## When to use

- None.

## Guidance

### Guidance (mapped to relevant R#)

- Where stable multi-page reads are required under concurrent modifications, SNAPSHOT or SERIALIZABLE isolation SHOULD be used.
- READ UNCOMMITTED (including via NOLOCK) SHOULD be limited to non-critical reporting.
- READ COMMITTED MAY be used for general OLTP where paging stability guarantees are not required.
- The lowest isolation level SHOULD be chosen that meets business consistency requirements, recognizing the trade-off between anomalies and blocking or resource usage.
- READ UNCOMMITTED or NOLOCK MAY be used only when documented anomalies are explicitly accepted as a consistency trade-off.
- Higher isolation levels (REPEATABLE READ or SERIALIZABLE) MAY be used when business invariants require them and contention is acceptable.

## Trade-offs and pitfalls

- SNAPSHOT and SERIALIZABLE reduce anomalies but increase contention and tempdb usage.
- READ UNCOMMITTED can return inconsistent or missing data.

## Examples

### Examples (good vs bad)

Good:
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
SELECT ... ORDER BY CreatedAt DESC, OrderId DESC;
Bad:
SELECT ... FROM dbo.Orders WITH (NOLOCK);

## Cross-references

- .devkit/contracts/sql/isolation-and-nolock.md
