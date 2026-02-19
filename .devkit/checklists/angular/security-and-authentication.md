# Security and authentication

## Checklist
- [ ] Verify no application code imports `HttpClientModule` from `@angular/common/http`.  
- [ ] Verify no application code imports `HttpClientXsrfModule` from `@angular/common/http`.  
- [ ] Confirm production build configuration sets `"aot": true` in `angular.json`.  
- [ ] Verify no application code calls `DomSanitizer.bypassSecurityTrust*` methods outside `src/app/security/trusted-values.ts` and `src/app/security/trusted-values/**/*.ts`.  
- [ ] Verify no application code calls `withNoXsrfProtection()` in any `provideHttpClient(...)` configuration. 
