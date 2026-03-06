# Routing and navigation

## Procedure: Create nested routes with a feature-level outlet

### When to use
Use this when one area of a screen (a panel, tabset, or sub-page) changes based on the URL while the surrounding layout stays in place.  

### Preconditions
- Ensure the application has a root `<router-outlet>` and the router is configured (for example through `provideRouter`).  

### Steps
1. Define a parent route with a `children` array that contains child `path` + `component` route objects.  
2. Add a `<router-outlet />` element to the parent component template so child routes have a render target, and import `RouterOutlet` in that standalone component (or equivalent setup).  
3. Add child navigation links in the parent template using `routerLink` values that target the child paths (for example `routerLink="profile"` inside `/settings`).  

### Validation
- Navigate to a child URL (for example `/settings/profile`) and confirm the parent component content remains while the child component renders inside the nested outlet.  


## Procedure: Add a CanDeactivate guard for unsaved changes

### When to use
Use this when leaving a route risks losing user work (for example an edit form).  

### Preconditions
- Ensure the deactivated component can expose a boolean decision (for example a `hasUnsavedChanges()` method) that the guard can evaluate.  

### Steps
1. Run `ng generate guard <name>` and select the `CanDeactivate` guard type when prompted.  
2. Implement a `CanDeactivateFn<T>` guard that checks the component instance and returns `true` to allow navigation or `false` to block it (or an async equivalent using `Promise`/`Observable`).  
3. Configure the route by adding the guard function to the route's `canDeactivate` array.  

### Validation
- Trigger navigation away from the guarded route and confirm navigation blocks when the component reports unsaved changes and proceeds when it does not.  


## Procedure: Add a route data resolver and read resolved data from ActivatedRoute

### When to use
Use this when the route depends on essential data that must load before the component renders.  

### Preconditions
- Ensure the data fetch can run from a resolver (for example returns an `Observable`/`Promise` and uses route parameters from `ActivatedRouteSnapshot`).  

### Steps
1. Create a resolver function typed as `ResolveFn<T>` and fetch the essential data before activation (for example read an `id` from `route.paramMap`).  
2. Configure the route with a `resolve` map that assigns resolver outputs to keys (for example `{ user: userResolver }`).  
3. Read resolved values from `ActivatedRoute.data` in the routed component (for example convert to a signal and read the resolver keys).  

### Validation
- Navigate to the route and confirm the component reads the expected resolved values from `ActivatedRoute.data` without requiring an internal "critical data loading" state.  


## Procedure: Pass resolved data into component inputs with withComponentInputBinding

### When to use
Use this when you want resolved data to arrive as explicit, typed component inputs rather than reading from `ActivatedRoute`.  

### Preconditions
- Ensure the application router is configured through `provideRouter` so you can enable `withComponentInputBinding()`.  

### Steps
1. Configure the router with `provideRouter(routes, withComponentInputBinding())`.  
2. Define component inputs whose names match the resolver keys (and mark required ones as required inputs).  
3. Configure the target route with a `resolve` map that uses those same keys.  

### Validation
- Navigate to the route and confirm the component receives resolved values through its inputs without injecting `ActivatedRoute` for access.  


## Procedure: Configure preloading with PreloadAllModules

### When to use
Use this when you want lazy routes to load in the background after initial navigation to reduce the first-visit delay for those lazy routes.  

### Preconditions
- Ensure at least one route uses `loadChildren` so preloading has something to preload.  

### Steps
1. Configure the router with `provideRouter(routes, withPreloading(PreloadAllModules))`.  
2. Subscribe to `Router.events` and log `RouteConfigLoadStart` / `RouteConfigLoadEnd` so you can observe lazy-route configuration loading.  
3. Load the app and complete the initial navigation so preloading can start.  

### Validation
- Confirm `RouteConfigLoadStart` / `RouteConfigLoadEnd` events occur after the initial navigation without explicitly navigating to every lazy route.  


## Procedure: Configure selective preloading with a custom PreloadingStrategy

### When to use
Use this when only specific lazy routes should preload (for example opt-in routes based on metadata).  

### Preconditions
- Ensure routes can be marked with `data` metadata so the preloading strategy can make deterministic decisions.  

### Steps
1. Create a class that implements `PreloadingStrategy` and implement `preload(route, load)` to return `load()` only when `route.data` contains a preload flag.  
2. Configure the router with `provideRouter(routes, withPreloading(YourPreloadingStrategy))`.  
3. Mark selected lazy routes with `data: { preload: true }` and leave other lazy routes unmarked or explicitly false.  
4. Subscribe to `Router.events` and observe `RouteConfigLoadStart` / `RouteConfigLoadEnd` so you can see which route configs preload.  

### Validation
- Confirm only routes marked with the preload flag produce route-config load events during the preloading window.


## Procedure: Test query parameter behaviour with RouterTestingHarness

### When to use
Use this when a component reacts to query parameters and you need a deterministic test that covers initial query parameter values and reactive updates.  

### Preconditions
- Ensure unit tests can use `RouterTestingHarness` and `provideRouter` in `TestBed`.  

### Steps
1. Configure `TestBed` with `provideRouter([{ path: '<path>', component: <Component> }])` and create a `RouterTestingHarness`.  
2. Navigate with `harness.navigateByUrl('/<path>?q=value', <Component>)` to render the routed component with query parameters.  
3. Assert the component reads query parameter state from `ActivatedRoute.queryParams` (for example via `toSignal` + a computed value).  

### Validation
- Run the unit test suite and confirm the query parameter test passes and fails deterministically when query parameter handling is broken.  
