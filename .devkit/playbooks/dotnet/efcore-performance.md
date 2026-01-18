# EF Core performance (guidance)

## Scope

- Non-enforceable guidance for EF Core performance practices, including compiled queries and indexing discipline.

## When to use

- None.

## Guidance

### Compiled queries

- Use compiled queries only for hot paths where profiling shows benefit.

### Indexing discipline

- Define indexes via the EF model and migrations for keys and common filters/sorts/joins.
- Validate indexing decisions with execution plans where needed.

### DbContext pooling

- Use `AddDbContextPool` only when there is measured need.
- Ensure the context remains stateless between leases or reset per-request state.
- Avoid pooling when per-request state cannot be reliably cleared.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
