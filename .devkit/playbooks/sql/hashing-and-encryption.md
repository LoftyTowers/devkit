# SQL Server hashing and encryption playbook

## Scope
Guidance for choosing hashing vs encryption for sensitive data.

## When to use
- This guidance SHOULD be applied when deciding how to store passwords or retrievable sensitive data.

## Default guidance
- Sensitive data that must be retrievable SHOULD be encrypted rather than hashed.
- Hashing and encryption SHOULD NOT be treated as interchangeable mechanisms.

## Anti-patterns
- Treating hashes as reversible or equivalent to encryption.

## Examples/pitfalls
Good:
- Retrievable secrets SHOULD be encrypted, and passwords SHOULD be hashed.
Bad:
- Hashing SHOULD NOT be used when data must be retrieved.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/hashing-and-encryption.md
