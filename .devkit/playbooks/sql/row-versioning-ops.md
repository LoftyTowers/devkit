# Row-versioning operational impacts playbook (SQL Server)

## Scope
Guidance for operational implications of row-versioning isolation.

## When to use
- When enabling ALLOW_SNAPSHOT_ISOLATION or READ_COMMITTED_SNAPSHOT.
- When assessing tempdb and version store impacts.

## When not to use
- Row-versioning SHOULD NOT be presented as a free performance improvement.

## Guidance
- Long-running snapshot or versioned transactions SHOULD be expected to keep versions alive longer, which can drive version store growth and read failures if space is exhausted.
- Row-versioning SHOULD be treated as a concurrency trade-off with storage and IO impact, not as free performance.
- RCSI or SNAPSHOT SHOULD NOT be enabled while assuming no storage or version-store impact.
- SNAPSHOT SHOULD NOT be treated as merely faster reads without accounting for update conflicts and version retention.
- Locking-based isolation MAY be chosen when operational constraints limit version-store use.

## Pitfalls
- Ignoring version store growth.
- Assuming row-versioning removes all concurrency trade-offs.

## Cross-references
- contracts/sql/isolation-and-nolock.md
- playbooks/sql/isolation-levels.md
