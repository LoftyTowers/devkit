# SQL Server permissions model playbook

## Scope

Guidance for role-based permission assignment and DENY usage.

## When to use

- This guidance SHOULD be applied when designing the permissions model for database access.

## Guidance

### Default guidance

- Permission assignments SHOULD be role-based (grant to roles and assign users to roles) rather than granted directly to users, except for documented exceptions.
- DENY SHOULD be used only to revoke inherited permissions, where possible.

### Anti-patterns

- Overuse of DENY to manage complex permission sets.

## Allowed deviations

### Deviations/Exceptions

- Direct user grants MAY be used for administrative or sensitive roles where explicitly indicated as an exception.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- SELECT permissions SHOULD be granted to a role, and users SHOULD be assigned to that role.
Bad:
- Object permissions SHOULD NOT be granted directly to many individual users by default.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/permissions-model.md
