# SQL Server query hints playbook

## Scope
Covers hint usage, plan stability, and related correctness risks.

## Guidance (mapped to relevant R#)
- R1: NOLOCK (READ UNCOMMITTED) SHOULD be avoided for transactional queries; it may be used only for non-critical reporting.
- R2: RECOMPILE hint SHOULD be used only for queries with highly variable cardinality per execution.
- R3: OPTIMIZE FOR may be used when a common parameter value is known, with stated risks if parameters vary.
- R4: FORCESEEK hint SHOULD be used only when the optimiser incorrectly chooses a scan, validated with plan analysis.
- R5: PSP (SQL 2022+, compat level 160+) is an automatic mitigation for eligible parameter sniffing scenarios; do not claim universal applicability.
- R1 (subquery): NOT IN with a subquery SHOULD be treated as correctness-risky when NULLs may be present; prefer NOT EXISTS or filtered subqueries.
- R1 (type correctness): Queries SHOULD avoid implicit type conversions in JOIN and WHERE predicates; spot implicit conversions in execution plans.
- D1 (MERGE): @@ROWCOUNT alone is allowed when only the total affected rows across all MERGE actions is sufficient.

## Trade-offs and pitfalls
- Hints can lock in bad plans and must be validated against real workload behavior.
- Implicit conversions can force scans and alter comparison semantics.
- NOT IN with NULLs can eliminate expected rows.

## Examples (good vs bad)
Good:
EXEC sp_executesql @sql, N'@Status int', @Status = @Status;
Bad:
EXEC(@sql + @Status);

## Cross-references
- .devkit/contracts/sql/isolation-and-nolock.md
- .devkit/contracts/sql/type-correctness.md
- .devkit/contracts/sql/subquery-semantics.md
- .devkit/contracts/sql/merge.md
- .devkit/how-to/sql/plan-verification.md
- .devkit/how-to/sql/exists-in-join-selection.md
