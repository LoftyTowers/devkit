# Routing and navigation

## Scope
This contract governs Angular route configuration objects and route path strings.  
This contract governs redirects and route ordering constraints that are mechanically checkable.  
This contract governs guard and lazy-loading configuration patterns that are mechanically checkable.  
This contract governs guard redirect behaviour that is mechanically checkable.

## Rules
- Wildcard routes (`path: '**'`) MUST be the final entry in each `Routes` array.  
  Verification mechanism: ESLint rule (custom AST rule over exported `Routes` arrays) / CI script (route-config inspection).
- Redirect routes with `path: ''` and `redirectTo` MUST set `pathMatch: 'full'`.  
  Verification mechanism: ESLint rule (custom AST rule over route objects) / CI script (route-config inspection).
- Route parameter names in `Route.path` MUST start with a letter (`a-z` or `A-Z`).  
  Verification mechanism: ESLint rule (custom AST rule over `Route.path` strings) / CI script (route-config inspection).
- Route parameter names in `Route.path` MUST contain only letters, digits, underscore (`_`), or hyphen (`-`).  
  Verification mechanism: ESLint rule (custom AST rule over `Route.path` strings) / CI script (route-config inspection).
- Guards that redirect users MUST return a `UrlTree` or `RedirectCommand`.  
  Verification mechanism: ESLint custom rule that bans `Router.navigate()` / `Router.navigateByUrl()` calls inside guard files (and/or in guard functions), ensuring redirects are expressed as return values rather than imperative navigation.

## Prohibited patterns
- Route configurations MUST NOT use `canLoad` or `CanLoadFn`.  
  Verification mechanism: ESLint rule (`no-restricted-syntax`/custom) / CI script (repo search for `canLoad:` and `CanLoadFn` imports).
- Guards MUST NOT redirect by returning `false` and then programmatically navigating (`Router.navigate()` / `Router.navigateByUrl()`) inside the guard.  
  Verification mechanism: ESLint rule (custom; ban `Router.navigate*` calls in guard files) / CI script (repo search with allowlist exceptions).
