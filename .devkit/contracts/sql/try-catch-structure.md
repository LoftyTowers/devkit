# Try catch structure

## Scope
Authoritative engine rules for TRY…CATCH syntax boundaries and semicolon safety at TRY/CATCH delimiters.

## Rules
- No statement MUST appear between END TRY and BEGIN CATCH.
- A semicolon MUST NOT be inserted between END TRY and BEGIN CATCH.
- The TRY…CATCH construct MAY be terminated with a semicolon after END CATCH.
- BEGIN CATCH MUST NOT be treated as a standalone statement that requires a terminator.

## Prohibited patterns
- `END TRY; BEGIN CATCH`.
- Any statement between END TRY and BEGIN CATCH.

## Allowed deviations
- A semicolon after END CATCH MAY be used as an optional terminator for the TRY…CATCH construct.

## Cross-references
- .devkit/contracts/sql/statement-termination.md