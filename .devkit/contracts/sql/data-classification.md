# SQL Server data classification contract

## Scope

Defines enforceable rules for SQL Server data classification metadata.

### Notes

- Classification is metadata, not enforcement.

## Rules

### Rules (R#)

- Sensitive or personal data columns MUST be classified using SQL Server Data Discovery and Classification metadata.
- Each classification MUST assign both an Information Type and a Sensitivity Label.
- Classification metadata MUST be stored in sys.sensitivity_classifications (SQL Server 2019+) using supported mechanisms.

## Prohibited patterns

### Prohibited patterns (P#)

- Columns containing personal or sensitive data MUST NOT be left unclassified when classification capability is available and in use.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/playbooks/sql/data-classification.md
