# Security (ASP.NET Core)

## Scope

- Authentication (JWT bearer, cookies)
- OAuth2/OIDC middleware usage
- Authorisation policies and defaults
- CORS posture + middleware ordering
- CSRF / antiforgery (MVC/Razor Pages)
- Data Protection usage + key management requirements
- HTTPS + HSTS
- See `.devkit/contracts/general/security-baseline.md` for secret handling.

## Rules

- JWT bearer auth MUST validate signature, issuer (iss), audience (aud), and expiry (exp); tokens missing required claims MUST be rejected.
- Token issuance MUST use standard OAuth 2.0 / OpenID Connect flows; code MUST NOT mint tokens from raw credentials or ad-hoc mechanisms.
- External/OIDC login flows MUST use built-in middleware, MUST run over HTTPS, MUST use state/nonce, and provider tokens/claims MUST be validated.
- Authorisation MUST use policy-based authorisation (requirements/handlers) rather than scattered role checks.
- Authentication MUST be required by default (fallback policy); anonymous access MUST be explicitly declared.
- CORS MUST be configured in the correct middleware order (after routing, before authorisation), and policies MUST allow only explicit trusted origins.
- CORS policies MUST be registered in services and referenced by name when applied.
- CORS MUST NOT use AllowAnyOrigin (*) for protected endpoints and MUST NOT combine AllowAnyOrigin with credentials.
- MVC/Razor Pages state-changing form posts MUST validate antiforgery tokens when cookies are used (prefer global auto-validation).
- Cookie-based auth MUST set Secure and HttpOnly in production.
- Cryptographic protection needs (cookies, CSRF tokens, etc.) MUST use ASP.NET Core Data Protection; bespoke crypto MUST NOT be used for these concerns.
- Data Protection keys MUST be persisted to a shared secured store for multi-instance/container deployments; key material MUST be protected at rest with restricted access; keys MUST rotate; old keys MUST NOT be deleted unless data loss is accepted.
- Production deployments MUST enforce HTTPS and enable HSTS with a long max-age and includeSubDomains; preload SHOULD be considered where appropriate.
Note: Pipeline ordering and related prohibitions are defined in `.devkit/contracts/dotnet/api-design-middleware.md`.

## Prohibited patterns

- Accepting JWTs without validating signature, issuer, audience, and expiry MUST NOT occur.
- Custom token issuance outside standard OAuth/OIDC flows MUST NOT occur.
- CORS MUST NOT be used as a substitute for authentication/authorisation.
- AllowAnyOrigin (*) for a protected endpoint or AllowAnyOrigin with AllowCredentials MUST NOT be used.
- Cookie auth without Secure and HttpOnly protections in production MUST NOT occur.
- Ephemeral/in-memory Data Protection keys in multi-instance/container environments MUST NOT be used.
- Deleting Data Protection keys without explicitly accepting unrecoverable protected data MUST NOT occur.
- Missing antiforgery validation for unsafe form posts in cookie-auth web apps MUST NOT occur.
- Skipping HTTPS/HSTS in production without an explicit risk decision MUST NOT occur.

## Allowed deviations

- None.

## Cross-references

- None.
