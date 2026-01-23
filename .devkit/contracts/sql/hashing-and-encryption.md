# SQL Server hashing and encryption contract

## Scope

Defines enforceable rules for hashing vs encryption of sensitive data.

### Notes

- Hashing and encryption serve different purposes.

## Rules

- Passwords MUST be stored using hashing, not encryption.

## Prohibited patterns

- Passwords MUST NOT be stored in reversible form, including encrypted or plaintext storage.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/hashing-and-encryption.md
