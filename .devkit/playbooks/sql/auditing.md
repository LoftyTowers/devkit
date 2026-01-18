# SQL Server auditing playbook

## Scope

Guidance for SQL Server Audit capabilities and log protection.

## When to use

- SQL Server auditing SHOULD be considered when configuring auditing for sensitive data access or changes.

## Guidance

### Default guidance

- SQL Server Audit can capture server- and database-level actions as described.
- Audit logs SHOULD be protected against tampering; access SHOULD be restricted and logs SHOULD be archived to immutable storage as described.

### Anti-patterns

- Storing audit logs where they can be modified without detection.

## Allowed deviations

### Deviations/Exceptions

- None explicitly identified.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- Access to audit logs SHOULD be restricted and logs SHOULD be archived immutably.
Bad:
- Audit logs SHOULD NOT be stored in the same location as general data files with broad access.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/auditing.md
