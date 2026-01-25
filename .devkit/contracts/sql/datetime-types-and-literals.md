# Datetime types and literals

## Scope
Authoritative rules for SQL Server datetime type selection, precision, and safe literal/parsing requirements.

## Rules
- New datetime columns MUST use `datetime2(n)` rather than `datetime`.
- Datetime precision MUST be explicit (for example `datetime2(0)`, `datetime2(3)`, or `datetime2(7)`).
- Ambiguous datetime string formats MUST NOT be used.
- When a datetime string literal is used, it MUST be ISO 8601 and MUST use an explicit style in `CONVERT`.
- Operational timestamps MUST be stored in UTC.
- `datetimeoffset` MUST be used when the UTC offset itself is required for correctness.

## Prohibited patterns
- Using `datetime` for new schema or new values where `datetime2(n)` is available.
- Using `datetime2` without explicit precision.
- Using locale-dependent datetime strings (for example `01/02/2026`).
- Using implicit parsing (for example `CAST('2026-01-05T00:00:00' AS datetime2)` in shared scripts) where explicit style can be used.
- Storing operational timestamps in local time without a clear, documented reason.

## Allowed deviations
- A project MAY choose a single repo-wide default precision (for example `datetime2(0)` or `datetime2(3)`), provided it is documented and used consistently.

## Cross-references
- .devkit/playbooks/sql/datetime-construction-and-parsing.md
- .devkit/how-to/sql/datetime-literal-construction.md
- .devkit/how-to/sql/datetime-parsing-iso8601.md