# Transaction boundaries playbook (SQL Server)

## Scope
Guidance for choosing transaction boundaries and modes.

## When to use
- When deciding whether to wrap multiple statements in an explicit transaction.
- When considering implicit transactions or autocommit usage.

## When not to use
- This guidance SHOULD NOT be used as a substitute for contract rules on explicit boundaries.

## Guidance
- Autocommit MAY be used when business consistency does not require multi-statement atomicity.
- Affected-row checks (for example, @@ROWCOUNT) MAY be used as a defensive technique but are not mandated by Tier 1 sources.
- It SHOULD be avoided to state that all write procedures must validate @@ROWCOUNT as an authoritative requirement.
- Rowcount checks MAY be used where the system chooses to validate write expectations without concurrency tokens.

## Pitfalls
- Assuming multi-statement atomicity without an explicit transaction.
- Using implicit transactions without consistent commit or rollback logic.

## Cross-references
- contracts/sql/transactions-boundaries.md
