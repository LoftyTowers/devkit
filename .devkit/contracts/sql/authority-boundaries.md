# SQL Server authority boundaries contract

## Scope
Applies to optimizer-dependent guidance and non-prescriptive areas.

## Rules (R#)
- R1: Guidance MUST NOT invent numeric performance thresholds or row-count cut-offs where documentation does not specify them.
- R2: Optimizer-dependent decisions MUST be presented as trade-offs unless authoritative sources provide prescriptive rules.
- R3: MUST NOT prescribe universal step counts or compatibility-window durations unless an authoritative source explicitly states them.

## Prohibited patterns (P#)
- P1: Adding or enforcing "when N > X do Y" rules for optimizer-dependent choices is prohibited.
- P2: Stating quantified performance multipliers or thresholds removed as non-authoritative is prohibited.
- P3: MUST NOT present expand/contract as a Microsoft-mandated practice unless a Tier-1 source is explicitly cited in DevKit content.
- P4: MUST NOT invent thresholds for step counts or compatibility windows.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/how-to/sql/measurement-without-thresholds.md
- .devkit/how-to/sql/exists-in-join-selection.md
