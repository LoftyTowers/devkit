# Permissions and ownership chaining playbook (SQL Server)

## Scope
Guidance for using views and stored procedures as permission surfaces via ownership chaining and EXECUTE AS.

## When to use
- When encapsulating table access via stored procedures or views with stable ownership.

## Default guidance
- R1: Ownership chaining and EXECUTE AS SHOULD be used deliberately to encapsulate access via procs or views with stable ownership, granting only EXECUTE or SELECT where intended.
- R2: When views are used as a security abstraction, permissions SHOULD be granted on the view and direct permissions on underlying tables SHOULD be withheld, consistent with ownership chaining expectations.

## Anti-patterns
- P1: Relying on accidental ownership chains (inconsistent owners or schemas) as an unreviewed security boundary.
- P2: Granting broad base-table permissions when the design intent is to mediate access through views.

## Examples/pitfalls
Good:
- Grant EXECUTE on a procedure that owns underlying objects.
Bad:
- Rely on accidental ownership chain with inconsistent owners.
Good:
GRANT SELECT ON dbo.v_Orders TO AppRole;
Bad:
GRANT SELECT ON dbo.Orders TO AppRole; -- bypasses view boundary

## Deviations/Exceptions
- None explicitly identified.

## Cross-references
- .devkit/contracts/sql/cross-database-ownership-chaining.md
- .devkit/playbooks/sql/views.md
