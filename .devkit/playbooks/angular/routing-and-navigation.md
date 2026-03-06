# Routing and navigation

## Context
Routes are objects that map URL paths (including parameters and wildcards) to routed content and routing behaviour. Organise this configuration so engineers can predict what renders for a URL and how navigation behaves.  

Router outlets are the rendering targets for routed content, and the router exposes navigation lifecycle events so you can add observable, testable behaviours (loading, analytics, error feedback) around navigation.  

## Guidance
- Organise route definitions in dedicated route files (for example `app.routes.ts`), and keep a single exported `Routes` constant as the entry point for each route set.  
- Structure nested navigation by placing child routes under `children` and rendering them through a second `<router-outlet>` in the parent routed component.  
- Use named outlets for secondary routes when a page needs multiple routed regions at once, and bind each secondary route with the route `outlet` property.  
- Keep outlet names stable and explicit because outlet names must be unique and cannot be set or changed dynamically.  
- Use `loadComponent` to lazy-load a component at the point the route activates, and use `loadChildren` to lazy-load child routes during route matching when the route needs a child route tree.  
- Use dynamic `import()` in `loadComponent` / `loadChildren` loader functions so the loader returns a `Promise` that resolves to the component or route set.  
- Use injection-context lazy loading when loaders need route-scoped providers (for example call `inject()` inside the loader to select which component/module/routes to load).  
- Use route-level `providers` when a route subtree needs dependencies scoped to that route (instead of making them global).  
- Choose guard types by the decision point: `canActivate` for route access, `canActivateChild` to protect a whole child subtree, `canDeactivate` to prevent leaving (for example unsaved forms), and `canMatch` to decide whether a route matches during path matching.  
- Order multiple guards intentionally because guards run in the order they appear in the route configuration arrays.  
- Use data resolvers (`ResolveFn`) for essential data that must exist before the component renders, and access resolved values through `ActivatedRoute` data (or pass them as component inputs with `withComponentInputBinding`).  
- Handle resolver failures in a repeatable way (for example centralise with `withNavigationErrorHandler`, or handle `NavigationError` from router events) so users get a defined error experience.  
- Use route parameters for required identity in the path, and use query parameters for optional UI state such as filtering, sorting, and pagination.  
- Treat query parameters as reactive inputs because they are optional and can change without triggering route navigation.  
- Read route state as snapshots when you need point-in-time values, and use `ActivatedRoute` observables when the component must react to changes over time.  
- Subscribe to `Router.events` when you need deterministic hooks into navigation (loading indicators, analytics, resolver phase visibility), and enable `withDebugTracing()` when you need to see the event sequence while debugging.  
- Prefer template navigation using `RouterLink`; use `router.navigate()` for programmatic navigation with segments (including relative navigation with `relativeTo`), and use `router.navigateByUrl()` when you already have a full URL string.  
- When configuring redirect routes, `pathMatch: 'prefix'` can be appropriate when you intend to redirect a path and all of its subpaths. Ensure the resulting behaviour matches your routing design expectations.

## Trade-offs
- Lazy loading reduces initial JavaScript but adds future network requests; nested lazy loading at multiple levels can amplify navigation delays and hurt perceived performance.  
- Preloading reduces the "first visit" delay for lazy routes but increases bandwidth and memory usage; aggressive preloading can compete with other critical requests and run into browser connection limits.  
- Data resolvers remove component-level loading states for critical data but block navigation while they run; without explicit navigation feedback, users see a delay between clicking and content rendering.  
- `canMatch` falls through to try other matching routes when it returns `false`, which enables clean fallback routing but changes semantics versus guards that block navigation outright.  

## Decision criteria
- Choose eager routes for primary landing pages that need immediate availability; choose lazy routes for secondary areas where reducing the initial bundle size matters more than the first navigation into that area.  
- Choose `PreloadAllModules` when the app is small-to-medium and background downloading all lazy modules is acceptable; choose no preloading (default) or selective preloading when bandwidth and memory pressure matter.  
- Choose a custom `PreloadingStrategy` when only specific routes should preload (for example based on route metadata) and when you need predictable control over what preloads.  
- Choose data resolvers when the page cannot function without a small set of essential data and you want the router to wait for it; choose in-component fetching when partial rendering is acceptable and blocking navigation is not.  
- Choose `canMatch` when you need conditional route matching (feature flags, A/B tests, conditional route loading, or different components for the same path); choose `canActivate` when you want to gate access to a matched route (typical auth/authorisation).  
- Choose route parameters for required identifiers and route structure; choose query parameters for optional state that can vary without changing the routed component (filters, sorting, pagination).  

## Preferences
- PREFERENCE — JUSTIFIED: Prefer relative `routerLink` paths inside routed feature areas to keep links maintainable when route hierarchies change.  
- PREFERENCE — JUSTIFIED: Prefer `loadComponent` for lazy-loading standalone page components when the route does not need a child route tree, to keep the lazy boundary small and explicit.  
- PREFERENCE — JUSTIFIED: Prefer consuming resolved data via `withComponentInputBinding()` when the component only needs resolver outputs, to avoid injecting `ActivatedRoute` solely for data access and to keep input typing explicit.  
- PREFERENCE — JUSTIFIED: Prefer `paramMap` / `queryParamMap` when you want `ParamMap` access semantics (for example `get()` and multi-value support) instead of indexing into raw parameter objects.
