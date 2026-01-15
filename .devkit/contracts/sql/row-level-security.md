# SQL Server row-level security contract

## Scope
Defines enforceable requirements for Row-Level Security (RLS).

## Rules (R#)
- G-RLS-R3: Create, alter, and drop security policies MUST be restricted to principals with required high-privilege permissions.

## Prohibited patterns (P#)
- G-RLS-P1: Applying RLS where it is bypassed or incompatible without redesign.
- G-RLS-P2: Treating RLS as a replacement for application authorization.

## Allowed deviations (D#)
- None.

## Notes
- RLS is defense-in-depth and has known bypass conditions.

## Cross-references
- .devkit/playbooks/sql/row-level-security.md
