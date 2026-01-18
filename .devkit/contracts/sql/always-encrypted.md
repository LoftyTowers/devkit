# SQL Server Always Encrypted contract

## Scope

Defines enforceable design constraints for Always Encrypted.

### Notes

- Always Encrypted is client-side and restricts server-side operations.

## Rules

### Rules (R#)

- Always Encrypted limitations on server-side operations MUST be acknowledged as constraints in design.

## Prohibited patterns

### Prohibited patterns (P#)

- Workloads MUST NOT be designed to require unsupported server-side operations on encrypted columns without an approved workaround.
- Randomized-encrypted columns MUST NOT be treated as supporting rich query patterns without secure enclave mechanisms and the required architecture.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/always-encrypted.md
