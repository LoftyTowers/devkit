
# Monorepo setup

## Procedure: Create an Nx Angular monorepo workspace
When to use: When starting a new multi-project Angular workspace or converting an existing standalone Nx project to a monorepo.
### Steps:
1. For a new workspace: `npx create-nx-workspace myorg --preset=angular-monorepo`
2. For converting an existing standalone Nx app: `nx g convert-to-monorepo` — this moves the app into an `apps/` directory and adjusts configuration.
3. Generate additional applications: `nx g @nx/angular:app admin`
4. Generate domain libraries: `nx g @nx/angular:lib products-data-access --directory=packages/products/data-access`
5. Add `tags` to each project's `project.json`: `"tags": ["type:data-access", "scope:products"]`
6. Configure `@nx/enforce-module-boundaries` in the workspace ESLint config with `sourceTag` / `onlyDependOnLibsWithTags` rules matching your type and scope constraints.
7. Run `nx lint` to verify all boundary rules pass.
### Evidence to capture:
- `nx graph` output showing the dependency graph with correct library relationships.
- ESLint passing with `@nx/enforce-module-boundaries` enabled.

## Procedure: Configure component selector prefix
When to use: When setting up a new Angular workspace or standardising selector prefixes across an existing project.
### Steps:
1. Open `angular.json` and set the `prefix` property under the project configuration (e.g. `"prefix": "yt"`).
2. For Nx workspaces, also set the prefix in schematic defaults within `nx.json` or `project.json`.
3. Configure `@angular-eslint/component-selector` lint rule to enforce the chosen prefix: `{ "type": "element", "prefix": "yt", "style": "kebab-case" }`.
4. Run `ng lint` to verify all existing selectors comply. Fix violations.
### Evidence to capture:
- `angular.json` showing the `prefix` value.
- Lint output with zero selector-prefix violations.

***

# SECTION 4 — CHECKLIST GATES (VERIFICATION) + FILE PLACEMENT

