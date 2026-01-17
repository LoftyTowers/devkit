# Temporal tables playbook (SQL Server)

## Scope
Guidance for choosing temporal tables for audit and history needs.

## When to use
- This guidance SHOULD be applied when automatic row-level history is required and temporal constraints are acceptable.

## Default guidance
- Where automatic row-level history is required and temporal-table constraints are acceptable, system-versioned temporal tables SHOULD be used instead of hand-rolled audit triggers.

## Anti-patterns
- Complex trigger-based auditing SHOULD NOT be implemented when temporal tables satisfy the requirement and constraints are acceptable.

## Examples/pitfalls
Good:
- System-versioned temporal tables SHOULD be used for row history when constraints are acceptable.
Bad:
- Audit triggers SHOULD NOT be defaulted to when temporal tables meet requirements.

## Deviations/Exceptions
- Non-temporal audit mechanisms MAY be used where temporal tables do not meet required semantics or constraints.

## Cross-references
- .devkit/contracts/sql/temporal-tables.md
- .devkit/playbooks/sql/triggers.md
