# Validation

## Scope

- Input validation placement and edge validation approach.

## Rules

### Edge validation

- MUST perform input validation at the edge of the system:
  - HTTP: use the approved validation mechanism on request DTOs.
  - Messaging: validate incoming messages before acting.
  - Workers/CLI: validate arguments before doing work.
- MUST treat validation failure as an error outcome:
  - HTTP: return a 4xx response with a structured body.
  - Non-HTTP: return or emit an outcome (result/event/state) that explicitly indicates validation failure.
- SHOULD NOT duplicate validation rules across layers without a documented reason.
  - If a validator guarantees basic shape (e.g., email syntax), downstream handlers MAY assume that shape.

### Validation principles

- SHOULD keep validation rules close to the DTO/request model and fail fast.
- MUST NOT use exceptions for control-flow validation.
- SHOULD aggregate errors for 400 responses.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
