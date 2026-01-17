# Query design checklist (SQL Server)

Use this checklist during query review or performance investigations for Blob B items.

## SELECT discipline and projection
- [ ] Use explicit column lists for application-facing SELECT statements (P1).
- [ ] Project only required columns for the use case (P1).
- [ ] Limit user-facing result sets with TOP or OFFSET/FETCH (P2).

## Sargable predicates and functions
- [ ] Avoid function-wrapped predicates on indexed columns (P1).
- [ ] Avoid ISNULL/COALESCE on indexed columns in predicates unless verified safe (P1).

## Type correctness in predicates
- [ ] Align predicate types to avoid implicit conversions (P1).

## Join correctness
- [ ] Review joins for duplicate amplification when keys are not unique (R2).

## Subquery semantics
- [ ] Avoid NOT IN against nullable subqueries without NULL handling (P1).
- [ ] Do not justify EXISTS/IN/JOIN using row-count thresholds (R2, P2).

## CTE syntax and recursion safety
- [ ] Ensure CTEs precede a single statement and are not nested (R1, P1).
- [ ] Ensure recursive CTEs place the anchor member first (R2, P2).

## ORDER BY determinism
- [ ] Require ORDER BY with TOP when order matters (R1, P1).
- [ ] Require ORDER BY with OFFSET/FETCH pagination (R1, R2, P2).
- [ ] Require unique ORDER BY for deterministic ROW_NUMBER paging (R3, P3).

## Pagination strategy and stability
- [ ] Do not claim keyset pagination as a native SQL Server feature (R2, P1).
- [ ] Do not assume OFFSET/FETCH is stable under concurrent changes without controls (P2).

## Dynamic SQL safety
- [ ] Use sp_executesql with parameters for user input (R1).
- [ ] Avoid EXEC(@sql) with concatenated input (R2, P1, P2).

## Set operators
- [ ] Ensure set operators have compatible column counts and types (R2, P2).
- [ ] Place ORDER BY only at the end of the final set operator query (R3, P3).

## Aggregation filtering
- [ ] Avoid using HAVING for non-aggregate predicates (P1).

## Hints and isolation choices
- [ ] Do not use NOLOCK/READ UNCOMMITTED for correctness-critical reads (P1).

## MERGE rowcount correctness
- [ ] Use MERGE OUTPUT when per-action row counts are required (R1, P1).

## Authority boundaries
- [ ] Avoid numeric thresholds for optimizer-dependent choices (R1, P1).
- [ ] Present optimizer-dependent choices as trade-offs unless authoritative (R2, P2).
