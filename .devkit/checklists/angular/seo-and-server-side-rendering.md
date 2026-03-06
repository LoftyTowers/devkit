# Seo and server side rendering

## Checklist
- [ ] Verify `angular.json` sets `outputMode` to `server` or `static` for the application build target.  
- [ ] Ensure `tsconfig.app.json` and `tsconfig.server.json` have matching `angularCompilerOptions.preserveWhitespaces` (or both omit it).  
- [ ] Verify Angular compiler extended diagnostics are enabled (`strictTemplates: true`) and hydration skip misuse is treated as an error (`skipHydrationNotStatic`). 
