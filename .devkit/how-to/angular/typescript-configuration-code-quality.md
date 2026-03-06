
# Typescript configuration code quality

## Procedure: Enable strict compilation and strict templates

### When to use
Use when the repository does not currently enforce strict TypeScript checks and strict Angular template checking.

### Preconditions
- Ensure you can run `ng build` for the workspace (clean install, dependencies installed).

### Steps
1. Update the workspace root `tsconfig.json` to set `compilerOptions.strict`, `forceConsistentCasingInFileNames`, `noImplicitReturns`, and `noFallthroughCasesInSwitch` to `true`.  
2. Update the application `tsconfig` (for example `tsconfig.app.json`) to set `angularCompilerOptions.strictTemplates`, `strictInjectionParameters`, and `strictInputAccessModifiers` to `true`.  
3. Run `ng build` for each affected project.  
4. Resolve compiler and template type errors until `ng build` succeeds.  

### Validation
- Ensure `ng build` exits with code `0`.  
- Ensure template type errors are reported during build when present (not deferred to runtime).  

## Procedure: Add ESLint to an Angular CLI workspace

### When to use
Use when `ng lint` is not configured or the workspace is not using ESLint for Angular projects.

### Preconditions
- Ensure the workspace uses Angular CLI and has an `angular.json`.

### Steps
1. Run `ng add angular-eslint` in the workspace root.  
2. Run `ng g angular-eslint:add-eslint-to-project <projectName>` for each project that needs ESLint configuration when the workspace has multiple projects.  
3. Run `ng lint` (or `ng lint <projectName>`) to execute the configured lint builder.  
4. Inspect `angular.json` and confirm each project's `lint` target uses `@angular-eslint/builder:lint`.  

### Validation
- Ensure `ng lint` exits with code `0`.  
- Ensure an ESLint configuration file exists at repo root (`eslint.config.js` or `.eslintrc.json`).  

## Procedure: Add Prettier formatting checks for local use and CI gating

### When to use
Use when formatting is inconsistent or formatting rules are not enforced in CI.

### Preconditions
- Ensure the repo can run Node-based scripts in CI (GitHub Actions or equivalent).

### Steps
1. Install Prettier as a pinned dev dependency (for example `npm install --save-dev prettier`).  
2. Add a `package.json` script that runs `prettier . --check` (for example `format:check`) and use `prettier . --write` for a fix script (for example `format:write`).  
3. Add `.prettierignore` to exclude generated or vendor files from formatting.  
4. Add a CI step that runs the check script and blocks merges on exit code `1`.  

### Validation
- Run `npm run format:check` and confirm it exits `0` when formatted and `1` when unformatted.  
- Confirm CI fails when a file violates Prettier formatting and passes after applying `format:write`.  

## Procedure: Add a pre-commit hook with Husky and lint-staged for formatting and staged-file linting

### When to use
Use when you want consistent formatting and basic lint fixes applied before code is committed.

### Preconditions
- Ensure Prettier is installed in `devDependencies`.

### Steps
1. Run `npx mrm@2 lint-staged` to install and configure Husky and lint-staged.  
2. Inspect the repository and confirm a `.husky/pre-commit` hook exists and `package.json` contains a `prepare` script configured by Husky init.  
3. Update the `lint-staged` configuration to run Prettier (and optionally ESLint) against staged files (for example `prettier --write` and `eslint --fix`).  
4. Remove any `ng lint` invocation from `lint-staged` tasks.  
5. Commit changes to `package.json` and `.husky/` so the hook configuration is shared across the team.  

### Validation
- Stage a deliberately misformatted file and run `git commit`; confirm the hook formats the file or blocks the commit on failure.  
- Run the configured `lint-staged` command and confirm it only targets staged files.  

## Procedure: Create and consume a custom ESLint rule for Angular TypeScript and templates

### When to use
Use when an organisation-specific rule cannot be enforced using existing ESLint, typescript-eslint, or Angular ESLint rules.

### Preconditions
- Ensure ESLint is already configured for the workspace and can lint both TypeScript and templates.

### Steps
1. Create a local ESLint plugin package (for example under `tools/eslint-rules/`) and prepare it for version control.  
2. Install rule authoring dependencies (`@angular-eslint/utils`, `@angular-eslint/test-utils`, and `@typescript-eslint/utils`).  
3. Implement the rule using the standard ESLint custom rule module shape (`meta` + `create`).  
4. Add tests using the Angular ESLint `RuleTester` utilities so rules are validated in CI.  
5. Register the plugin in ESLint configuration and enable the custom rule for `*.ts` and/or `*.html` globs.  
6. Run ESLint and confirm the rule reports violations and (if implemented) applies fixes.  

### Validation
- Ensure the rule's test suite passes in CI.  
- Ensure the rule triggers on a known invalid fixture and stays silent on a known valid fixture.  


