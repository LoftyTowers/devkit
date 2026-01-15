# Migration transaction handling (EF Core)

## Scope
Step-by-step procedure for disabling automatic transaction wrapping when an operation is not transaction-compatible.

## Steps
1) Identify migration operations that are not compatible with transactional execution.
2) Use the migration API to suppress the transaction for that operation.
3) Keep the transaction suppression limited to the required operation and document the reason.

Example (C# migration snippet):
// Example for EF Core migration builder
migrationBuilder.Sql("<statement>", suppressTransaction: true);
