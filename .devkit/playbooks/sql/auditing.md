# SQL Server auditing playbook

## Scope
Guidance for SQL Server Audit capabilities and log protection.

## When to use
- When configuring auditing for sensitive data access or changes.

## Default guidance
- G-AUD-R1: SQL Server Audit can capture server- and database-level actions as described.
- G-AUD-R4: Audit logs must be protected against tampering; restrict access and archive to immutable storage as described.

## Anti-patterns
- Storing audit logs where they can be modified without detection.

## Examples/pitfalls
Good:
- Restrict access to audit logs and archive them immutably.
Bad:
- Store audit logs in the same location as general data files with broad access.

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/auditing.md
