
# Dependency injection strategy

- The Angular DI system has two injector hierarchies: `EnvironmentInjector` (configured via `@Injectable()` or `providers` in `ApplicationConfig` / route configs) and `ElementInjector` (configured via `providers` in `@Component` / `@Directive`).
- When a dependency is not found in the `ElementInjector` hierarchy, Angular falls back to the `EnvironmentInjector` provided by `ApplicationConfig`.
- Adding a `providers` array to a route configuration introduces a new `EnvironmentInjector` at the level of that route — this replaces the old lazy-module injector pattern. This works regardless of whether the route is lazy or eager.
- PREFERENCE — JUSTIFIED: Favour `providedIn: 'root'` over route-level providers unless you have a specific need for scoped instances. Tree-shaking works with `providedIn: 'root'` even when the service is used only in a lazy chunk.
  - Justified by angular.dev DI guide labelling `providedIn: 'root'` as "**Preferred**" and Manfred Steyer noting that `providedIn: 'root'` still allows lazy-loading.
- Use `InjectionToken` for non-class dependencies (configuration values, feature flags). This allows runtime configuration without modifying the service itself.
  - NO PRIMARY SUPPORT — SECONDARY ONLY (Tier A angular.dev covers `InjectionToken` in API docs but the pattern guidance comes from Tier C sources).
- The `inject()` function supports fine-grained control via options: `{ optional, host, self, skipSelf }`, replacing the legacy `@Optional()`, `@Host()`, `@Self()`, `@SkipSelf()` decorators.

