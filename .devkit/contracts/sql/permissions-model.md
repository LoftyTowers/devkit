# SQL Server permissions model contract

## Scope

Defines enforceable least-privilege rules for permission assignment and EXECUTE AS usage.

## Precedence and scope

- Contracts are authoritative for MUST/MUST NOT rules.
- Playbooks and how-to guides are advisory patterns, examples, or execution steps.

## Rules

- Broad permissions over entire tables or databases MUST NOT be granted by default; only required objects MUST be granted.
- If EXECUTE AS is used, it MUST NOT introduce embedded credentials inside code.

## Prohibited patterns

- db_owner or equivalent broad administrative access MUST NOT be granted to operational users as a routine access pattern.
- Direct per-user object grants MUST NOT be used as the primary permission model when role-based grants are available.
- EXECUTE AS MUST NOT be used with embedded credentials or hardcoded secrets as a workaround.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/permissions-model.md
- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
