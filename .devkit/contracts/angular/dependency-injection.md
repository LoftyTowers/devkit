
# Dependency injection

## Scope
This category covers Angular dependency injection and service provisioning practices. It governs how to configure and provide services and other injectable values in Angular applications, including the `@Injectable` `providedIn` patterns, use of `InjectionToken`, provider configuration (`useClass`, `useValue`, `useFactory`, `useExisting`), multi-provider flags, and module-level provider patterns (`forRoot()`/`forChild()`).

## Rules
- Application-wide singleton services MUST use `@Injectable({ providedIn: 'root' })`.
  - Evidence: angular.dev DI guide labels `providedIn: 'root'` as "**Preferred**" and states it "enables Angular and JavaScript code optimizers to effectively remove services that are unused (known as tree-shaking)." Verifiable by decorator metadata inspection.
- Dependencies MUST be injected using the `inject()` function rather than constructor parameter injection.
  - Evidence: angular.dev style guide: "Prefer the `inject` function over constructor parameter injection" citing readability, type inference, and ES2022+ `useDefineForClassFields` compatibility. Angular provides a migration schematic (`@angular/core:inject`). Enforceable via ESLint rule.
- Services MUST be decorated with `@Injectable()`.
  - Evidence: "The first step is to add the `@Injectable` decorator to show that the class can be injected." Verifiable by decorator presence check.
- Provider configuration objects MUST specify exactly one of `useClass`, `useValue`, `useFactory`, or `useExisting`.
  - Evidence: Angular provider configuration uses a single provider-creation strategy per provider record. Verifiable by AST/lint rule over provider objects.
- Dependency-injection tokens MUST be class references or `InjectionToken` instances; interfaces and type aliases MUST NOT be used as runtime tokens.
  - Evidence: interfaces/type aliases are erased at runtime and cannot act as DI tokens. Verifiable by TypeScript compile-time checks and lint rules.
- When multiple providers contribute to one token, each provider entry MUST set `multi: true`.
  - Evidence: Angular multi-provider semantics require explicit `multi: true` on contributing entries. Verifiable by lint/AST checks for repeated tokens.
- `providedIn` on `@Injectable` or `InjectionToken` MUST NOT use deprecated values (`'any'` or NgModule-class references).
  - Evidence: Angular deprecates NgModule and `'any'` `providedIn` options. Verifiable by metadata inspection/lint.
- Route-scoped services MUST be provided via the `providers` array in the route configuration, NOT via `providedIn: 'root'`.
  - Evidence: Hierarchical injectors guide explains that adding `providers` to a route configuration "introduces a new injector at the level of the route" (`EnvironmentInjector`). Verifiable by inspecting route configs for `providers` arrays and service decorators.
- Component-scoped services (new instance per component) MUST be provided in the `@Component` `providers` array.
  - Evidence: "When you register a provider at the component level, you get a new instance of the service with each new instance of that component." Verifiable by decorator inspection.

## Prohibited patterns
- MUST NOT provide `providedIn: 'root'` services redundantly in component or route `providers` arrays (causes loss of tree-shaking and confusing duplicate instances).
- MUST NOT define a provider object with more than one of `useClass`, `useValue`, `useFactory`, `useExisting`.
- MUST NOT use a literal string token where a class token or `InjectionToken` is required.

## Allowed deviations
- MAY use constructor injection in cases where classes need to be instantiated directly outside Angular's DI context (e.g. testing utilities).
- MAY use `useExisting` to alias one provider token to another to share a single instance.
- MAY use `providedIn: 'platform'` for services intentionally shared across multiple Angular apps on the same page.
- MAY use optional dependencies in factory providers via optional `deps` entries or `inject(token, { optional: true })`.
- MAY implement module `forRoot()`/`forChild()` patterns when maintaining NgModule-based libraries.
