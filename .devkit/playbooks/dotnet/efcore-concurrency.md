# EF Core concurrency (guidance)

## Concurrency tokens
- Use optimistic concurrency control for entities that are updated concurrently, typically via concurrency tokens.
- Configure a clear concurrency token strategy per aggregate/entity that is subject to concurrent updates.

## Handling DbUpdateConcurrencyException
- Decide and document a conflict strategy (inform user/refresh, merge/retry, or a defined policy).
- Keep the chosen strategy consistent across similar workflows.
