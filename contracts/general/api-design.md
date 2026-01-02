## Error response mapping

- MUST return failures using a consistent **ProblemDetails** response shape (including validation failures).
- MUST map `Result` + error category to HTTP responses via a **single central mapping** (e.g., a shared helper).
- MUST NOT create ad-hoc status codes per endpoint.
- MUST NOT emit ad-hoc `Problem(...)` responses per controller action; use the central mapping.
- Map Validation -> 400, domain failure -> 422, unexpected -> 500.
- Include an error code so mapping is deterministic.

## Controller responsibilities

- Controllers MUST NOT fabricate business IDs; ID creation is owned by service/domain code.
- Keep controllers/edges thin; delegate to a handler/service.
