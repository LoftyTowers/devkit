# SQL Server permissions model playbook

## Scope
Guidance for role-based permission assignment and DENY usage.

## When to use
- When designing the permissions model for database access.

## Default guidance
- G-LP-R2: Permission assignments SHOULD be role-based (grant to roles; assign users to roles) rather than granting directly to users, except documented exceptions.
- G-LP-R3: DENY SHOULD be used only to revoke inherited permissions, where possible.

## Anti-patterns
- Overuse of DENY to manage complex permission sets.

## Examples/pitfalls
Good:
- Grant SELECT to a role and assign users to the role.
Bad:
- Grant object permissions directly to many individual users by default.

## Deviations/Exceptions
- G-LP-D1: Direct user grants allowed for administrative or sensitive roles where explicitly indicated as an exception.

## Cross-references
- .devkit/contracts/sql/permissions-model.md
