# SQL Server permissions model contract

## Scope
Defines enforceable least-privilege rules for permission assignment and EXECUTE AS usage.

## Rules (R#)
- Broad permissions over entire tables or databases MUST NOT be granted by default; only required objects MUST be granted.
- If EXECUTE AS is used, it MUST NOT introduce embedded credentials inside code.

## Prohibited patterns (P#)
- db_owner or equivalent broad administrative access MUST NOT be granted to operational users as a routine access pattern.
- Direct per-user object grants MUST NOT be used as the primary permission model when role-based grants are available.
- EXECUTE AS MUST NOT be used with embedded credentials or hardcoded secrets as a workaround.

## Allowed deviations (D#)
- None.

## Notes
- Use the permissions playbook for role-based guidance and exceptions.

## Cross-references
- .devkit/playbooks/sql/permissions-model.md
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
