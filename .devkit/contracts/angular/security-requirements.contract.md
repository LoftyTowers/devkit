# Security Requirements Contract

## Scope
This contract covers Angular application security requirements for XSS protection, sanitization, CSP, CSRF handling, interceptors, guards, transport security, and input validation. It defines required patterns for secure HTTP requests, routing protection, and safe handling of user input and file uploads.

## Rules
- Angular applications MUST rely on Angular's automatic XSS protection for templates. Angular automatically escapes values in interpolation {{ }} and property bindings [property]="value". Untrusted values rendered as text, not executable code.
- Angular applications MUST use Angular's built-in sanitization for all supported security contexts. Angular sanitizes untrusted values in HTML, style, URL, resource URL contexts automatically. Each context has different sanitization rules.
- DomSanitizer MUST be used only for trusted content and only with the appropriate SecurityContext. When binding to innerHTML or bypassing sanitization, use DomSanitizer.sanitize() with appropriate SecurityContext for content verification.
- Applications MUST implement Content Security Policy headers at the server level. Configure CSP headers at server level to restrict resource loading sources. Use nonces or hashes for inline scripts/styles in strict CSP.
- Applications SHOULD enable Trusted Types for additional XSS protection. Configure Trusted Types API to prevent DOM XSS by requiring typed values for dangerous sinks. Angular supports Trusted Types automatically.
- Angular applications MUST use HttpClient to enable automatic CSRF protection. HttpClient reads XSRF-TOKEN cookie and sends as X-XSRF-TOKEN header on mutating requests (POST, PUT, DELETE, PATCH).
- Backends MUST set the XSRF-TOKEN cookie with HttpOnly set to false, Secure set to true, and SameSite set to Strict or Lax. Backend must set cookie with HttpOnly=false, Secure=true, SameSite=Strict or Lax.
- State-changing operations MUST use POST, PUT, DELETE, or PATCH requests. GET requests should never modify state. Angular only sends CSRF tokens with mutating HTTP methods.
- Applications MUST use functional interceptors to modify HTTP requests and responses. Create HttpInterceptorFn functions to intercept and modify HTTP requests/responses. Register with withInterceptors().
- Authentication headers MUST be added via HTTP interceptors. Clone requests in interceptors to add Authorization headers centrally instead of per-request.
- HTTP interceptors MUST handle authentication errors. Use catchError in interceptors to detect 401/403 responses and trigger re-authentication or redirects.
- HTTP interceptors MUST be registered in the application configuration. Provide interceptors using provideHttpClient(withInterceptors([...])) in app.config.ts.
- HTTP requests MUST be cloned before modification in interceptors. HttpRequest is immutable. Use req.clone({ ... }) to create modified copies.
- Applications MUST use functional guards for route protection. Create CanActivateFn, CanDeactivateFn functions instead of class-based guards.
- Route guards MUST return a boolean or a UrlTree. Guards return true, false, or UrlTree. Avoid imperative router.navigate().
- CanActivate MUST be used to enforce access control. Implement CanActivateFn to check permissions before activating route.
- CanDeactivate SHOULD be used to warn about unsaved changes. Implement CanDeactivateFn to prompt users before leaving route with unsaved form data.
- Services MUST be injected into functional guards using inject(). Use inject() function within guard to access services.
- Production applications MUST use HTTPS for all API communication. Production applications must communicate over HTTPS.
- Servers MUST configure the Strict-Transport-Security header. Strict-Transport-Security header forces browsers to use HTTPS.
- SSL and TLS certificate validation MUST be enforced in production. Never disable certificate validation in production. Use valid certificates from trusted CAs.
- All input MUST be validated on the server. Client-side validation is UX enhancement; server-side validation is security boundary.
- Angular forms SHOULD be used for client-side validation. Implement validators in reactive or template-driven forms.
- User input displayed in templates MUST be sanitized using Angular's automatic escaping. Use Angular's automatic escaping for user-generated content display.
- Typed APIs MUST be used instead of string concatenation to prevent injection. Use HttpParams, Router with typed parameters instead of string concatenation.
- File uploads MUST be validated on the server. Check file type, size, content on server. Client-side checks bypassable.

## Prohibited patterns
- Untrusted content MUST NOT be bound directly to innerHTML. Direct innerHTML binding with user content allows script injection. Use interpolation or sanitize explicitly.
- bypassSecurityTrust methods MUST NOT be used without documentation of a security review. Bypass methods disable Angular's protections. Use only for verified trusted content with security review documentation.
- HTML MUST NOT be constructed from user input using string concatenation. Building HTML strings from user input creates XSS vulnerabilities. Use Angular's data binding which automatically escapes.
- Content Security Policy configurations MUST NOT disable CSP or use unsafe directives. 'unsafe-inline', 'unsafe-eval' in CSP defeat XSS protections. Use nonces or hashes instead.
- GET requests MUST NOT be used for state modifications. GET without CSRF protection vulnerable to CSRF attacks via links, images, or malicious sites.
- The XSRF-TOKEN cookie MUST NOT be set as HttpOnly. HttpOnly=true prevents Angular from reading cookie to send as header, breaking CSRF protection.
- Backends MUST NOT accept requests without validating CSRF tokens. Frontend CSRF tokens meaningless without backend validation. Backend must verify token matches cookie.
- Applications MUST NOT use fetch or XMLHttpRequest instead of HttpClient for HTTP requests. Direct fetch/XHR bypasses Angular's automatic CSRF protection. Always use HttpClient.
- HttpRequest objects MUST NOT be mutated directly. HttpRequest immutable; direct property modification throws errors or has no effect.
- Authentication headers MUST NOT be added in individual service methods. Duplicated header logic error-prone and hard to maintain. Centralize in interceptors.
- Interceptor errors MUST NOT be left unhandled. Interceptor errors propagate to all requests; unhandled errors break entire HTTP layer.
- Class-based interceptors MUST NOT be used for new code. Class-based interceptors legacy pattern. Use functional interceptors.
- Imperative navigation MUST NOT be used in route guards. Calling router.navigate() and returning boolean creates race conditions.
- Route guards MUST NOT perform side effects beyond authorization checks. Guards should only check permissions, not load data or modify state.
- Route guards SHOULD NOT be left untested. Untested guards create security vulnerabilities.
- Class-based route guards MUST NOT be used for new code. Class-based guards legacy pattern. Use functional guards.
- HTTP MUST NOT be used in production environments. Unencrypted HTTP exposes sensitive data to interception.
- Certificate validation MUST NOT be disabled. Disabling validation allows man-in-the-middle attacks.
- Invalid certificates MUST NOT be accepted in production. Catching and ignoring certificate errors defeats TLS security.
- Applications MUST NOT rely solely on client-side validation. Client validation easily bypassed. Server must validate independently.
- String concatenation MUST NOT be used for URL or query construction. Manual string building vulnerable to injection.
- File uploads MUST NOT be accepted without validation. Unvalidated uploads enable malware distribution and attacks.
- Raw user input MUST NOT be displayed without escaping. Raw user content may contain malicious scripts.

## Allowed deviations
- bypassSecurityTrustHtml MAY be used for admin-controlled content from trusted internal sources with a security review. Content from trusted internal sources (admin CMS with input sanitization) may use bypass with security review.
- Applications MAY configure custom CSRF cookie and header names using withXsrfConfiguration() when required. Use withXsrfConfiguration() to customize cookie name and header name if backend uses non-default values.
- Interceptor ordering MAY be used to control execution order where required. Interceptors execute in order provided. Auth interceptor should run before logging; retry before error handling.
- CanMatch MAY be used for conditional route configuration. CanMatchFn determines if route config matches URL.
- Route guards MAY return an Observable or a Promise resolving to a boolean or UrlTree. Guards can return Observable<boolean | UrlTree> or Promise<boolean | UrlTree>.
- HTTP MAY be used for local development only. HTTP acceptable for localhost development only, never production.

## Cross-references