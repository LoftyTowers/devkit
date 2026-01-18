# SQL Server schema evolution playbook

## Scope

## When to use

- None.

## Guidance

- Physical column order SHOULD NOT be relied on.
- SELECT * SHOULD be avoided for schema-change safety.
- Adding columns mid-table may require a table rebuild.

### Migration naming and review

- Migration names SHOULD be descriptive and communicate intent (commit-message style).
- Each migration’s operations SHOULD be reviewed for correctness and data-loss risk before applying.

### Production deployment strategy

- Generating SQL scripts SHOULD be preferred for deploying EF Core migrations to production.
- Migration bundles MAY be used as an alternative when the workflow supports executable review and deployment; constraints SHOULD be documented.
- Migration bundles MAY be used instead of SQL scripts when operational review supports it.

### Idempotent scripts and history

- Idempotent scripts SHOULD be generated when the last applied migration is unknown or when deploying to multiple databases.
- The migration-scripting how-to SHOULD be used for idempotent script generation details.
- __EFMigrationsHistory SHOULD be treated as the authoritative applied-state record for idempotency decisions.
- Manual edits or deletes in __EFMigrationsHistory SHOULD be avoided.

### Custom SQL in migrations

- Raw SQL SHOULD be used in migrations for objects or operations EF Core does not manage.
- EF model operations SHOULD NOT be forced to manage untracked objects; migration SQL SHOULD be preferred.
- When a statement must be first or only in a batch, the EXEC wrapper described in the migration-scripting how-to SHOULD be used.

### Transaction handling in migrations

- The migration-transactions how-to SHOULD be used when operations are incompatible with automatic transaction wrapping.

### Data-preserving transforms

- If scaffolding produces drop and add for a rename, it SHOULD be replaced with the supported rename operation to preserve data.
- For data-preserving changes, the sequence add new schema element(s) → backfill data → remove old schema element(s) SHOULD be used.

### Backfills and large transformations

- Deterministic backfills SHOULD be executed as explicit migration steps when required to align data with schema.
- Batching large operations SHOULD be considered to reduce log growth and blocking, and universal numeric thresholds SHOULD be avoided.
- A single large transaction MAY be used for small datasets when atomicity is required.

### Seeding

- UseSeeding or UseAsyncSeeding MAY be used in controlled environments, and sync and async logic SHOULD be kept aligned.
- HasData SHOULD be used only for truly static, small reference data with explicit keys, and limitations SHOULD be documented.
- See the EF Core seeding how-to for patterns and examples.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/query-shape.md
- .devkit/playbooks/sql/query-shape.md
- .devkit/how-to/sql/diagnostic-queries.md
- .devkit/how-to/sql/migration-scripting.md
- .devkit/how-to/sql/migration-transactions.md
- .devkit/how-to/sql/efcore-seeding.md
