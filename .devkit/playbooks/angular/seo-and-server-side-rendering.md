# Seo and server side rendering

## Context
This area governs how Angular routes render their initial HTML for users, search crawlers, and link unfurlers. CSR can delay visible content until JavaScript runs, while SSR and SSG deliver full HTML earlier, which affects SEO and first-load behaviour.

Angular supports hybrid rendering so you can choose CSR, SSR, or SSG per route using server route configuration. This lets you balance SEO needs, server cost, and content freshness per URL.

Hydration makes SSR/SSG output interactive by reusing the server-rendered DOM. It improves performance and reduces flicker, but it requires the server and client DOM structures to match and imposes constraints on DOM manipulation and whitespace handling.

## Guidance
- Organise routes by rendering strategy based on whether content is public, indexable, and stable across users.  
- Prefer SSG for routes with content that is the same for all users and changes infrequently, because SSG pre-renders static HTML at build time and serves it as static files.  
- Prefer SSR for routes that need fresh or per-user/per-request content, because SSR renders HTML on the server for each request and then hydrates in the browser.  
- Use the server route rendering modes (`RenderMode.Server`, `RenderMode.Prerender`, `RenderMode.Client`) to make per-path decisions explicit and reviewable.  
- Avoid direct DOM manipulation and avoid browser-only globals in code paths that can execute during SSR/SSG, because the server environment does not provide browser APIs and hydration expects consistent DOM output.  
- Put page titles into route definitions using the router's `title` support so titles update automatically on navigation and stay aligned with routing.  
- Manage `<meta>` tags through Angular's `Meta` service so you update tags via a single API rather than hand-editing HTML.  
- Use Open Graph meta tags to control social previews, and encode them using `property="og:*"` attributes.  
- Use Twitter Card tags using `name="twitter:*"` meta tags (not `property`) so Twitter can recognise them correctly.  
- Add structured data when you need eligibility for rich results; structured data is a requirement for rich results eligibility in Google Search contexts.  
- Emit JSON-LD using the registered media type `application/ld+json` and keep the payload valid JSON, since JSON-LD is a JSON-based serialisation for linked data and `application/ld+json` is the registered media type for it.  
- Use Angular's built-in hydration HTTP transfer cache for SSR/hydration to avoid duplicate HTTP requests during initial client rendering.  
- Configure HTTP transfer caching with `withHttpTransferCacheOptions` when you need to control headers, filter requests, or opt in to caching POST/auth requests.  
- NO PRIMARY SUPPORT — SECONDARY ONLY: Reference your sitemap from `robots.txt` using an absolute URL when you include it, to avoid invalid sitemap directives.  

## Trade-offs
- CSR keeps server needs minimal and is simplest to run, but SEO is poor because content is not visible to crawlers until JavaScript executes.  
- SSG gives excellent SEO and the fastest initial HTML delivery, but build time increases and content updates require rebuilding and redeploying.  
- SSR gives excellent SEO with dynamic content, but it requires a server runtime and imposes constraints on code that depends on browser APIs.  
- Hydration reduces DOM re-creation and prevents flicker, but it can fail if templates alter DOM structure directly or if server/browser whitespace handling differs.  

## Decision criteria
- Choose SSG when content is public, indexable, and stable across users, and you can accept rebuilds for updates.  
- Choose SSR when content must be fresh per request or depends on per-user state and you can operate a server runtime.  
- Choose hybrid rendering when the app has mixed requirements and you want different strategies per route.  

## Preferences
- PREFERENCE — JUSTIFIED: Prefer defining page titles on routes and (only if needed) customising behaviour via `TitleStrategy`, rather than setting titles ad hoc in components.  
- PREFERENCE — JUSTIFIED: Prefer generating Open Graph and Twitter Card tags in server-rendered HTML for public routes so link unfurlers can read metadata directly from the initial response.  
- PREFERENCE — JUSTIFIED: Prefer using `withHttpTransferCacheOptions({ filter: ... })` to narrowly control SSR transfer caching before enabling `includePostRequests` or `includeRequestsWithAuthHeaders`.
