# SQL Server key management contract

## Scope
Defines enforceable rules for cryptographic key handling and storage boundaries.

## Rules (R#)
- G-KM-R1: Cryptographic keys and protector secrets MUST NOT be hardcoded in code or stored unencrypted in the database.
- G-KM-R2: Column master keys (CMKs) MUST be stored outside the database in a trusted key store; the database contains only metadata and encrypted column encryption keys (CEKs).

## Prohibited patterns (P#)
- G-KM-P1: Storing CMKs inside the database unencrypted.
- G-KM-P2: Hardcoding key passwords or embedding secrets in application code or configuration.
- G-KM-P3: Enabling encryption features without backing up required key material.

## Allowed deviations (D#)
- None.

## Notes
- Key loss is catastrophic; see key-management playbook for backup guidance.

## Cross-references
- .devkit/playbooks/sql/key-management.md
