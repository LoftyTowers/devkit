# SQL Server hashing and encryption playbook

## Scope
Guidance for choosing hashing vs encryption for sensitive data.

## When to use
- When deciding how to store passwords or retrievable sensitive data.

## Default guidance
- G-HE-R2: Sensitive data that must be retrievable SHOULD be encrypted (not hashed).
- G-HE-P2: Hashing and encryption are not interchangeable mechanisms.

## Anti-patterns
- Treating hashes as reversible or equivalent to encryption.

## Examples/pitfalls
Good:
- Encrypt retrievable secrets; hash passwords.
Bad:
- Use hashing when data must be retrieved.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/hashing-and-encryption.md
