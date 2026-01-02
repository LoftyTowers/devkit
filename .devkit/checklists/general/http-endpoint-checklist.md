# HTTP Endpoint Checklist

For any new HTTP endpoint or controller:

- [ ] Maps `Result` / `Result<T>` + `ErrorCode` to HTTP status codes consistently:
  - Validation -> 400
  - Domain -> 422
  - Unexpected -> 500
- [ ] Uses ProblemDetails (or the project's approved central mapping helper) for error responses.
- [ ] Uses the approved validation mechanism for request DTOs and converts validation failures into appropriate 4xx responses.
- [ ] Uses a logging scope that includes:
  - `HttpContext.TraceIdentifier` as CorrelationId
  - Key business identifiers (e.g. UserId, Email, OrderId) when available
- [ ] Never `new`s services; all dependencies are resolved via constructor DI.
- [ ] Tests assert exact HTTP responses for:
  - Success
  - Validation failure
  - Domain failure
  - Cancellation
  - Unexpected errors
  - Exact status codes: 400 (validation), 422 (domain), 500 (unexpected)

If any applicable item in this checklist or the Operational Checklist is not met, update the code and/or tests to comply **before** considering the feature complete.
