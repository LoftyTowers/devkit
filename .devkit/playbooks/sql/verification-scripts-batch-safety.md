# Verification scripts batch safety playbook (SQL Server)

## Scope
Guidance for writing verification scripts that execute safely across different batch execution models.

## When to use
Use when authoring verification or diagnostic scripts intended for reuse.

## Guidance
- Scripts executed through GO-aware clients must account for variable scope reset across GO.
- Scripts executed through single-batch APIs must avoid GO entirely.
- Verification scripts should be explicit about their intended execution environment.

## Trade-offs and pitfalls
- Assuming variable persistence across batches.
- Reusing scripts across incompatible execution paths.

## Examples
- Standalone verification scripts separated by GO for SSMS or VS Code execution.

## Cross-references
- contracts/sql/statement-batches.md

