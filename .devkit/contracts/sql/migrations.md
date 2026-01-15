# SQL Server migrations contract

## Scope
Defines enforceable rules for EF Core migrations and schema evolution safety.

## Scaffolding
- R1: Review each generated EF Core migration before applying it.
- R2: Treat EF Core scaffolding warnings about potential data loss as requiring explicit review and acknowledgement.
- P1: MUST NOT apply generated migrations without reviewing the operations for correctness and data-loss risk.

## Production application
- R3: Do not apply EF Core migrations programmatically at application startup in production environments.
- P1: Running migrations automatically on application startup in production is prohibited.

## Idempotent scripts
- P1: MUST NOT assume a non-idempotent script will safely run across unknown database migration states.

## Transaction handling
- P1: MUST NOT force transaction wrapping for known non-transaction-compatible operations.

## Data-preserving transformations
- P1: MUST NOT execute a destructive drop before the new schema exists and the data has been migrated or backfilled.

## Backfills batching thresholds
- P1: MUST NOT introduce universal numeric batch-size thresholds as rules unless a Tier-1 source is explicitly cited in DevKit content.

## EF Core seeding enforcement
- R2: Seeding MUST be idempotent (check-before-insert) so it can run multiple times safely.
- R3: Sync and async seeding MUST have equivalent logic when both are implemented.
- R5: MUST NOT use HasData for unsuitable scenarios (large datasets, non-deterministic data, external calls, database-generated keys, custom transformations).
- P1: Prohibit HasData for dynamic, non-deterministic, external, or database-generated-keys scenarios.
- P2: Prohibit UseSeeding or UseAsyncSeeding without idempotency checks.
