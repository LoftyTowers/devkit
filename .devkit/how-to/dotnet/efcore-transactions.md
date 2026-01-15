# EF Core transactions

## Multi-step atomic workflow (single database)
1) Start a transaction with `DbContext.Database.BeginTransaction()`.
2) Execute multiple operations and call `SaveChanges` as needed.
3) Commit the transaction when all steps succeed.
4) Roll back on failure.

## Multi-resource coordination
1) Use `TransactionScope` only when coordinating multiple connections/resources.
2) Enable async flow (`TransactionScopeAsyncFlowOption.Enabled`).
3) Keep the scope tight and dispose it reliably.

## Do not mix strategies
- Use either `BeginTransaction` or `TransactionScope` in a single unit of work, not both.
