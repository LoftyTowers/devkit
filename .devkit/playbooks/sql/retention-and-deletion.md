# SQL Server retention and deletion playbook

## Scope
Guidance for retention, deletion, and anonymisation terminology.

## When to use
- When defining data retention and deletion patterns.

## Default guidance
- G-RET-R1: Soft delete is logical deletion that retains data and requires disciplined filtering to exclude deleted rows.
- G-RET-R2: Archiving may copy deleted rows to an archive store before physical deletion.
- G-RET-R4: Anonymisation is irreversible; pseudonymisation is reversible; designs must not conflate them.

## Anti-patterns
- Conflating anonymisation with pseudonymisation.

## Examples/pitfalls
Good:
- Document whether deletion is logical (soft) or physical.
Bad:
- Treat soft delete as irreversible erasure.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/retention-and-deletion.md
