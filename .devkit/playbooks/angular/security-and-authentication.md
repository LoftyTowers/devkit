# Security and authentication

## Context
Angular provides built-in defences against common web attacks such as cross-site scripting (XSS) and cross-site request forgery (CSRF/XSRF), but these protections need correct usage and correct integration with your server.  

XSS is especially high impact because injected script can steal user and login data or impersonate user actions; Angular reduces risk by treating bound values as untrusted by default and sanitising/escaping values in template bindings.  

Authentication and authorisation in the client are mainly about consistent request handling (HTTP interceptors), consistent navigation control (route guards), and safe token handling. Interceptors and guards improve consistency and user experience, but they do not replace server-side authorisation.  

## Guidance
- Prefer template bindings and interpolation for rendering user-controlled data, and rely on Angular sanitisation rather than manual DOM writes.  
- Avoid patterns that treat templates as data (for example, building templates by concatenating user input and template syntax); keep templates as trusted code.  
- Use `DomSanitizer.sanitize` with the correct `SecurityContext` when you cannot avoid binding into sensitive DOM contexts, and treat any "trusted value" construction as security-critical code review.  
- Configure a nonce-based Content Security Policy (CSP) at the server and pass the nonce into Angular (via `autoCsp`, `ngCspNonce`, or `CSP_NONCE`) so Angular can render `<style>` elements under CSP.  
- Ensure CSP nonces are unique per request and not predictable; nonce predictability breaks CSP's protection model.  
- Enable Trusted Types enforcement with the Angular policies (`trusted-types angular; require-trusted-types-for 'script'`) to add defence-in-depth against DOM XSS sinks.  
- Use Angular's built-in HttpClient XSRF mechanism when you use cookie-based authentication, and coordinate with the server to set the XSRF cookie and validate the XSRF header; the client-side helper alone does not secure you.  
- Keep auth header logic inside a single interceptor so you can apply it consistently and avoid scattering token logic across services and components.  
- Apply route guards to protect navigation flows (authenticated routes, role-gated routes, feature-flag routes), but treat guards as a client-side convenience and enforce authorisation decisions on the server as well.  
- When using JWTs, treat the token contents as non-authoritative until the server validates the token cryptographically and checks context-bound claims such as audience and expiry.  
- Prefer HTTPS for all app and API traffic to prevent network tampering and passive eavesdropping (including on scripts, cookies, and HTML).  
- Use Angular form validation for immediate feedback and data quality on the client, but treat it as UX and always validate and sanitise on the backend.  

## Trade-offs
- Cookie-based session identifiers reduce exposure to JavaScript when you use `HttpOnly`, but cookies are automatically attached to requests and so you need explicit CSRF defences (XSRF token header and/or `SameSite` controls).  
- CSRF protection in Angular's model needs a JavaScript-readable XSRF token cookie so the client can read it and add a custom header; this means the XSRF token cookie itself is not `HttpOnly`, even if your session cookie is.  
- Strict CSP (nonces/hashes) and Trusted Types add strong defence-in-depth against XSS, but they require correct header configuration and correct nonce propagation on every request.  
- Client-side guards improve routing safety and user experience, but they cannot provide true access control because browser JavaScript can be modified by the user.  

## Decision criteria
- Choose cookie-based auth when you can configure cookie attributes (`Secure`, `HttpOnly`, `SameSite`) and you can implement server validation for CSRF (XSRF token header matching a server-issued token).  
- Choose nonce-based CSP when you can generate a per-request nonce and pass it into Angular via `autoCsp`, `ngCspNonce`, or `CSP_NONCE`.  
- Choose Trusted Types enforcement when you want a DOM-level control that blocks dangerous string-to-DOM sinks and simplifies audit boundaries for XSS.  
- Choose JWT-based access control only when the server validates cryptographic integrity and verifies claim constraints such as `aud` and `exp` for the target system.  

## Preferences
- PREFERENCE — JUSTIFIED: Prefer functional HTTP interceptors over DI-based interceptors for predictable behaviour and simpler configuration.  
- PREFERENCE — JUSTIFIED: Prefer enabling Trusted Types enforcement alongside Angular's sanitisation to reduce DOM XSS risk at the platform level.  
- PREFERENCE — JUSTIFIED: Prefer session cookies that include `Secure` and `HttpOnly` for session identifiers, and use `SameSite` as the default cross-site control.
