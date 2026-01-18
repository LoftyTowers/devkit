# SQL Server computed columns contract

## Scope

- SQL Server computed column definitions, indexing, and constraint interactions.

## Rules

### Computed columns

- A computed column MUST meet determinism and precision requirements to be indexed.
- A computed column MUST NOT be the target of INSERT or UPDATE.
- A computed column MUST NOT be used in DEFAULT or FOREIGN KEY constraints.
- A computed column MAY be used in PRIMARY KEY or UNIQUE constraints only if it is deterministic.

## Prohibited patterns

- Computed columns MUST NOT be INSERTed into or UPDATEd.
- Computed columns MUST NOT be used in DEFAULT or FOREIGN KEY constraints.

## Allowed deviations

### Deviations

- Deterministic computed columns MAY participate in PRIMARY KEY or UNIQUE constraints only if they are deterministic.

## Cross-references

- None.
