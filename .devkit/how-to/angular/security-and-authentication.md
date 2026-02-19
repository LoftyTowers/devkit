# Security and authentication

## Procedure: Add a functional auth header interceptor

### When to use
Use this procedure when the client must attach an authentication token to HTTP requests in a consistent way.

### Preconditions
- Have an `AuthService` (or equivalent) that returns the current auth token synchronously or asynchronously in a way your interceptor can use.  

### Steps
1. Create an interceptor function that clones requests and adds the authentication header.  
2. Inject your `AuthService` inside the interceptor using `inject(...)`.  
3. Add a URL filter so the interceptor only adds auth headers to requests targeting your API.  
4. Register the interceptor in the root `provideHttpClient(...)` call using `withInterceptors([...])`.  

### Validation
- Verify a request to the API includes the expected authentication header in the browser network inspector.  
- Verify a request to a non-API URL does not include the authentication header.  

## Procedure: Configure HttpClient XSRF token names to match the backend

### When to use
Use this procedure when the backend uses non-default cookie or header names for CSRF/XSRF tokens.

### Preconditions
- Have backend behaviour that sets an XSRF token cookie and validates the matching request header on state-changing requests.  

### Steps
1. Confirm the backend sets an XSRF token in a JavaScript-readable cookie (default name: `XSRF-TOKEN`).  
2. Configure `provideHttpClient(withXsrfConfiguration({ cookieName, headerName }))` in the root application providers.  
3. Keep requests state-changing (for example `POST`) on relative or same-origin URLs when you expect Angular to attach the XSRF header automatically.  
4. Keep the server-side validation in place; treat missing server validation as a failure state.  

### Validation
- Verify a same-origin `POST` request includes the configured XSRF header (default header: `X-XSRF-TOKEN`) once the cookie is present.  
- Verify the backend rejects the equivalent request when the XSRF header is missing or does not match the cookie token.  

## Procedure: Add a route guard for authenticated navigation

### When to use
Use this procedure when navigation must be blocked or redirected unless a user is authenticated (or has a specific role).

### Preconditions
- Have server-side authorisation enforcement for the same protected resources; client route guards do not provide real access control.  

### Steps
1. Generate a guard file with the Angular CLI or create one manually.  
2. Implement a guard that returns `true` for allowed navigation and returns a `UrlTree` (or redirect command) for denied navigation.  
3. Inject your auth/roles service inside the guard using `inject(...)`.  
4. Apply the guard to routes using `canActivate`, `canActivateChild`, or `canMatch` as appropriate.  

### Validation
- Verify the route configuration contains the guard in the relevant `canActivate`/`canActivateChild`/`canMatch` array.  
- Verify blocked navigation results in a redirect via `UrlTree` rather than a `false` return followed by manual navigation.  

## Procedure: Integrate a nonce-based CSP with Angular using ngCspNonce

### When to use
Use this procedure when you deploy with a nonce-based CSP and Angular must render styles under that policy.

### Preconditions
- Have server-side templating (or equivalent) that can inject the same nonce into both the CSP response header and the HTML root element.  

### Steps
1. Configure the server to return a CSP header that includes a per-request nonce for `style-src` (and, if needed, `script-src`).  
2. Generate a new nonce for every request and prevent nonce predictability.  
3. Add the `ngCspNonce` attribute to the root application element in the HTML response, using the same nonce value as the header.  
4. Load the application and confirm Angular can insert `<style>` elements without CSP violations.  

### Validation
- Verify the response contains `Content-Security-Policy` with `style-src 'nonce-…'` and `default-src 'self'` (or your approved baseline).  
- Verify Angular-generated `<style>` elements include the expected nonce value.  

## Procedure: Add client-side form validation for security-sensitive inputs

### When to use
Use this procedure for sign-in, registration, password change, and other security-sensitive data entry flows.

### Preconditions
- Have backend validation and sanitisation; client-side validation is not a security boundary.  

### Steps
1. Add built-in validators (`required`, `minlength`, etc.) either as template attributes or as `Validators.*` functions in reactive forms.  
2. Add any custom validators needed for your business rules as validator functions or validator directives.  
3. Display validation errors only when controls are invalid and the user has interacted (`dirty` or `touched`).  
4. Validate and sanitise the same input again on the backend before processing or persisting it.  

### Validation
- Verify invalid inputs produce form control errors (`required`, `minlength`, or custom keys) and block submission until corrected.  
- Verify the backend rejects invalid or malicious input even when the client is bypassed.
