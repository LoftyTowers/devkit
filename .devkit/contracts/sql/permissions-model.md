# SQL Server permissions model contract

## Scope
Defines enforceable least-privilege rules for permission assignment and EXECUTE AS usage.

## Rules (R#)
- G-LP-R1: Broad permissions over entire tables or databases MUST NOT be granted by default; grant only required objects.
- G-OC-R4: If EXECUTE AS is used, it MUST NOT introduce embedded credentials inside code.

## Prohibited patterns (P#)
- G-LP-P1: Granting db_owner (or equivalent broad admin access) to operational users as a routine access pattern.
- G-LP-P2: Using direct per-user object grants as the primary permission model when role-based grants are available.
- G-OC-P2: Using EXECUTE AS with embedded credentials (hardcoded secrets) as a workaround.

## Allowed deviations (D#)
- None.

## Notes
- Use the permissions playbook for role-based guidance and exceptions.

## Cross-references
- .devkit/playbooks/sql/permissions-model.md
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
