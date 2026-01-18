# SQL Server hashing and encryption contract

## Scope

Defines enforceable rules for hashing vs encryption of sensitive data.

### Notes

- Hashing and encryption serve different purposes.

## Rules

### Rules (R#)

- Passwords MUST be stored using hashing, not encryption.

## Prohibited patterns

### Prohibited patterns (P#)

- Passwords MUST NOT be stored in reversible form, including encrypted or plaintext storage.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/hashing-and-encryption.md
