# SQL Server dynamic data masking contract

## Scope
Defines enforceable requirements for Dynamic Data Masking (DDM).

## Rules (R#)
- G-DDM-R2: UNMASK permissions MUST be managed so only authorized principals can see unmasked results.

## Prohibited patterns (P#)
- G-DDM-P1: Relying on DDM alone to prevent data theft or breach.
- G-DDM-P2: Granting UPDATE permissions on masked columns without accounting for updates not being masked.
- G-DDM-P3: Applying DDM masking to Always Encrypted columns.

## Allowed deviations (D#)
- None.

## Notes
- DDM is not a primary security control.

## Cross-references
- .devkit/playbooks/sql/dynamic-data-masking.md
