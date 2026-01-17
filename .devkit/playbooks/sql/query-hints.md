# SQL Server query hints playbook

## Scope
Covers hint usage, plan stability, and related correctness risks.

## Guidance (mapped to relevant R#)
- NOLOCK (READ UNCOMMITTED) SHOULD be avoided for transactional queries and MAY be used only for non-critical reporting.
- The RECOMPILE hint SHOULD be used only for queries with highly variable cardinality per execution.
- OPTIMIZE FOR MAY be used when a common parameter value is known, with stated risks if parameters vary.
- The FORCESEEK hint SHOULD be used only when the optimiser incorrectly chooses a scan, validated with plan analysis.
- PSP (SQL 2022+, compat level 160+) SHOULD be treated as an automatic mitigation for eligible parameter sniffing scenarios and SHOULD NOT be claimed as universally applicable.
- NOT IN with a subquery SHOULD be treated as correctness-risky when NULLs may be present, and NOT EXISTS or filtered subqueries SHOULD be preferred.
- Queries SHOULD avoid implicit type conversions in JOIN and WHERE predicates, and implicit conversions SHOULD be identified in execution plans.
- @@ROWCOUNT alone MAY be used when only the total affected rows across all MERGE actions is sufficient.

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
- .devkit/playbooks/sql/isolation-levels.md
- .devkit/contracts/sql/type-correctness.md
- .devkit/contracts/sql/subquery-semantics.md
- .devkit/contracts/sql/merge.md
- .devkit/how-to/sql/plan-verification.md
- .devkit/how-to/sql/exists-in-join-selection.md
