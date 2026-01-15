# Temporal tables playbook (SQL Server)

## Scope
Guidance for choosing temporal tables for audit and history needs.

## When to use
- When automatic row-level history is required and temporal constraints are acceptable.

## Default guidance
- R1: Where automatic row-level history is required and temporal-table constraints are acceptable, system-versioned temporal tables SHOULD be used instead of hand-rolled audit triggers.

## Anti-patterns
- P1: Implementing complex trigger-based auditing when temporal tables satisfy the requirement and constraints are acceptable.

## Examples/pitfalls
Good:
- Use system-versioned temporal tables for row history when constraints are acceptable.
Bad:
- Default to audit triggers when temporal tables meet requirements.

## Deviations/Exceptions
- D1: Non-temporal audit mechanisms remain possible where temporal tables do not meet required semantics or constraints.

## Cross-references
- .devkit/contracts/sql/temporal-tables.md
- .devkit/playbooks/sql/triggers.md
