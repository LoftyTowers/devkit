# HTTP Endpoint Checklist

For any new HTTP endpoint or controller:

- [ ] Maps `Result` / `Result<T>` + `ErrorCode` to HTTP status codes consistently:
  - Validation -> 400
  - Domain -> 422
  - Unexpected -> 500
- [ ] Uses ProblemDetails (or the project's approved central mapping helper) for error responses.
- [ ] Uses the approved validation mechanism for request DTOs and converts validation failures into appropriate 4xx responses.
- [ ] Middleware ordering follows `.devkit/contracts/dotnet/api-design-middleware.md` (prevents auth/CORS bypass and ensures exception handling runs early).
- [ ] CORS is applied before endpoint mapping (avoids preflight/route bypass; `UseCors` after routing or endpoint-level `RequireCors`).
- [ ] Authn/authz order is correct (`UseAuthentication` before `UseAuthorization`) to ensure policies evaluate with an identity.
- [ ] An operation logging scope exists at the HTTP boundary (middleware or endpoint, as defined by the Logging
      contract) and includes:
  - `HttpContext.TraceIdentifier` (or equivalent) as CorrelationId
  - Key business identifiers (e.g. UserId, Email, OrderId) when available
  The endpoint handler MUST NOT open an additional routine scope if the host already opens the boundary scope.
- [ ] Never `new`s services; all dependencies are resolved via constructor DI.
- [ ] Tests assert exact HTTP responses for:
  - Success
  - Validation failure
  - Domain failure
  - Cancellation
  - Unexpected errors
  - Exact status codes: 400 (validation), 422 (domain), 500 (unexpected)

If any applicable item in this checklist or the Operational Checklist is not met, update the code and/or tests to comply **before** considering the feature complete.
