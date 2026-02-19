
# Typescript configuration code quality

## Context
TypeScript configuration controls what the compiler can prove about your application and what errors it will surface before runtime.  
Angular adds its own compiler options (via `angularCompilerOptions`) which drive template type checking and related diagnostics, so `tsconfig.*.json` becomes part of your correctness boundary.  

Linting and formatting tooling sit alongside the compiler: `ng lint` runs a configured lint builder, and teams commonly use ESLint (with Angular-specific tooling) to lint both TypeScript and Angular templates.  
Prettier is a dedicated formatter and can run in editors, pre-commit hooks, and CI to keep formatting consistent and reduce review noise.  

## Guidance
- Organise configuration so a single root `tsconfig.json` defines shared defaults, and project-specific configs extend it with `extends`.  
- Prefer enabling TypeScript strictness via `compilerOptions.strict` rather than selectively enabling strict-family options one-by-one.  
- Prefer enabling Angular template type checking with `strictTemplates` and then adjusting specific template strictness flags instead of switching template checking off entirely when you hit a false positive.  
- Use the Angular "strict mode" baseline for new or hardened projects (TypeScript strict mode plus Angular compiler strict flags) and keep that baseline stable across the repo.  
- Use `ng lint` as the team's canonical lint entry point, and keep it runnable for all projects by maintaining the `lint` target configuration in `angular.json`.  
- Prefer `angular-eslint` tooling for Angular CLI workspaces so ESLint can lint both TypeScript and templates using the Angular CLI flow (`ng lint`).  
- Separate responsibilities: use a formatter (Prettier) for formatting, and keep ESLint focused on correctness and maintainability rules.  
- Use a pre-commit hook to format and lint staged files when fast feedback matters, and keep CI as the final gate using `prettier --check` and `ng lint`.  
- Avoid running `ng lint` via `lint-staged`; invoke project-wide linting separately because `ng lint` is designed to lint an entire project.  
- Use typed (type-aware) linting only for rule-sets that need it, and treat lint runtime similar to build runtime when you enable typed linting.  
- Write custom lint rules only when existing core and community rules cannot enforce your requirement, and package them as a reusable plugin so they can be tested and versioned.  

## Trade-offs
- Enabling `strictTemplates` can surface new template errors, including cases caused by incomplete or mismatched library typings; mitigation may require narrow opt-outs (for example `$any()` casts) or targeted flag adjustments.  
- Typed ESLint rules can be materially slower because they require TypeScript to build type information before linting can run; this can affect local feedback loops and CI duration.  
- Pre-commit hooks reduce formatting failures in CI, but they add work to every commit and tooling like `lint-staged` may create a stash backup and run git operations that can surprise contributors.  

## Decision criteria
- Choose "disable a specific template check flag" when strict template checking is mostly valuable but one check blocks progress (for example, narrow the strictness surface rather than switching off `strictTemplates`).  
- Choose "disable `strictTemplates` entirely" only when you cannot proceed due to systemic false positives and there is no workable local opt-out path.  
- Choose "CI-only stricter type checking" when you want warnings locally for flow but hard errors on merged code (for example, by using a CI build configuration that points at a stricter `tsconfig`).  
- Choose "typed linting" when the specific rules you need require type information; choose "non-typed linting" when lint speed is the stronger constraint.  
- Choose "CI formatting gate (`prettier --check`) only" when pre-commit hooks are not acceptable; choose "pre-commit formatting" when you want to reduce preventable CI failures and reformat noise in pull requests.  

## Preferences
- PREFERENCE — JUSTIFIED: Keep formatting out of ESLint execution and run Prettier directly (for example with `prettier --check` in CI and `prettier --write` locally).  
- PREFERENCE — JUSTIFIED: Use `npx mrm@2 lint-staged` as the default bootstrap for a Prettier + Husky + lint-staged pre-commit setup.  

