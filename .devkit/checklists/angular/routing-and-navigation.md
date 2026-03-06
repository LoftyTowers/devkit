# Routing and navigation

## Checklist

- [ ] Verify a repo-wide search finds zero usages of `canLoad:` and zero imports/usages of `CanLoadFn`.  
- [ ] Ensure every `redirectTo` configured on `path: ''` includes `pathMatch: 'full'`.  
- [ ] Confirm each `Routes` array places the wildcard `path: '**'` route last.  
- [ ] Verify every route parameter name in `Route.path` starts with a letter and uses only the allowed character set.  
- [ ] Ensure guards that redirect do so by returning a `UrlTree` or `RedirectCommand`.  
- [ ] Verify guards do not redirect by returning `false` and navigating imperatively inside the guard. 
