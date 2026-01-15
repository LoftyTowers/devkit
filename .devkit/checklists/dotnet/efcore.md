# EF Core checklist

## DbContext lifetime and scope
- [ ] DbContext is registered as Scoped and not shared across requests.

## Thread safety
- [ ] DbContext instances are not used concurrently or across threads.

## DI disposal
- [ ] Injected DbContext instances are not manually disposed or wrapped in `using`.

## Query posture
- [ ] Read-only queries use no-tracking by default.
- [ ] Lazy loading is not the default; related data is loaded explicitly or via projection.

## Transactions
- [ ] Single `SaveChanges` calls are not wrapped in explicit transactions without a multi-step atomicity need.
- [ ] BeginTransaction and TransactionScope are not mixed in the same unit of work.
- [ ] When multi-step atomicity is required, see `.devkit/how-to/dotnet/efcore-transactions.md`.

## Migrations governance
- [ ] Production startup does not auto-run migrations; controlled migration process is used.
- [ ] Schema changes are represented via migrations.
- [ ] For migration workflow details, see `.devkit/playbooks/dotnet/efcore-migrations.md`.

## Concurrency
- [ ] DbUpdateConcurrencyException handling follows a documented conflict strategy.
- [ ] For concurrency token guidance, see `.devkit/playbooks/dotnet/efcore-concurrency.md`.

## Queries and performance guidance
- [ ] For query guidance and loading strategies, see `.devkit/playbooks/dotnet/efcore-queries.md`.
- [ ] For performance guidance (compiled queries, indexing, pooling), see `.devkit/playbooks/dotnet/efcore-performance.md`.
