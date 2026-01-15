# SQL Server NULL handling contract

## NULL semantics
- R1: NULL comparisons MUST use IS NULL / IS NOT NULL.

## Prohibited patterns
- P1: Using = NULL or != NULL is prohibited.
