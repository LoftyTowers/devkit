
# Naming conventions

## Scope
Governs file naming, selector naming, and identifier-to-filename alignment for all Angular artefacts in the workspace. Enforceable via linting rules, angular.json configuration, and static analysis.

## Rules
- File names MUST use kebab-case with hyphens separating words (e.g. `user-profile.ts`, not `userProfile.ts` or `user_profile.ts`).
  - Evidence: The angular.dev style guide states "Separate words in file names with hyphens." Enforceable via ESLint filename rules or custom lint rules.
- File names MUST match the TypeScript identifier they contain (e.g. a class `UserProfile` lives in `user-profile.ts`).
  - Evidence: Style guide states "File names should generally describe the contents of the code in the file. When the file contains a TypeScript class, the file name should reflect that class name." Verifiable by static analysis comparing class name to filename.
- Unit test files MUST use the same base name as the code-under-test with a `.spec.ts` suffix.
  - Evidence: Style guide states "Use the same name for a file's tests with `.spec` at the end." Verifiable by file-system convention check in CI.
- Component TypeScript, template, and style files MUST share the same base file name with different extensions (e.g. `user-profile.ts`, `user-profile.html`, `user-profile.css`).
  - Evidence: Style guide states "Use the same file name for a component's TypeScript, template, and styles." Enforceable by lint rule or file-structure validation.
- All component and directive selectors MUST use a short, consistent, project-specific prefix configured in `angular.json`.
  - Evidence: angular.dev recommends "a short, consistent prefix for all the custom components defined inside your project." The `prefix` property in `angular.json` is used by CLI schematics to enforce this at generation time; a lint rule can verify it at CI.
- Component and directive selectors MUST NOT use the `ng` prefix.
  - Evidence: "Angular uses the `ng` selector prefix for its own framework APIs. Never use `ng` as a selector prefix for your own custom components." Enforceable via `@angular-eslint/component-selector` rule.
- Custom element selectors MUST contain a hyphen as required by the HTML specification.
  - Evidence: "All custom element names should include a hyphen as described by the HTML specification." Angular reports an error at compile-time for non-matching tags.
- Attribute selectors for directives MUST use camelCase with the same application prefix (e.g. `[mrTooltip]`).
  - Evidence: Style guide states "use a camelCase attribute name" and "You can follow the same prefixing recommendation described above." Enforceable via eslint selector rules.
- File names MUST NOT use overly generic names such as `helpers.ts`, `utils.ts`, or `common.ts`.
  - Evidence: Style guide states "Avoid overly generic file names like `helpers.ts`, `utils.ts`, or `common.ts`." Enforceable via a custom lint rule blocking these filenames.

## Prohibited patterns
- MUST NOT use the `ng` prefix for any custom component or directive selector.
- MUST NOT name files with generic identifiers (`helpers.ts`, `utils.ts`, `common.ts`).

## Allowed deviations
- MAY append additional descriptive words to style file names when a component has more than one style file (e.g. `user-profile-settings.css`).

