# SQL Server schema evolution playbook

- Do not rely on physical column order.
- Avoid SELECT * for schema-change safety.
- Adding columns mid-table may require a table rebuild.

## Migration naming and review
- Use descriptive migration names that communicate intent (commit-message style).
- Review each migration's operations for correctness and data-loss risk before applying.

## Production deployment strategy
- Prefer generating SQL scripts to deploy EF Core migrations to production.
- Migration bundles are an acceptable alternative when the workflow supports executable review and deployment; document constraints.
- Using migration bundles instead of SQL scripts is an allowed alternative when operational review supports it.

## Idempotent scripts and history
- Generate idempotent scripts when the last applied migration is unknown or when deploying to multiple databases.
- Use the migration-scripting how-to for idempotent script generation details.
- Treat __EFMigrationsHistory as the authoritative applied-state record for idempotency decisions.
- Warning (not asserted as Tier-1 in this blob): avoid manual edits or deletes in __EFMigrationsHistory.

## Custom SQL in migrations
- Use raw SQL in migrations for objects or operations EF Core does not manage.
- Anti-pattern: forcing EF model operations to manage untracked objects; prefer migration SQL.
- When a statement must be first or only in a batch, use the EXEC wrapper described in the migration-scripting how-to.

## Transaction handling in migrations
- Use the migration-transactions how-to when operations are incompatible with automatic transaction wrapping.

## Data-preserving transforms
- If scaffolding produces drop+add for a rename, replace it with the supported rename operation to preserve data.
- For data-preserving changes, use: add new schema element(s) -> backfill data -> remove old schema element(s).

## Backfills and large transformations
- Execute deterministic backfills as explicit migration steps when required to align data with schema.
- Consider batching large operations to reduce log growth and blocking; avoid universal numeric thresholds.
- A single large transaction is acceptable for small datasets when atomicity is required.

## Seeding
- Use UseSeeding/UseAsyncSeeding in controlled environments; keep sync and async logic aligned.
- Use HasData only for truly static, small reference data with explicit keys; document limitations.
- See the EF Core seeding how-to for patterns and examples.

## Cross-references
- .devkit/contracts/sql/query-shape.md
- .devkit/playbooks/sql/query-shape.md
- .devkit/how-to/sql/diagnostic-queries.md
- .devkit/how-to/sql/migration-scripting.md
- .devkit/how-to/sql/migration-transactions.md
- .devkit/how-to/sql/efcore-seeding.md
