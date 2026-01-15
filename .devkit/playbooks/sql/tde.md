# SQL Server TDE playbook

## Scope
Guidance for Transparent Data Encryption behavior and operational considerations.

## When to use
- When evaluating TDE for encryption at rest.

## Default guidance
- G-TDE-R1: TDE encrypts data and log files and backups at rest, with encryption and decryption occurring at the I/O layer.
- G-TDE-R5: TDE enablement should account for the initial encryption scan and operational impact; monitor scan state with sys.dm_database_encryption_keys.

## Anti-patterns
- Assuming TDE replaces transport or application-layer encryption.

## Examples/pitfalls
Good:
- Monitor encryption scan progress after enabling TDE.
Bad:
- Assume TDE encrypts data in memory or in transit.

## Deviations/Exceptions
- G-TDE-D1: Suspending or resuming the TDE scan is allowed where supported by SQL Server version (version-dependent).

## Cross-references
- .devkit/contracts/sql/tde.md
