# SQL Server authority boundaries contract

## Scope

Applies to optimizer-dependent guidance and non-prescriptive areas.

## Rules

### Rules (R#)

- Guidance MUST NOT invent numeric performance thresholds or row-count cut-offs where documentation does not specify them.
- Optimizer-dependent decisions MUST be presented as trade-offs unless authoritative sources provide prescriptive rules.
- Universal step counts or compatibility-window durations MUST NOT be prescribed unless an authoritative source explicitly states them.

## Prohibited patterns

### Prohibited patterns (P#)

- Optimizer-dependent guidance MUST NOT add or enforce rules of the form “when N > X do Y”.
- Quantified performance multipliers or thresholds identified as non-authoritative MUST NOT be stated.
- Expand/contract MUST NOT be presented as a Microsoft-mandated practice unless a Tier-1 source is explicitly cited in DevKit content.
- Thresholds for step counts or compatibility windows MUST NOT be invented.

## Allowed deviations

### Allowed deviations (D#)

- None.

## Cross-references

- .devkit/how-to/sql/measurement-without-thresholds.md
- .devkit/how-to/sql/exists-in-join-selection.md
