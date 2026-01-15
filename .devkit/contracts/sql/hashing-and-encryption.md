# SQL Server hashing and encryption contract

## Scope
Defines enforceable rules for hashing vs encryption of sensitive data.

## Rules (R#)
- G-HE-R1: Passwords MUST be stored using hashing, not encryption.

## Prohibited patterns (P#)
- G-HE-P1: Storing passwords in reversible form (encrypted or plaintext).

## Allowed deviations (D#)
- None.

## Notes
- Hashing and encryption serve different purposes.

## Cross-references
- .devkit/playbooks/sql/hashing-and-encryption.md
