# Swagger / OpenAPI

When generating an HTTP API that exposes endpoints:

- MUST include `Swashbuckle.AspNetCore` as a `<PackageReference>`.
- MUST call `AddSwaggerGen()` during service registration.
- MUST enable Swagger middleware via `UseSwagger()` and `UseSwaggerUI()` in `Program.cs`.
