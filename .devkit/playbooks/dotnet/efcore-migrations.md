# EF Core migrations (guidance)

## Scope

- Non-enforceable guidance for EF Core migrations workflows.

## When to use

- None.

## Guidance

### Development workflow

- Create migrations for all schema changes and keep them in version control.
- Verify the model and database stay in sync during local development.

### Production workflow

- Apply migrations via reviewed and tested scripts or a controlled migration mechanism.
- Do not run automatic migrations at application startup in production.

### Drift prevention

- Avoid ad-hoc database changes outside migrations.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
