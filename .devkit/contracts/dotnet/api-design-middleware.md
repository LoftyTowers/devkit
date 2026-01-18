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

### Error shape

Error response shape is governed by:
- `.devkit/contracts/general/api-design.md` — “Error response mapping”
- `.devkit/contracts/dotnet/exceptions.md` — “Exception Handling (canonical)”

## Prohibited patterns

- Endpoint mapping before CORS/auth middleware MUST NOT occur.
- `UseCors` after endpoints are mapped MUST NOT occur.
- `UseAuthorization` before `UseAuthentication` MUST NOT occur.

## Allowed deviations

- None.

## Cross-references

- None.
