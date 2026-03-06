
# Monorepo review

- [ ] Verify every Nx library has both a `type:` tag and a `scope:` tag in its `project.json`.
- [ ] Verify `@nx/enforce-module-boundaries` is configured in the workspace ESLint config.
- [ ] Verify UI libraries do not import from `feature` or `data-access` libraries.
- [ ] Verify data-access libraries do not import from `feature` or `ui` libraries.
- [ ] Verify utility libraries do not import from `feature`, `ui`, or `data-access` libraries.
- [ ] Confirm cross-domain imports are explicitly authorised in scope rules.
- [ ] Verify `nx lint` passes with zero module-boundary violations.
- [ ] Confirm the application shell is thin: routing, bootstrap, and layout only — no business logic.
- [ ] Verify TypeScript path mappings in `tsconfig.base.json` reflect the `@<org>/<domain>-<type>` convention.

