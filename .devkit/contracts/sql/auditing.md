# SQL Server auditing contract

## Scope
Defines enforceable requirements for SQL Server auditing and audit control.

## Rules (R#)
- For sensitive data monitoring, SENSITIVE_BATCH_COMPLETED_GROUP (SQL Server 2022+) MUST be used where recommended for auditing operations on classified sensitive columns.
- Audit specification changes MUST be auditable.
- Permissions required to create or alter audit specifications MUST be restricted as described.

## Prohibited patterns (P#)
- Audit logs MUST NOT be stored in locations where attackers or unauthorized principals can delete or modify them without detection.
- Sensitive-data audit coverage MUST NOT be assumed without sensitive column classification.

## Allowed deviations (D#)
- None.

## Notes
- Audit coverage depends on classification and secure log storage.

## Cross-references
- .devkit/playbooks/sql/auditing.md
