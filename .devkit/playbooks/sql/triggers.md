# Triggers playbook (SQL Server)

## Scope

Guidance for restrained trigger usage and correctness.

## When to use

- This guidance SHOULD be applied when enforcing complex integrity rules that constraints or stored procedures cannot express.

## Guidance

### Default guidance

- Triggers SHOULD be used only where declarative constraints or stored-procedure-based enforcement cannot express the rule.

### Anti-patterns

- Long-running or complex trigger logic that increases transaction duration and blocking SHOULD be avoided.
- Triggers SHOULD NOT be used for non-critical or best-effort side effects where failure should not abort the core transaction.

## Allowed deviations

### Deviations/Exceptions

- Triggers MAY be used for complex integrity rules not expressible via constraints, especially where not all DML can be forced through stored procedures.
- Triggers MAY be used for legacy audit behaviors where temporal tables are not usable and application changes are impractical.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- A trigger SHOULD be used only when a constraint cannot express the rule.
Bad:
- Triggers SHOULD NOT be used for non-critical logging that should not fail the transaction.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/triggers.md
- .devkit/playbooks/sql/temporal-tables.md
