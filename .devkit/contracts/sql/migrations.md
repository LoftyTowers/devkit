# SQL Server migrations contract

## Scope

Defines enforceable rules for EF Core migrations and schema evolution safety.

## Rules

### Scaffolding

- Each generated EF Core migration MUST be reviewed before being applied.
- EF Core scaffolding warnings about potential data loss MUST receive explicit review and acknowledgement.
- Generated migrations MUST NOT be applied without reviewing the operations for correctness and data-loss risk.

### Production application

- EF Core migrations MUST NOT be applied programmatically at application startup in production environments.
- Migrations MUST NOT be run automatically on application startup in production environments.

### Idempotent scripts

- Non-idempotent scripts MUST NOT be assumed to safely run across unknown database migration states.

### Transaction handling

- Transactions MUST NOT be forced for operations known to be non-transaction-compatible.

### Data-preserving transformations

- Destructive drops MUST NOT be executed before the new schema exists and the data has been migrated or backfilled.

### Backfills batching thresholds

- Universal numeric batch-size thresholds MUST NOT be introduced as rules unless a Tier-1 source is explicitly cited in DevKit content.

### EF Core seeding enforcement

- Seeding MUST be idempotent so it can be run multiple times safely.
- Sync and async seeding MUST have equivalent logic when both are implemented.
- HasData MUST NOT be used for large datasets, non-deterministic data, external calls, database-generated keys, or custom transformations.
- HasData MUST NOT be used for dynamic, non-deterministic, external, or database-generated-keys scenarios.
- UseSeeding and UseAsyncSeeding MUST NOT be used without idempotency checks.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
