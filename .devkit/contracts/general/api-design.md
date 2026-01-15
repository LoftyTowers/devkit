## Error response mapping

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

## Controller responsibilities

- Controllers MUST NOT fabricate business IDs; ID creation is owned by service/domain code.
- Keep controllers/edges thin; delegate to a handler/service.
