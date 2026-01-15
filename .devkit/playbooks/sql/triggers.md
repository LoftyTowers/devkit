# Triggers playbook (SQL Server)

## Scope
Guidance for restrained trigger usage and correctness.

## When to use
- When enforcing complex integrity rules that constraints or stored procedures cannot express.

## Default guidance
- R2: Triggers SHOULD be used only where declarative constraints or stored-procedure-based enforcement cannot express the rule.

## Anti-patterns
- P1: Implementing long-running or complex trigger logic that increases transaction duration and blocking.
- P2: Using triggers for non-critical or best-effort side effects where failure should not abort the core transaction.

## Examples/pitfalls
Good:
- Use a trigger only when a constraint cannot express the rule.
Bad:
- Trigger for non-critical logging that should not fail the transaction.

## Deviations/Exceptions
- D1: Triggers are justified for complex integrity rules not expressible via constraints, especially where not all DML can be forced through stored procedures.
- D2: Triggers are justified for legacy audit behaviors where temporal tables are not usable and application changes are impractical.

## Cross-references
- .devkit/contracts/sql/triggers.md
- .devkit/playbooks/sql/temporal-tables.md
