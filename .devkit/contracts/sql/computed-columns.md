# SQL Server computed columns contract

## Computed columns
- R2: A computed column MUST meet determinism and precision requirements to be indexed.
- R3: A computed column MUST NOT be the target of INSERT or UPDATE.
- R4: A computed column MUST NOT be used in DEFAULT or FOREIGN KEY constraints.
- R5: A computed column MAY be used in PRIMARY KEY or UNIQUE constraints if deterministic.

## Prohibited patterns
- P1: Attempting to INSERT or UPDATE computed columns is prohibited.
- P2: Using computed columns in DEFAULT or FOREIGN KEY constraints is prohibited.

## Deviations
- D1: Deterministic computed columns MAY participate in PRIMARY KEY or UNIQUE constraints.
