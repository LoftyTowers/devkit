# SQL Server key management contract

## Scope
Defines enforceable rules for cryptographic key handling and storage boundaries.

## Rules (R#)
- Cryptographic keys and protector secrets MUST NOT be hardcoded in code or stored unencrypted in the database.
- Column master keys (CMKs) MUST be stored outside the database in a trusted key store; the database MUST contain only metadata and encrypted column encryption keys (CEKs).

## Prohibited patterns (P#)
- Column master keys (CMKs) MUST NOT be stored unencrypted inside the database.
- Key passwords and other secrets MUST NOT be hardcoded or embedded in application code or configuration.
- Encryption features MUST NOT be enabled without backing up the required key material.

## Allowed deviations (D#)
- None.

## Notes
- Key loss is catastrophic; see key-management playbook for backup guidance.

## Cross-references
- .devkit/playbooks/sql/key-management.md
