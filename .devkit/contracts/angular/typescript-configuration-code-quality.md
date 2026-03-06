
# Typescript configuration code quality

## Scope
This contract governs TypeScript configuration inheritance and strictness flags for Angular projects in this repository.  
This contract governs linting and formatting tooling configuration that is executed by automated checks.  
This contract governs repository configuration patterns that can be mechanically verified in CI.

## Rules
- The workspace root MUST contain a `tsconfig.json` file.  
  Verification mechanism: CI script / file-system check.
- All project `tsconfig.*.json` files MUST use `extends` to inherit from the workspace root `tsconfig.json`.  
  Verification mechanism: CI script / config validation (JSON inspection).
- The workspace root `tsconfig.json` `compilerOptions.strict` MUST be set to `true`.  
  Verification mechanism: TypeScript compiler option / type check (`tsc --showConfig`).
- The workspace root `tsconfig.json` `compilerOptions.forceConsistentCasingInFileNames` MUST be set to `true`.  
  Verification mechanism: TypeScript compiler option / type check (`tsc --showConfig`).
- The workspace root `tsconfig.json` `compilerOptions.noImplicitReturns` MUST be set to `true`.  
  Verification mechanism: TypeScript compiler option / type check (`tsc --showConfig`).
- The workspace root `tsconfig.json` `compilerOptions.noFallthroughCasesInSwitch` MUST be set to `true`.  
  Verification mechanism: TypeScript compiler option / type check (`tsc --showConfig`).
- Each application TypeScript configuration file (for example, `tsconfig.app.json`) MUST set `angularCompilerOptions.strictTemplates` to `true`.  
  Verification mechanism: Angular compiler / runtime invariant (AOT type checking) and config validation (JSON inspection).
- Each application TypeScript configuration file MUST set `angularCompilerOptions.strictInjectionParameters` to `true`.  
  Verification mechanism: Angular compiler / runtime invariant and config validation (JSON inspection).
- Each application TypeScript configuration file MUST set `angularCompilerOptions.strictInputAccessModifiers` to `true`.  
  Verification mechanism: Angular compiler / runtime invariant and config validation (JSON inspection).
- `angular.json` MUST define a `lint` target for each Angular project and it MUST be runnable via `ng lint`.  
  Verification mechanism: Config validation (`angular.json` inspection) and CI script (`ng lint`).
- When using Angular CLI linting, the `lint` target builder MUST be `@angular-eslint/builder:lint`.  
  Verification mechanism: Config validation (`angular.json` inspection).
- The repository root MUST contain ESLint configuration as either `eslint.config.js` (flat config) or `.eslintrc.json` (eslintrc).  
  Verification mechanism: CI script / file-system check.
- For template linting, ESLint MUST be configured to parse `*.html` files with `@angular-eslint/template-parser`.  
  Verification mechanism: ESLint config validation (parser assignment per file-glob).
- Prettier MUST be installed in `devDependencies`.  
  Verification mechanism: CI script / config validation (`package.json` inspection).
- CI MUST run Prettier with `--check` (or equivalent) and MUST fail on unformatted files.  
  Verification mechanism: CI script (exit code gate).

## Prohibited patterns
- `lint-staged` MUST NOT execute `ng lint`.  
  Verification mechanism: CI script / config validation (`package.json` `lint-staged` inspection).

## Allowed deviations
- Template type-checking strictness flags MAY be individually set to `false` while keeping `strictTemplates` enabled.  
  Verification mechanism: Config validation (`tsconfig.*.json` `angularCompilerOptions` inspection).
- A dedicated CI build configuration MAY use a separate `tsconfig` file (for example via an Angular CLI configuration that points to `tsconfig.ci.json`).  
  Verification mechanism: Config validation (`angular.json` builder configuration inspection).
