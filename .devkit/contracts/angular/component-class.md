
# Component class

## Scope
Governs component and directive class member visibility, immutability, and structural conventions. Enforceable via TypeScript compiler checks and ESLint rules.

## Rules
- Component class members used only by the template MUST be `protected`.
  - Evidence: Style guide: "Prefer `protected` access for any members that are meant to be read from the component's template." Enforceable via `@angular-eslint/no-public-method-on-directive` or custom rule plus TypeScript access checks.
- Properties initialized by Angular (`input`, `model`, `output`, queries) MUST be marked `readonly`.
  - Evidence: Style guide: "Mark component and directive properties initialized by Angular as `readonly`." Enforceable by TypeScript compiler (`readonly` modifier check).

- Template bindings MUST use `[class]` and `[style]` instead of `ngClass` and `ngStyle` directives.
  - Evidence: Style guide: "Prefer `class` and `style` over `ngClass` and `ngStyle`" citing performance cost. Enforceable by banning `NgClass`/`NgStyle` imports via lint rule.

## Prohibited patterns
- MUST NOT use `ngClass` or `ngStyle` directives when built-in `class` / `style` binding achieves the same result.

## Allowed deviations
(none)

