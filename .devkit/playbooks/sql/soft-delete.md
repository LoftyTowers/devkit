# Soft delete playbook (SQL Server)

## Scope
Guidance for choosing soft delete patterns as explicit local design decisions.

## When to use
- When evaluating soft delete as a pattern option.

## Default guidance
- R2: Any soft delete implementation MUST be treated as a pattern-level decision requiring explicit local choice, rather than an assumed default.

## Anti-patterns
- P1: Claiming soft delete is always better than hard delete as an authoritative rule.
- P2: Encoding a single soft delete pattern as mandatory solely on vendor authority.

## Examples/pitfalls
Good:
- Document the chosen soft delete approach and why it fits local requirements.
Bad:
- Assume soft delete is required everywhere without a local decision.

## Deviations/Exceptions
- D1: Any soft delete pattern may be chosen locally, provided the choice is treated as an explicit design decision.

## Cross-references
- .devkit/contracts/sql/soft-delete-authority-boundary.md
