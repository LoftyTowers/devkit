# Security (ASP.NET Core) guidance

## Secure headers (R13)
- Baseline headers: `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`.
- CSP is app-specific and must be tailored; start with a restrictive policy and open only what the app requires.

## Deviations
### D1: Bearer-token-only APIs
- For APIs that use bearer tokens and no cookies, antiforgery/CSRF tokens are generally not applicable; rely on token validation.

### D2: Public unauthenticated APIs
- If an API is truly public and uses no auth and no cookies, CORS wildcard (*) may be acceptable; otherwise restrict origins.

## Practical examples and pitfalls
- JWT bearer validation: require issuer, audience, expiry, and signature validation.
- OIDC middleware: use built-in middleware with HTTPS, state, and nonce; validate provider claims.
- Middleware order: apply CORS after routing and before authn/authz.
- Antiforgery: prefer global auto-validation for MVC/Razor Pages when cookies are used.
- HTTPS/HSTS: enforce HTTPS in production; use long max-age and includeSubDomains, and roll out preload only when ready.
