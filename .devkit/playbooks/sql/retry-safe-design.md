# Retry-safe design playbook (SQL Server)

## Scope
Guidance for designing retry-safe behavior for deadlocks and transient failures.

## When to use
- When determining whether retry logic is appropriate.
- When assessing idempotency requirements for retries.

## When not to use
- This guidance SHOULD NOT be used to define numeric retry counts or delays.

## Guidance
- Deadlock resolution SHOULD be treated as rolling back the deadlock victim transaction, and callers SHOULD tolerate and handle this by retrying at an appropriate boundary when safe.
- When retries are possible, designs SHOULD be idempotent to avoid duplicates or inconsistent state, especially due to commit outcome ambiguity.
- Non-idempotent operations SHOULD NOT be retried without keys, constraints, or verification to prevent duplication.
- NOLOCK SHOULD NOT be treated as a substitute for retry-safe design.
- Retries MAY be omitted when the system explicitly chooses fail-fast behavior and avoids automatic re-execution.

## Pitfalls
- Retrying without idempotency safeguards.
- Using NOLOCK to avoid retries.

## Cross-references
- contracts/sql/locking-and-deadlocks.md
- contracts/sql/isolation-and-nolock.md
