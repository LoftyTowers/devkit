# SQL Server constraints contract

## Scope

- SQL Server constraint correctness and data readiness expectations.

## Rules

### Constraint correctness

- A UNIQUE constraint can be the target of a FOREIGN KEY.  <!-- NOTE: This is a declarative capability statement and is probably not needed in a contract. -->
- Where NULL must be rejected by a CHECK constraint, the CHECK expression MUST explicitly handle NULL.
- Designs MUST NOT rely on CHECK constraints to block DELETE operations.
- Designs MUST NOT rely on DEFAULT constraints to update values on UPDATE.

## Prohibited patterns

- Constraints MUST NOT be added without first addressing existing violating rows.
- Columns MUST NOT be changed from nullable to NOT NULL while NULLs still exist.
- Designs MUST NOT rely on CHECK constraints to block DELETE operations.
- Designs MUST NOT rely on DEFAULT constraints to update values on UPDATE.

## Allowed deviations

- None.

## Cross-references

- None.
