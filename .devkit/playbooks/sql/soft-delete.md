# Soft delete playbook (SQL Server)

## Scope
Guidance for choosing soft delete patterns as explicit local design decisions.

## When to use
- This guidance SHOULD be applied when evaluating soft delete as a pattern option.

## Default guidance
- Any soft delete implementation SHOULD be treated as a pattern-level decision requiring explicit local choice, rather than an assumed default.

## Anti-patterns
- Soft delete SHOULD NOT be claimed as always better than hard delete as an authoritative rule.
- A single soft delete pattern SHOULD NOT be encoded as mandatory solely on vendor authority.

## Examples/pitfalls
Good:
- The chosen soft delete approach and why it fits local requirements SHOULD be documented.
Bad:
- Soft delete SHOULD NOT be assumed to be required everywhere without a local decision.

## Deviations/Exceptions
- Any soft delete pattern MAY be chosen locally, provided the choice is treated as an explicit design decision.

## Cross-references
- .devkit/contracts/sql/soft-delete-authority-boundary.md
- .devkit/contracts/sql/retention-and-deletion.md
- .devkit/playbooks/sql/retention-and-deletion.md
