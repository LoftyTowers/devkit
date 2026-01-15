# SQL Server Always Encrypted contract

## Scope
Defines enforceable design constraints for Always Encrypted.

## Rules (R#)
- G-AE-R4: Always Encrypted limitations on server-side operations MUST be acknowledged as constraints in design.

## Prohibited patterns (P#)
- G-AE-P1: Designing workloads that require unsupported server-side operations on encrypted columns without an approved workaround.
- G-AE-P2: Treating randomized-encrypted columns as if they support rich query patterns without secure enclave mechanisms and required architecture.

## Allowed deviations (D#)
- None.

## Notes
- Always Encrypted is client-side and restricts server-side operations.

## Cross-references
- .devkit/playbooks/sql/always-encrypted.md
