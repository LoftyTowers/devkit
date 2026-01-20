# SQL Server data classification playbook

## Scope

Guidance for using data classification metadata without treating it as enforcement.

## When to use

- Data classification SHOULD be considered when classifying personal or sensitive data columns.

## Guidance

### Default guidance

- Classification metadata is advisory and does not automatically enforce masking, encryption, or auditing.

### Anti-patterns

- Treating classification as a substitute for access controls or encryption.

## Allowed deviations

### Deviations/Exceptions

- Extended properties MAY be used for older versions where sys.sensitivity_classifications is not applicable (version-dependent).

## Trade-offs and pitfalls

### Examples/pitfalls

Good:
- Columns SHOULD be classified and masking or encryption SHOULD still be applied where required.
Bad:
- Classification alone SHOULD NOT be assumed to enforce access control.

## Examples

- None.

## Cross-references

- .devkit/contracts/sql/data-classification.md
