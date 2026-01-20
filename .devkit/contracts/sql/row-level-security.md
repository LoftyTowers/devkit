# SQL Server row-level security contract

## Scope

Defines enforceable requirements for Row-Level Security (RLS).

### Notes

- RLS is defense-in-depth and has known bypass conditions.

## Rules

### Rules (R#)

- Create, alter, and drop security policies MUST be restricted to principals with the required high-privilege permissions.

## Prohibited patterns

### Prohibited patterns (P#)

- RLS MUST NOT be applied where it is bypassed or incompatible without redesign.
- RLS MUST NOT be treated as a replacement for application authorization.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/row-level-security.md
