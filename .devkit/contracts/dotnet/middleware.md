# Middleware

## Scope

- Middleware expectations for centralized exception handling in HTTP pipelines.

## Rules

- Central exception handling middleware/filters MUST convert unhandled exceptions into HTTP 5xx **ProblemDetails** responses (sanitised; no sensitive internals).

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
