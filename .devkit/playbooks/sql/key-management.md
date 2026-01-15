# SQL Server key management playbook

## Scope
Guidance for key backup and availability risks.

## When to use
- When managing encryption keys and backups.

## Default guidance
- G-KM-R3: Loss or unavailability of key material protecting encrypted data must be treated as catastrophic and mitigated by backups as described.

## Anti-patterns
- Ignoring key backup or restore testing.

## Examples/pitfalls
Good:
- Store key backups in a secure, separate location.
Bad:
- Assume key material is always available without backup.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/key-management.md
