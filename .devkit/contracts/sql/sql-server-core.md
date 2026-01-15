# SQL Server core contract

## Scope

This contract defines enforceable SQL Server standards for typical OLTP business applications.

In-scope:
- SQL Server database schema (tables, columns, constraints, indexes)
- Query patterns and T-SQL used by the application
- Transaction usage and concurrency behaviour (locking/isolation)
- EF Core migrations as the primary schema change mechanism

Out-of-scope (for now):
- Data warehouse / OLAP modelling
- SSIS/SSRS/Analysis Services
- Cross-database portability rules
- Vendor-specific tooling policies beyond SQL Server + EF Core

## Terminology

- **Contract**: Mandatory rules and prohibited patterns intended to be enforced.
- **Playbook**: Guidance, trade-offs, and examples; not strictly enforced unless promoted into the contract.
- **Deviation**: A permitted exception that requires explicit justification and documentation.
- **OLTP**: Online Transaction Processing; many small reads/writes with concurrency.
- **Migration**: A versioned schema change (primarily via EF Core migrations).

## Rules

> NOTE: Do not write rules here yet.
> Populate this section only from authoritative research notes.

- R1 — [Placeholder]
- R2 — [Placeholder]
- R3 — [Placeholder]
- R4 — [Placeholder]
- R5 — [Placeholder]

## Prohibited patterns

> NOTE: Do not write prohibitions here yet.
> Populate this section only from authoritative research notes.

- P1 — [Placeholder]
- P2 — [Placeholder]
- P3 — [Placeholder]
- P4 — [Placeholder]
- P5 — [Placeholder]

## Deviations

> Deviations are allowed only when documented and reviewed.
> Each deviation must name the rule/prohibition, the reason, and the mitigation.

- D1 — [Placeholder]
- D2 — [Placeholder]
- D3 — [Placeholder]
