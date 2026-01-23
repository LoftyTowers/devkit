# SQL Server join correctness contract

## Scope

Applies to JOIN logic where non-unique keys can amplify rows.

## Rules

- When using JOIN to combine tables, query authors MUST account for duplicate amplification where join keys are not unique.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- .devkit/playbooks/sql/joins.md
