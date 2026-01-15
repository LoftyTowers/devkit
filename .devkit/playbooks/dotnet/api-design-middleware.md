# API design and middleware (guidance)

## Minimal APIs vs MVC (R1, D1)
- Prefer Minimal APIs by default for simple HTTP services.
- Use MVC controllers when you need MVC-specific features such as advanced model binding/extensibility, application parts, JSON Patch, OData, or legacy porting constraints.

## Middleware vs MVC filters vs endpoint filters (R5)
- Middleware: cross-cutting, pipeline-wide concerns (logging, authn/authz, global error handling).
- MVC filters: controller/action scoped concerns that only apply to MVC endpoints.
- Endpoint filters: per-endpoint behavior for Minimal APIs; prefer these over MVC filters for Minimal APIs.

## Exception handling posture (P2)
- Do not use MVC exception filters as the primary/global API error mechanism.
- Prefer centralized exception handling middleware that produces ProblemDetails at the HTTP boundary.

## Minimal API limits (P5)
- MVC-only features (filters, action attributes, controller model binding extensibility) do not apply to Minimal APIs.
- Use endpoint filters, middleware, and explicit parameter binding for Minimal APIs.

## Authentication pipeline posture (D4)
- Rely on implicit auth pipeline only when you do not need custom ordering.
- Use explicit `UseAuthentication`/`UseAuthorization` when ordering must be controlled or documented.
