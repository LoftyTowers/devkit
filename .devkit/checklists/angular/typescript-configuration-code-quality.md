
# Typescript configuration code quality

## Checklist
- [ ] Verify the workspace root contains `tsconfig.json`.  
- [ ] Confirm each `tsconfig.*.json` file uses `extends` and ultimately inherits from the workspace root `tsconfig.json`.  
- [ ] Verify `tsconfig.json` sets `compilerOptions.strict` to `true`.  
- [ ] Verify `tsconfig.json` sets `compilerOptions.forceConsistentCasingInFileNames` to `true`.  
- [ ] Verify `tsconfig.json` sets `compilerOptions.noImplicitReturns` to `true`.  
- [ ] Verify `tsconfig.json` sets `compilerOptions.noFallthroughCasesInSwitch` to `true`.  
- [ ] Verify the application tsconfig (for example `tsconfig.app.json`) sets `angularCompilerOptions.strictTemplates` to `true`.  
- [ ] Verify the application tsconfig sets `angularCompilerOptions.strictInjectionParameters` to `true`.  
- [ ] Verify the application tsconfig sets `angularCompilerOptions.strictInputAccessModifiers` to `true`.  
- [ ] Ensure `angular.json` contains a `lint` target per project and `ng lint` runs for the workspace.  
- [ ] Confirm the `lint` builder is `@angular-eslint/builder:lint` in `angular.json`.  
- [ ] Verify the repository root contains `eslint.config.js` or `.eslintrc.json`.  
- [ ] Verify ESLint is configured to use `@angular-eslint/template-parser` for `*.html` files.  
- [ ] Ensure `package.json` lists Prettier under `devDependencies`.  
- [ ] Verify CI runs `prettier --check` (or an equivalent script) and fails on unformatted files.  
- [ ] Confirm `lint-staged` configuration does not run `ng lint`.  
- [ ] Confirm any custom ESLint rule plugin has executable tests and is referenced by ESLint configuration. 

