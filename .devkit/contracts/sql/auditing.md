# SQL Server auditing contract

## Scope
Defines enforceable requirements for SQL Server auditing and audit control.

## Rules (R#)
- G-AUD-R2: For sensitive data monitoring, SENSITIVE_BATCH_COMPLETED_GROUP (SQL Server 2022+) MUST be used where recommended for auditing operations on classified sensitive columns.
- G-AUD-R3: Audit specification changes MUST be auditable (audit the audit changes).
- G-AUD-R5: Required permissions for creating or altering audit specifications MUST be restricted as described.

## Prohibited patterns (P#)
- G-AUD-P1: Storing audit logs in locations where attackers or unauthorized principals can delete or modify them without detection.
- G-AUD-P2: Assuming sensitive-data audit coverage exists without sensitive column classification.

## Allowed deviations (D#)
- None.

## Notes
- Audit coverage depends on classification and secure log storage.

## Cross-references
- .devkit/playbooks/sql/auditing.md
