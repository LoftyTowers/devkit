# EF Core data access

## Scope

- EF Core DbContext lifecycle, query posture, transactions, migrations, and concurrency.

## Rules

### DbContext lifetime and scope

- DbContext MUST be registered as Scoped per request/unit-of-work, with one context instance per scope.
- Singleton or otherwise long-lived/shared DbContext across requests MUST NOT be used.

### Thread safety

- The same DbContext instance MUST NOT be used concurrently or across threads; use separate contexts for parallel work.

### DI disposal

- In DI-managed flows, injected DbContext instances MUST NOT be manually disposed or wrapped in `using`.

### Query posture

- Read-only queries MUST use no-tracking by default (e.g., `AsNoTracking` or an equivalent default).
- Lazy loading MUST NOT be the default; avoid N+1 by explicit loading strategies (Include/explicit loading/projection).

### Transactions

- A single `SaveChanges` call MUST NOT be wrapped in an explicit transaction unless there is a multi-step atomicity requirement.
- BeginTransaction and TransactionScope MUST NOT be mixed in the same unit of work.

### Migrations governance

- Automatic migrations MUST NOT run at app startup in production (no `Database.Migrate` on startup in production).
- Schema changes MUST be represented via migrations to prevent model/DB drift.

### Concurrency

- DbUpdateConcurrencyException MUST be handled with a defined conflict strategy (documented policy).

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
