# Permissions and ownership chaining playbook (SQL Server)

## Scope

Guidance for using views and stored procedures as permission surfaces via ownership chaining and EXECUTE AS.

## When to use

- This guidance SHOULD be applied when encapsulating table access via stored procedures or views with stable ownership.

## Guidance

### Default guidance

- Ownership chaining and EXECUTE AS SHOULD be used deliberately to encapsulate access via procedures or views with stable ownership, granting only EXECUTE or SELECT where intended.
- When views are used as a security abstraction, permissions SHOULD be granted on the view and direct permissions on underlying tables SHOULD be withheld, consistent with ownership chaining expectations.
- When ownership differs and chaining would break, designs SHOULD explicitly account for required permissions on the underlying objects.

### Anti-patterns

- Accidental ownership chains (inconsistent owners or schemas) SHOULD NOT be relied on as an unreviewed security boundary.
- Broad base-table permissions SHOULD NOT be granted when the design intent is to mediate access through views.

## Allowed deviations

### Deviations/Exceptions

- Explicit table permissions MAY be used where ownership cannot be unified and the boundary is documented.

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- Grant EXECUTE on a procedure that owns underlying objects.
Bad:
- Rely on accidental ownership chain with inconsistent owners.
Good:
GRANT SELECT ON dbo.v_Orders TO AppRole;
Bad:
GRANT SELECT ON dbo.Orders TO AppRole; -- bypasses view boundary

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/cross-database-ownership-chaining.md
- .devkit/contracts/sql/ownership-chaining.md
- .devkit/playbooks/sql/views.md
