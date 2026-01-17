# SQL Server data classification contract

## Scope
Defines enforceable rules for SQL Server data classification metadata.

## Rules (R#)
- Sensitive or personal data columns MUST be classified using SQL Server Data Discovery and Classification metadata.
- Each classification MUST assign both an Information Type and a Sensitivity Label.
- Classification metadata MUST be stored in sys.sensitivity_classifications (SQL Server 2019+) using supported mechanisms.

## Prohibited patterns (P#)
- Columns containing personal or sensitive data MUST NOT be left unclassified when classification capability is available and in use.

## Allowed deviations (D#)
- None.

## Notes
- Classification is metadata, not enforcement.

## Cross-references
- .devkit/playbooks/sql/data-classification.md
