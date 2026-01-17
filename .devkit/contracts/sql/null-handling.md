# SQL Server NULL handling contract

## NULL semantics
- NULL comparisons MUST use IS NULL or IS NOT NULL.

## Prohibited patterns
- NULL comparisons MUST NOT use = NULL or != NULL.
