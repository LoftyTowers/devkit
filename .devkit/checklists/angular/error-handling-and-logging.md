# Error handling and logging

## Checklist
- [ ] Verify the application bootstrap providers include a project-owned global error handler provider mapping.
- [ ] Ensure TypeScript `useUnknownInCatchVariables` is set to `true` in the active tsconfig used for builds.
- [ ] Confirm ESLint rejects `console.*` usage in `src/**` files.
- [ ] Verify ESLint rejects throwing non-`Error` values (no throw literals) in TypeScript files.
- [ ] Ensure ESLint (or Nx boundaries) blocks direct monitoring SDK imports outside the single approved integration module/library.
- [ ] Confirm ESLint rejects `fetch` and `XMLHttpRequest` usage in `src/**` files. 