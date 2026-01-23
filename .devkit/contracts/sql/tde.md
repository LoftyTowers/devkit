# SQL Server TDE contract

## Scope

Defines enforceable limits and key handling for Transparent Data Encryption (TDE).

### Notes

- TDE is encryption-at-rest only.

## Rules

- TDE MUST NOT be treated as protection for data-in-transit or data-in-memory.
- The certificate or key protecting the DEK MUST be backed up immediately after TDE is enabled.
- Certificate backups and private keys MUST be stored securely and separately from the SQL Server host.

## Prohibited patterns

- TDE MUST NOT be relied upon as protection against a connected privileged user reading plaintext via normal queries.
- TDE MUST NOT be enabled without backing up the certificate or private key protecting the DEK.
- TDE certificate backups MUST NOT be stored only on the SQL Server machine.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/tde.md
