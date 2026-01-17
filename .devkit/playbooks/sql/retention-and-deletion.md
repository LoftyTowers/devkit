# SQL Server retention and deletion playbook

## Scope
Guidance for retention, deletion, and anonymisation terminology.

## When to use
- This guidance SHOULD be applied when defining data retention and deletion patterns.

## Default guidance
- Soft delete is logical deletion that retains data and requires disciplined filtering to exclude deleted rows.
- Archiving MAY copy deleted rows to an archive store before physical deletion.
- Anonymisation is irreversible, pseudonymisation is reversible, and designs SHOULD NOT conflate them.

## Anti-patterns
- Conflating anonymisation with pseudonymisation.

## Examples/pitfalls
Good:
- Whether deletion is logical (soft) or physical SHOULD be documented.
Bad:
- Soft delete SHOULD NOT be treated as irreversible erasure.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/retention-and-deletion.md
