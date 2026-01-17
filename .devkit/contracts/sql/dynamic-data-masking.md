# SQL Server dynamic data masking contract

## Scope
Defines enforceable requirements for Dynamic Data Masking (DDM).

## Rules (R#)
- UNMASK permissions MUST be managed so that only authorized principals can see unmasked results.

## Prohibited patterns (P#)
- DDM MUST NOT be relied upon as the sole mechanism to prevent data theft or breach.
- UPDATE permissions MUST NOT be granted on masked columns without accounting for the fact that updates are not masked.
- DDM masking MUST NOT be applied to Always Encrypted columns.

## Allowed deviations (D#)
- None.

## Notes
- DDM is not a primary security control.

## Cross-references
- .devkit/playbooks/sql/dynamic-data-masking.md
