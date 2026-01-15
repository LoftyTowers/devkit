# Row-versioning operational impacts playbook (SQL Server)

## Scope
Guidance for operational implications of row-versioning isolation.

## When to use
- When enabling ALLOW_SNAPSHOT_ISOLATION or READ_COMMITTED_SNAPSHOT.
- When assessing tempdb and version store impacts.

## When not to use
- Do not present row-versioning as a free performance improvement.

## Guidance
- R3: Long-running snapshot or versioned transactions keep versions alive longer, which can drive version store growth and read failures if space is exhausted.
- R4: Row-versioning is a concurrency trade-off with storage and IO impact, not free performance.
- P1: Enabling RCSI or SNAPSHOT while assuming no storage or version-store impact is prohibited.
- P2: Treating SNAPSHOT as just faster reads without accounting for update conflicts and version retention is prohibited.
- D1: Choosing locking-based isolation is allowed when operational constraints limit version-store use.

## Pitfalls
- Ignoring version store growth.
- Assuming row-versioning removes all concurrency trade-offs.

## Cross-references
- contracts/sql/isolation-and-nolock.md
- playbooks/sql/isolation-levels.md
