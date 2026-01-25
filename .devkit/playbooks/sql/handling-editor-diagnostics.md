# Handling editor diagnostics playbook (SQL Server)

## Scope
Non-enforceable guidance for interpreting editor and static diagnostics in SQL Server workflows.

## When to use
Use when editor or build-time diagnostics conflict with observed SQL Server runtime behaviour.

## Guidance
- Editor and static diagnostics can surface missing metadata, stale cache, or incomplete analysis.
- Runtime execution reflects actual SQL Server behaviour and is authoritative.
- Refresh or rebuild editor metadata before escalating diagnostics.

## Trade-offs and pitfalls
- Over-reliance on editor diagnostics can block valid changes.
- Ignoring diagnostics without investigation can mask real issues.

## Examples
- SSMS IntelliSense reporting missing objects after deployment until cache refresh.

## Cross-references
- contracts/sql/validation-authority.md

