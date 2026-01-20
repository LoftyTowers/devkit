# SQL Server result set sizing contract

## Scope

Applies to user-facing query result sizing where unbounded results are unsafe or incorrect.

## Rules

### Rules (R#)

- None. See playbook guidance for sizing practices.

## Prohibited patterns

### Prohibited patterns (P#)

- Unbounded result sets MUST NOT be returned for user-facing endpoints.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/result-set-sizing.md
- .devkit/how-to/sql/exports-and-bulk-reads.md
