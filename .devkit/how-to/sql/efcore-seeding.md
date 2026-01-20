# EF Core seeding (SQL Server)

## Scope
Step-by-step patterns for UseSeeding/UseAsyncSeeding and HasData usage.

## UseSeeding / UseAsyncSeeding outline
1) Register UseSeeding and UseAsyncSeeding in controlled environments.
2) Keep sync and async implementations aligned in logic and data.
3) Ensure each seeding path is idempotent with check-before-insert logic.

## Idempotent check-then-insert
- Check for existing rows using a stable key before insert.
- Insert only when missing.

Example pattern:
IF NOT EXISTS (SELECT 1 FROM dbo.Lookup WHERE Code = 'X')
    INSERT dbo.Lookup (Code, Name) VALUES ('X', 'Name');

## Sync/async parity
- Define a shared logical sequence and reuse constants/keys in both paths.
- Validate both paths insert the same data under the same conditions.

## HasData guidance
- Acceptable: small, truly static reference data with explicit primary keys.
- Do not use: large datasets, non-deterministic values, external calls, database-generated keys, or custom transformations.
