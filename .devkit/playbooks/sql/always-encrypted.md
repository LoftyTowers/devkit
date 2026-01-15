# SQL Server Always Encrypted playbook

## Scope
Guidance for choosing Always Encrypted modes and understanding trade-offs.

## When to use
- When client-side encryption is required for sensitive columns.

## Default guidance
- G-AE-R1: Always Encrypted is client-side encryption; the database does not hold plaintext or encryption keys.
- G-AE-R2: Deterministic encryption SHOULD be used only when equality operations and indexing are required.
- G-AE-R3: Randomized encryption SHOULD be used when highest confidentiality is required and reduced query capability is acceptable.

## Anti-patterns
- Assuming randomized encryption supports rich query patterns.

## Examples/pitfalls
Good:
- Use deterministic encryption only when equality search is required.
Bad:
- Expect randomized columns to support range queries.

## Deviations/Exceptions
- G-AE-D1: Decrypting client-side and performing operations in the application is an allowed workaround where stated.

## Cross-references
- .devkit/contracts/sql/always-encrypted.md
