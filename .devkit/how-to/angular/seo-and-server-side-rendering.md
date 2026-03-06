# Seo and server side rendering

## Procedure: Add hybrid rendering with per-route render modes

### When to use
Use this procedure when you need SSR and/or SSG for public-facing routes and you want explicit control per path.

### Preconditions
- Have an Angular CLI application project and access to run Angular CLI commands.  

### Steps
1. Run `ng add @angular/ssr` in the application workspace.  
2. Create a server routes configuration that assigns a `RenderMode` per route (SSR, SSG, or CSR) using `ServerRoute[]`.  
3. Update the server application configuration to register server routing using `provideServerRendering(withRoutes(...))`.  
4. Set `outputMode` to `static` when you want a fully static build, or set `outputMode` to `server` when you want a server artefact for SSR/hybrid rendering.  
5. Run `ng build --prerender` for SSG output or run `ng build --ssr` for SSR output, depending on the route modes you selected.  

### Validation
- Confirm the build completes successfully and the produced output type matches `outputMode` (`static` vs `server`).  

## Procedure: Enable hydration and event replay

### When to use
Use this procedure when SSR/SSG is enabled and you need interactive pages without DOM flicker.

### Preconditions
- Have SSR/hybrid rendering enabled in the application.  

### Steps
1. Import `provideClientHydration` from `@angular/platform-browser`.  
2. Add `provideClientHydration()` to the provider list used to bootstrap the browser application.  
3. Add the same `provideClientHydration()` call to the provider list used to bootstrap the server application.  
4. Enable event replay by passing `withEventReplay()` into `provideClientHydration(...)` when users can interact before hydration completes.  

### Validation
- Verify the browser console includes hydration-related stats in development mode after loading a server-rendered page.  

## Procedure: Configure prerendering for parameterised routes

### When to use
Use this procedure when you need SSG output for routes that include parameters (for example `product/:id`) and you can enumerate concrete URLs.

### Preconditions
- Have hybrid rendering enabled (SSR tooling installed).  

### Steps
1. Create a plain text file that lists the concrete routes to prerender, one per line (for example `routes.txt`).  
2. Configure the application build `prerender` options to point at that file using `routesFile`, and disable automatic discovery when you need full control using `discoverRoutes: false`.  
3. Run `ng build --prerender` to generate static HTML for the configured routes.  

### Validation
- Confirm the output folder contains static HTML files for each route listed in the routes file.  

## Procedure: Configure HttpClient transfer cache for SSR and hydration

### When to use
Use this procedure when SSR renders data via `HttpClient` and you want to avoid duplicate HTTP requests during client bootstrap.

### Preconditions
- Have hydration enabled via `provideClientHydration()`.  

### Steps
1. Import `withHttpTransferCacheOptions` and pass it as a feature to `provideClientHydration(...)`.  
2. Configure `HttpTransferCacheOptions` to include specific headers and to filter out requests that must not be cached.  
3. Keep the default caching behaviour unless you explicitly need to cache POST requests or requests with authorisation headers.  

### Validation
- Confirm the initial client render does not re-issue cached GET/HEAD requests that were already performed on the server.  

## Procedure: Transfer non-HttpClient state from server to browser using TransferState

### When to use
Use this procedure when you need to pass computed, serialisable values from SSR to the browser without re-computing or re-fetching them.

### Preconditions
- Have SSR/hydration enabled so the server response includes transferred state.  

### Steps
1. Create a typed key using `makeStateKey<T>('your-key')`.  
2. Inject `TransferState` into the service or component that owns the state.  
3. Inject `PLATFORM_ID` and gate server-only writes using `isPlatformServer(platformId)`.  
4. Set the value on the server using `transferState.set(key, value)`.  
5. Read the transferred value in the browser using `transferState.get(key, defaultValue)`.  
6. Remove the key after reading using `transferState.remove(key)` to avoid reusing stale per-request state.  

### Validation
- Confirm the stored value is JSON-serialisable and round-trips without data loss for supported types.  

## Procedure: Set titles and meta tags for SEO and social sharing

### When to use
Use this procedure for public routes that must present correct titles/descriptions and predictable social previews.

### Preconditions
- Have route configuration under your control.

### Steps
1. Add a `title` value to each route definition that represents a real page.  
2. Create a small service that injects Angular's `Title` and `Meta` services.  
3. Set the document title via `Title.setTitle(...)` using the route title (or a computed variant).  
4. Update the page description using `Meta` (for example the `description` named meta tag).  
5. Add Open Graph tags using `property="og:*"` meta tags for `og:title`, `og:description`, and `og:image` where applicable.  
6. Add Twitter Card tags using `name="twitter:*"` meta tags, including `twitter:card`.  

### Validation
- Confirm the server-rendered HTML for a representative route contains the expected `<title>` and meta tags in `<head>`.  

## Procedure: Add JSON-LD structured data to rendered HTML

### When to use
Use this procedure on pages where you want rich-results eligibility driven by structured data.

### Preconditions
- Have a place in your rendering pipeline where you can add HTML to `<head>` for SSR/SSG routes.

### Steps
1. Define a JSON object that represents the structured data you want to expose.  
2. Serialize the object to JSON and emit it in a `<script>` tag with `type="application/ld+json"`.  
3. Insert the script tag into the initial HTML response for the route so crawlers and rich-result tooling can read it.  

### Validation
- Confirm the final HTML contains exactly one `<script type="application/ld+json">` block with valid JSON content.  
