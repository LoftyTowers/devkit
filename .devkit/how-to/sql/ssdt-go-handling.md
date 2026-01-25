# SSDT GO handling (SQL Server)

## When to use this
Use when working with SSDT database projects and generated build or deployment scripts.

## Steps
1) Author scripts using GO where batch boundaries are required.
2) Allow SSDT to interpret and split batches during build and deployment.
3) Validate generated scripts during build output if troubleshooting is required.

## Evidence to capture (what to record in PR / review)
- SSDT project build output.
- Generated deployment script excerpts showing batch separation.

## Cross-references
- contracts/sql/statement-batches.md

