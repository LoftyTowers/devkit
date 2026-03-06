
# Project structure

## Scope
Governs workspace layout, directory organisation, file placement, and the single-concept-per-file rule for all Angular projects. Enforceable via file-system checks, CLI configuration, and CI validation.

## Rules
- All Angular UI code (TypeScript, HTML, styles) MUST reside inside a directory named `src`. Non-UI code (configuration, scripts) MUST reside outside `src`.
  - Evidence: Style guide states "All of your Angular UI code (TypeScript, HTML, and styles) should live inside a directory named `src`." Workspace file structure docs confirm `src/` as the standard root. Verifiable by directory-structure lint.
- The application bootstrap MUST occur in a file named `main.ts` located directly inside `src`.
  - Evidence: Style guide: "Bootstrap your application in a file named `main.ts` directly inside `src`." Verifiable by file-existence check.
- Closely related files (component `.ts`, `.html`, `.css`, `.spec.ts`) MUST be grouped together in the same directory.
  - Evidence: "Group closely related files together in the same directory." and "Unit tests should live in the same directory as the code-under-test." Enforceable via file-structure linter.
- Projects MUST be organised by feature areas, NOT by code type (i.e. no top-level `components/`, `directives/`, `services/` directories).
  - Evidence: Style guide: "Organize your project into subdirectories based on the features of your application" and "Avoid creating subdirectories based on the type of code." Enforceable by directory naming lint rule.
- Each source file MUST focus on a single concept (typically one component, directive, pipe, or service per file).
  - Evidence: Style guide: "Prefer focusing source files on a single concept." Legacy style guide adds "Consider limiting files to 400 lines of code." Enforceable by ESLint max-lines or max-classes-per-file rule.
- Standalone applications MUST define routing configuration via `provideRouter` in the `ApplicationConfig` passed to `bootstrapApplication`.
  - Evidence: angular.dev file structure docs show `app.config.ts` and `app.routes.ts` as the standard files for standalone app configuration. Verifiable by file-existence check.
- In multi-project workspaces, additional applications and libraries MUST reside under the `projects/` directory (or `packages/` for Nx).
  - Evidence: angular.dev workspace docs: "Other applications and libraries go into a `projects` directory." Verifiable by workspace structure check.

## Prohibited patterns
- MUST NOT organise source directories by technical type (e.g. `components/`, `services/`, `directives/` at root level).
- MUST NOT place unit tests in a centralised `tests/` directory separate from the code under test.

## Allowed deviations
- MAY colocate multiple small, closely-related components or directives in a single file if they tie together as part of a single concept.

