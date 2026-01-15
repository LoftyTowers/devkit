# SQL Server data classification playbook

## Scope
Guidance for using data classification metadata without treating it as enforcement.

## When to use
- When classifying personal or sensitive data columns.

## Default guidance
- G-DC-P2: Classification metadata is advisory; it does not automatically enforce masking, encryption, or auditing.

## Anti-patterns
- Treating classification as a substitute for access controls or encryption.

## Examples/pitfalls
Good:
- Classify columns and still apply masking or encryption where required.
Bad:
- Assume classification alone enforces access control.

## Deviations/Exceptions
- G-DC-D1: Extended properties are allowed only for older versions where sys.sensitivity_classifications is not applicable (version-dependent).

## Cross-references
- .devkit/contracts/sql/data-classification.md
