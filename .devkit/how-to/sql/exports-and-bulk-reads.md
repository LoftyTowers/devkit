# Exports and bulk reads (SQL Server)

## When to use this
Use when performing administrative or offline exports where consumers and operational controls are explicit.

## Steps
1) Define the export consumer, destination, and handling controls.
2) Confirm the export is not user-facing or latency-sensitive.
3) Record the operational safeguards (rate limits, batching, or maintenance windows).

## Evidence to capture (what to record in PR / review)
- Consumer identity and usage boundaries.
- Operational controls preventing accidental overload.
- Justification for unbounded result sets.

## Examples
Good:
SELECT * FROM dbo.AuditLog; -- offline export with explicit controls
Bad:
SELECT * FROM dbo.AuditLog; -- used in interactive UI flow

## Cross-references
- .devkit/contracts/sql/result-set-sizing.md
- .devkit/playbooks/sql/result-set-sizing.md
