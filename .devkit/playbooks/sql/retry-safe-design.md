# Retry-safe design playbook (SQL Server)

## Scope
Guidance for designing retry-safe behavior for deadlocks and transient failures.

## When to use
- When determining whether retry logic is appropriate.
- When assessing idempotency requirements for retries.

## When not to use
- Do not use to define numeric retry counts or delays.

## Guidance
- R1: Treat deadlock resolution as rolling back the deadlock victim transaction; callers must tolerate and handle this by retrying at an appropriate boundary when safe.
- R2: When retries are possible, require idempotent design to avoid duplicates or inconsistent state, especially due to commit outcome ambiguity.
- P1: Retrying non-idempotent operations without keys, constraints, or verification to prevent duplication is prohibited.
- P2: Treating NOLOCK as a substitute for retry-safe design is prohibited.
- D1: Not implementing retries is allowed when the system explicitly chooses fail-fast behavior and avoids automatic re-execution.

## Pitfalls
- Retrying without idempotency safeguards.
- Using NOLOCK to avoid retries.

## Cross-references
- contracts/sql/locking-and-deadlocks.md
- contracts/sql/isolation-and-nolock.md
