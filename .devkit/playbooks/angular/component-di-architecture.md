# Component Di Architecture

## Scope

- This playbook defines guidance for Angular component structure and dependency injection patterns, including standalone components, templates, and styling boundaries.
- It applies to application components and services under `src/app/`, focusing on maintainability and correct injector scoping.
## Core guidance

## Rules & patterns
- Standalone components MUST be defined with standalone set to true and dependencies imported via the imports array.
- Components SHOULD have a single responsibility and aim to be under around 400 lines.
- Smart and dumb components SHOULD be separated by responsibility.
- Inline templates SHOULD be limited to three lines or fewer.
- Styles longer than three lines SHOULD be extracted to external CSS or SCSS files.
- ChangeDetectionStrategy.OnPush SHOULD be used for components that depend only on inputs and observables.
- Inputs and outputs MUST be declared explicitly. @Input(), @Output(), input(), output()
- Application-wide singleton services SHOULD use providedIn: 'root'.
- Dependencies MUST be injected via constructors.
- Optional dependencies SHOULD use @Optional().
- Injector resolution MUST be controlled using @Self() and @SkipSelf() where required.
- Services MUST be scoped to the appropriate injector level.
- Non-class dependencies MUST be provided using InjectionToken.
- Lazy-module-scoped services MAY use module providers or providedIn.

## Anti-patterns
- Oversized components over 400 lines SHOULD NOT be used without clear justification.
- Presentation and business logic MUST NOT be mixed in a single component.
- Inline templates longer than three lines MUST NOT be used.
- Default change detection SHOULD NOT be used where OnPush is appropriate.
- Services MUST NOT be provided in component metadata unnecessarily.
- Services MUST NOT be registered only in module providers instead of using providedIn.
- Circular dependencies between services MUST NOT exist. NG0200

## Allowed deviations
- Components MAY exceed 400 lines when they remain cohesive and maintainable.
- Teams MAY choose to always use external templates.

## Examples

## Cross-references
