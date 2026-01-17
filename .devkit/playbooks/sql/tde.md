# SQL Server TDE playbook

## Scope
Guidance for Transparent Data Encryption behavior and operational considerations.

## When to use
- This guidance SHOULD be applied when evaluating TDE for encryption at rest.

## Default guidance
- TDE encrypts data files, log files, and backups at rest, with encryption and decryption occurring at the I/O layer.
- TDE enablement SHOULD account for the initial encryption scan and operational impact, and scan state SHOULD be monitored using sys.dm_database_encryption_keys.

## Anti-patterns
- Assuming TDE replaces transport or application-layer encryption.

## Examples/pitfalls
Good:
- Encryption scan progress SHOULD be monitored after enabling TDE.
Bad:
- TDE SHOULD NOT be assumed to encrypt data in memory or in transit.

## Deviations/Exceptions
- Suspending or resuming the TDE scan MAY be used where supported by the SQL Server version (version-dependent).

## Cross-references
- .devkit/contracts/sql/tde.md
