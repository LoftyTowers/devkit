
# Dependency injection

## Scope
Governs how services are provided and injected across the application. Enforceable via decorator metadata inspection, lint rules, and schematic migration.

## Rules
- Application-wide singleton services MUST use `@Injectable({ providedIn: 'root' })`.
  - Evidence: angular.dev DI guide labels `providedIn: 'root'` as "**Preferred**" and states it "enables Angular and JavaScript code optimizers to effectively remove services that are unused (known as tree-shaking)." Verifiable by decorator metadata inspection.
- Dependencies MUST be injected using the `inject()` function rather than constructor parameter injection.
  - Evidence: angular.dev style guide: "Prefer the `inject` function over constructor parameter injection" citing readability, type inference, and ES2022+ `useDefineForClassFields` compatibility. Angular provides a migration schematic (`@angular/core:inject`). Enforceable via ESLint rule.
- Services MUST be decorated with `@Injectable()`.
  - Evidence: "The first step is to add the `@Injectable` decorator to show that the class can be injected." Verifiable by decorator presence check.
- Route-scoped services MUST be provided via the `providers` array in the route configuration, NOT via `providedIn: 'root'`.
  - Evidence: Hierarchical injectors guide explains that adding `providers` to a route configuration "introduces a new injector at the level of the route" (`EnvironmentInjector`). Verifiable by inspecting route configs for `providers` arrays and service decorators.
- Component-scoped services (new instance per component) MUST be provided in the `@Component` `providers` array.
  - Evidence: "When you register a provider at the component level, you get a new instance of the service with each new instance of that component." Verifiable by decorator inspection.

## Prohibited patterns
- MUST NOT provide `providedIn: 'root'` services redundantly in component or route `providers` arrays (causes loss of tree-shaking and confusing duplicate instances).

## Allowed deviations
- MAY use constructor injection in cases where classes need to be instantiated directly outside Angular's DI context (e.g. testing utilities).

