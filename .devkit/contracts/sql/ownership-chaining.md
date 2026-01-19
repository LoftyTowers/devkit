# SQL Server ownership chaining contract

## Scope

Defines enforceable ownership chaining requirements for procedures and views.

## Precedence and scope

- Contracts are authoritative for MUST/MUST NOT rules.
- Playbooks and how-to guides are advisory patterns, examples, or execution steps.

## Rules

- Ownership chaining requires the procedure or view and the underlying table to share the same owner.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/permissions-and-ownership-chaining.md
