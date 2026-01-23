## Scope
Defines authoritative validation sources for SQL Server correctness and execution behaviour.

## Rules
- SQL Server engine runtime errors MUST be treated as the authoritative validation result.
- Editor or static diagnostics (for example, SSMS IntelliSense or SSDT build diagnostics) MUST NOT be treated as authoritative until confirmed by SQL Server execution.

## Prohibited patterns
- Blocking delivery solely on editor or static diagnostics without confirming behaviour through SQL Server execution where execution-based validation is possible.

## Allowed deviations
- None.

## Cross-references
- playbooks/sql/handling-editor-diagnostics.md
