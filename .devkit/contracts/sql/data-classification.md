# SQL Server data classification contract

## Scope
Defines enforceable rules for SQL Server data classification metadata.

## Rules (R#)
- G-DC-R1: Sensitive or personal data columns MUST be classified using SQL Server Data Discovery and Classification metadata.
- G-DC-R2: Each classification MUST assign both an Information Type and a Sensitivity Label.
- G-DC-R3: Classification metadata MUST be stored in sys.sensitivity_classifications (SQL Server 2019+), using supported mechanisms.

## Prohibited patterns (P#)
- G-DC-P1: Leaving columns containing personal or sensitive data unclassified when classification capability is available and in use.

## Allowed deviations (D#)
- None.

## Notes
- Classification is metadata, not enforcement.

## Cross-references
- .devkit/playbooks/sql/data-classification.md
