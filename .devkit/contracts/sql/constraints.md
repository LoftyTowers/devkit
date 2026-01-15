# SQL Server constraints contract

## Constraint correctness
- R3: A UNIQUE constraint can be the target of a FOREIGN KEY.
- R5: Where NULL must be rejected by a CHECK constraint, the CHECK expression MUST explicitly handle NULL.
- R6: Designs MUST NOT rely on CHECK constraints to block DELETE operations.
- R10: Designs MUST NOT rely on DEFAULT constraints to update values on UPDATE.

## Prohibited patterns
- P1: MUST NOT add a constraint without first addressing existing violating rows.
- P2: MUST NOT change a nullable column to NOT NULL while NULLs still exist.
- P3: Relying on CHECK constraints to block deletes is prohibited.
- P4: Relying on DEFAULT constraints to change values on UPDATE is prohibited.
