# Security (ASP.NET Core) checklist

## Authentication and token handling
- [ ] JWT validation enforces signature, issuer, audience, expiry, and required claims.
- [ ] Token issuance uses standard OAuth2/OIDC flows only.
- [ ] OIDC flows use built-in middleware with HTTPS, state/nonce, and validated provider claims.

## Authorisation defaults
- [ ] Policy-based authorisation is used for access rules.
- [ ] Authentication is required by default; anonymous access is explicitly declared.

## CORS posture
- [ ] CORS is ordered after routing and before authorisation.
- [ ] CORS allows only explicit trusted origins.
- [ ] AllowAnyOrigin is not used for protected endpoints and not combined with credentials.

## CSRF and cookies
- [ ] Antiforgery validation is enabled for state-changing MVC/Razor Pages when cookies are used.
- [ ] Cookie auth uses Secure and HttpOnly in production.

## Data Protection
- [ ] Data Protection is used for cookies/CSRF tokens (no bespoke crypto).
- [ ] Keys are persisted to a shared secured store for multi-instance/container deployments.
- [ ] Keys are protected at rest and rotated; old keys are not deleted without explicit data-loss acceptance.
- [ ] See `.devkit/how-to/dotnet/data-protection-keys.md`.

## Transport security
- [ ] HTTPS is enforced in production and HSTS is enabled with long max-age and includeSubDomains.
