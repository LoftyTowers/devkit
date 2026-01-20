# Swagger / OpenAPI

## Scope

Applies when generating an HTTP API that exposes endpoints.

## Rules

- MUST include `Swashbuckle.AspNetCore` as a `<PackageReference>`.
- MUST call `AddSwaggerGen()` during service registration.
- MUST enable Swagger middleware via `UseSwagger()` and `UseSwaggerUI()` in `Program.cs`.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
