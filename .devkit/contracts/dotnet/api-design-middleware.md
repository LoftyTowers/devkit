# API design and middleware (ASP.NET Core)

## Scope

ASP.NET Core pipeline ordering and API middleware concerns for HTTP services.

## Rules

- Middleware ordering MUST follow this baseline to keep security and error handling consistent:
  - Exception handling early
  - HTTPS redirection and static files before routing
  - Routing before CORS/auth
  - CORS after routing
  - Authentication before authorisation
  - Endpoint mapping last
  Reason: ordering controls which middleware can observe/short-circuit requests and ensures auth/CORS/error handling run consistently.
- Development: when `UseDeveloperExceptionPage` is used, it MUST be placed early in the pipeline.
- Production: `UseExceptionHandler` MUST be the first/earliest catch-all middleware for downstream exceptions.
- Authentication/authorisation MUST be configured and ordered correctly:
  - Authentication/authorisation services MUST be registered before the app is built.
  - If explicit middleware is used, `UseAuthentication` MUST run before `UseAuthorization`.
  - Endpoints MUST apply policies via `[Authorize]` or `RequireAuthorization` as appropriate.

### Error response mapping

- Controllers/minimal API endpoints MUST return explicit HTTP results for expected outcomes and MUST NOT throw exceptions to produce those outcomes.
- Endpoints MUST NOT return HTTP 200/201 for failure outcomes.
- Web API error responses (HTTP status >= 400) MUST use **ProblemDetails**/**ValidationProblemDetails** (RFC 7807), via framework defaults or an equivalent deterministic formatter.
- SHOULD map `Result` + error category to HTTP responses via a **single central mapping** (e.g., a shared helper) for consistency.
- MUST NOT create ad-hoc status codes per endpoint.
- Endpoints MAY construct **ProblemDetails**/**ValidationProblemDetails** directly using framework helpers (e.g., `Problem`, `ValidationProblem`, `TypedResults`, `Results`), IF they still follow the deterministic mapping rules and RFC 7807 shape, and do not introduce new status codes.
- Validation / bad input / request rule violations -> 400 (ValidationProblemDetails where applicable).
- Not-found -> 404 (ProblemDetails).
- Conflict (business rule conflict, uniqueness, concurrency/state collision) -> 409 (ProblemDetails).
- Unexpected/unhandled -> 500 (ProblemDetails, sanitised).
- Mapping MUST be deterministic. If error codes are used internally, they MUST be stable.
- Endpoints MUST NOT return internal Result/union objects directly; endpoints MUST translate outcomes into DTOs + HTTP results (ProblemDetails on failures).
- Exception handling remains governed by `.devkit/contracts/dotnet/exceptions.md`; this section only defines HTTP boundary mapping.

### Controller responsibilities

- Controllers MUST NOT fabricate business IDs; ID creation is owned by service/domain code.
- Keep controllers/edges thin; delegate to a handler/service.

### Error shape

Error response shape is governed by:
- Error response mapping (this file).
- `.devkit/contracts/dotnet/exceptions.md` (Exception Handling, canonical).

## Prohibited patterns

- Endpoint mapping before CORS/auth middleware MUST NOT occur.
- `UseCors` after endpoints are mapped MUST NOT occur.
- `UseAuthorization` before `UseAuthentication` MUST NOT occur.

## Allowed deviations

- None.

## Cross-references

- None.

