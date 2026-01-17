# SQL Server Always Encrypted playbook

## Scope
Guidance for choosing Always Encrypted modes and understanding trade-offs.

## When to use
- Always Encrypted SHOULD be considered when client-side encryption is required for sensitive columns.

## Default guidance
- Always Encrypted is client-side encryption; the database does not hold plaintext or encryption keys.
- Deterministic encryption SHOULD be used only when equality operations and indexing are required.
- Randomized encryption SHOULD be used when highest confidentiality is required and reduced query capability is acceptable.

## Anti-patterns
- Assuming randomized encryption supports rich query patterns.

## Examples/pitfalls
Good:
- Deterministic encryption SHOULD be used only when equality search is required.
Bad:
- Randomized encryption SHOULD NOT be expected to support range queries.

## Deviations/Exceptions
- Decrypting client-side and performing operations in the application MAY be used as a workaround where stated.

## Cross-references
- .devkit/contracts/sql/always-encrypted.md
