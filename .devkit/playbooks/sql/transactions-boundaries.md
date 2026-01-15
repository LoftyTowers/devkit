# Transaction boundaries playbook (SQL Server)

## Scope
Guidance for choosing transaction boundaries and modes.

## When to use
- When deciding whether to wrap multiple statements in an explicit transaction.
- When considering implicit transactions or autocommit usage.

## When not to use
- Do not use as a substitute for contract rules on explicit boundaries.

## Guidance
- D1: Autocommit is allowed when business consistency does not require multi-statement atomicity.
- R1 (rowcount checks): Affected-row checks (for example, @@ROWCOUNT) are a common defensive technique but are not mandated by Tier 1 sources.
- P1 (rowcount checks): Avoid stating that all write procedures must validate @@ROWCOUNT as an authoritative requirement.
- D1 (rowcount checks): Using rowcount checks is allowed where the system chooses to validate write expectations without concurrency tokens.

## Pitfalls
- Assuming multi-statement atomicity without an explicit transaction.
- Using implicit transactions without consistent commit or rollback logic.

## Cross-references
- contracts/sql/transactions-boundaries.md
