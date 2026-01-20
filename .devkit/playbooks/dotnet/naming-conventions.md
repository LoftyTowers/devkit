# Naming conventions (contextual guidance)

## Scope

Non-enforceable guidance to help apply the naming contracts consistently.

## When to use

- None.

## Guidance

### Abbreviations and acronyms

- Prefer full words when an abbreviation is not widely recognized in the team or codebase.
- Use abbreviations only when they improve clarity and reduce noise.
- If an abbreviation is used, apply it consistently across the repository.
- Acronym casing preference:
  - Two-letter acronyms: `ID` in PascalCase, `id` in camelCase.
  - Longer acronyms: treat as words in PascalCase (e.g., `Url`, `Http`), but prefer consistency over universal correctness.
- Examples:
  - Prefer `OrderIdentifier` over `OrderId` only if `Id` is not already a standard in the codebase.
  - Prefer `HttpClient` over `HTTPClient` if the repository uses word-style acronyms.

### Boolean naming

- Prefer affirmative predicate-style names (e.g., `IsEnabled`, `HasItems`, `CanRetry`) when it improves clarity.
- Avoid negated names that invert meaning (e.g., prefer `IsEnabled` over `IsDisabled` when both states are valid).
- Examples:
  - Good: `IsValid`, `HasPermission`, `CanProcess`
  - Avoid: `IsNotValid`, `HasNoPermission`, `CannotProcess`

### Async suffix omissions

- Omitting `Async` can be acceptable when:
  - A framework requires a specific name/signature (e.g., overrides or interface members).
  - Event handlers must match a prescribed name.
  - Controller/action conventions intentionally omit `Async` and the project is consistent in that area.
- Be consistent within the affected context (e.g., all controller actions follow the same rule).

### DTO / transport suffix usage

- Suffixes like `Request`, `Response`, `Dto`, or `Result` can reduce ambiguity at boundaries.
- Avoid suffixes when they add noise and the type is already clearly scoped by namespace.
- If suffixes are used, prefer a small, consistent vocabulary across the codebase.

### Private field conventions

- Choose a single private-field convention per project and document it (e.g., `_camelCase`).
- Use analyzers or `.editorconfig` naming rules to enforce the chosen convention.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
