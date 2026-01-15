# SQL Server authority boundaries contract

## Scope
Applies to optimizer-dependent guidance and non-prescriptive areas.

## Rules (R#)
- R1: Guidance MUST NOT invent numeric performance thresholds or row-count cut-offs where documentation does not specify them.
- R2: Optimizer-dependent decisions MUST be presented as trade-offs unless authoritative sources provide prescriptive rules.

## Prohibited patterns (P#)
- P1: Adding or enforcing "when N > X do Y" rules for optimizer-dependent choices is prohibited.
- P2: Stating quantified performance multipliers or thresholds removed as non-authoritative is prohibited.

## Allowed deviations (D#)
- None.

## Cross-references
- .devkit/how-to/sql/measurement-without-thresholds.md
- .devkit/how-to/sql/exists-in-join-selection.md
