
# Dependency injection strategy

## Context

- Angular DI provides services and values through hierarchical injectors and explicit provider configuration.
- DI tokens identify dependencies: class types for class services, and `InjectionToken` for non-class values (config objects, primitives, functions).

## Guidance

- The Angular DI system has two injector hierarchies: `EnvironmentInjector` (configured via `@Injectable()` or `providers` in `ApplicationConfig` / route configs) and `ElementInjector` (configured via `providers` in `@Component` / `@Directive`).
- When a dependency is not found in the `ElementInjector` hierarchy, Angular falls back to the `EnvironmentInjector` provided by `ApplicationConfig`.
- Provide most application-wide services with `@Injectable({ providedIn: 'root' })`; use `providers` for scoped instances, aliases, or non-class values.
- Adding a `providers` array to a route configuration introduces a new `EnvironmentInjector` at the level of that route — this replaces the old lazy-module injector pattern. This works regardless of whether the route is lazy or eager.
- Use route-level `providers` when you need route-scoped service instances or deferred feature initialization.
- Use component/directive `providers` when each component subtree needs an isolated service instance.
- PREFERENCE — JUSTIFIED: Favour `providedIn: 'root'` over route-level providers unless you have a specific need for scoped instances. Tree-shaking works with `providedIn: 'root'` even when the service is used only in a lazy chunk.
  - Justified by angular.dev DI guide labelling `providedIn: 'root'` as "**Preferred**" and Manfred Steyer noting that `providedIn: 'root'` still allows lazy-loading.
- Use `InjectionToken` for non-class dependencies (configuration values, feature flags). This allows runtime configuration without modifying the service itself.
  - NO PRIMARY SUPPORT — SECONDARY ONLY (Tier A angular.dev covers `InjectionToken` in API docs but the pattern guidance comes from Tier C sources).
- Choose provider strategy by intent:
  - `useClass` for concrete implementation substitution.
  - `useValue` for static configuration/constants.
  - `useFactory` when value construction depends on runtime logic or other injections.
  - `useExisting` when aliasing to share one instance across tokens.
- Use `multi: true` when multiple providers should contribute to one token (for example, interceptor-style extension points).
- In NgModule-based libraries that register providers, use `forRoot()` for root-only providers and `forChild()` (or plain imports) for feature usage to avoid duplicate registrations.
- Avoid redundant providers: do not re-provide services in component/route/module providers when they already use `providedIn: 'root'` unless intentional instance scoping is required.
- The `inject()` function supports fine-grained control via options: `{ optional, host, self, skipSelf }`, replacing the legacy `@Optional()`, `@Host()`, `@Self()`, `@SkipSelf()` decorators.

## Trade-offs

- Root-provided services simplify sharing state and usually reduce duplicate instances, but can make per-feature customization harder.
- Route/component providers improve isolation and feature encapsulation, but increase instance count and require clearer ownership boundaries.
- Module-level provider patterns (`forRoot/forChild`) add ceremony but prevent accidental duplicate singletons in NgModule ecosystems.

## Decision criteria

- Use root scope for cross-app infrastructure (auth, logging, http abstractions, global state facades).
- Use route scope for feature-bounded state/services that should reset when leaving the route.
- Use component scope for local UI state/services that should be isolated per component instance.
- Use `InjectionToken` for all non-class injected values; use `useFactory` if construction depends on environment or other injected services.
