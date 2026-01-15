# SQL Server TDE contract

## Scope
Defines enforceable limits and key handling for Transparent Data Encryption (TDE).

## Rules (R#)
- G-TDE-R2: TDE MUST NOT be treated as protection for data-in-transit or data-in-memory.
- G-TDE-R3: The certificate or key protecting the DEK MUST be backed up immediately after TDE is enabled.
- G-TDE-R4: Certificate backups and private keys MUST be stored securely and separately from the SQL Server host.

## Prohibited patterns (P#)
- G-TDE-P1: Relying on TDE as protection against a connected privileged user reading plaintext via normal queries.
- G-TDE-P2: Enabling TDE without backing up the DEK-protecting certificate or private key.
- G-TDE-P3: Storing the TDE certificate backup only on the SQL Server machine.

## Allowed deviations (D#)
- None.

## Notes
- TDE is encryption-at-rest only.

## Cross-references
- .devkit/playbooks/sql/tde.md
