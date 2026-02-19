# Dependency injection

## Context

Angular dependency injection (DI) supplies components and services with the objects they need (services, configuration, etc.). Services are classes decorated with `@Injectable`, and making them available to DI can be done via `providedIn` on `@Injectable` or by listing them in `providers` arrays. Proper use of the DI hierarchy and provider patterns ensures singleton services when intended, or separate instances when required.

DI tokens identify what to inject; for class-based services, the class itself is the token, while for non-class values (config objects, functions, primitives), you define an `InjectionToken`. The DI system has a hierarchical structure: global (root/platform) injectors, `NgModule` providers, component/directive injectors, and route-specific providers. Understanding when to place providers at each level and how to configure them (`useClass`, `useValue`, `useFactory`, `useExisting`, and `multi`) is crucial for correct app architecture and performance.

## Guidance

- Provide most services in the root injector for app-wide singletons using `@Injectable({ providedIn: 'root' })`, which enables tree-shaking. Use `providers` only for special cases (library tokens, runtime config, or non-class values).
- Use `InjectionToken` for non-class values (configuration objects, functions, primitives) to get full type safety and tree-shakeability. Provide such tokens via `providedIn` or in a root-level provider.
- Choose provider type by need: use `useClass` to supply a class implementation, `useValue` to supply a static value (e.g. config), `useFactory` to execute a function that returns the value, and `useExisting` to create an alias to another token (ensuring the same instance).
- When multiple values should be aggregated for one token (e.g. HTTP interceptors), configure each provider with `multi: true` so injection yields an array.
- To scope a service to a component, add it to that component's `providers` array. Component providers create new instances per component, useful for isolated state or reusable component libraries.
- Provide global services (HTTP client, logging, auth) at the application or platform level (root injector or bootstrap providers). This ensures a true singleton and availability throughout the app.
- Use route-level `providers` in route definitions for feature or lazy-loaded modules to scope services to that route. This keeps those services from loading until needed.
- In shared or feature modules that declare providers, implement the `forRoot()`/`forChild()` pattern. Place global providers in a static `forRoot()` method so that importing the module in the root will register the services, while importing it elsewhere without `forRoot()` prevents duplicate registrations.
- Avoid providing a service in a component/module `providers` if it already has `providedIn: 'root'` in its `@Injectable`, as this creates redundant provider entries and can lead to confusion about instance scope.


## Trade-offs

- **Root-level providers:** Singletons make sharing data easy and reduce memory, but always stay in the bundle (even if unused). They cannot be configured per-feature and make component testing harder.
- **Component-level providers:** Offers isolation and easier unit testing with multiple instances, but increases memory usage and prevents shared state between components. Too many component providers can bloat bundles.
- **Use of `providedIn` vs module providers:** Using `providedIn` promotes tree-shaking, but requires design forethought. Listing services in NgModule providers is simpler but can lead to duplicate instances if modules are imported in multiple places.
- **forRoot pattern:** Adds complexity to module design but prevents accidental multiple instances. Without it, importing a service-providing module in more than one place duplicates the providers.


## Decision criteria

- **Global vs local:** If a service should be app-wide (e.g. logging, HTTP), provide it at the root (via `providedIn: 'root'` or bootstrap providers). If it's meant for one feature or component tree (e.g. form validator, modal state), provide it at the component or route level.
- **Multiple instances:** Use component `providers` or `providedIn: 'any'` (deprecated) if you need separate instances for each injector. Otherwise, stick to singleton patterns.
- **Library modules:** If an NgModule provides services and may be imported by many modules, implement `forRoot()` to ensure its providers are registered only once. Use `forChild()` imports (or no providers) elsewhere.
- **Configuration values:** Always inject via `InjectionToken`. If the value is static, use `useValue`. If the value depends on other injections or runtime logic, use `useFactory`.


## Preferences

- PREFERENCE — JUSTIFIED: Prefer `@Injectable({providedIn: 'root'})` for application services (since Angular 6+) instead of listing them in NgModule providers, to enable tree-shaking.
- PREFERENCE — JUSTIFIED: Use the `forRoot()` pattern for modules that provide services, to avoid multiple provider registrations and ensure singletons.
- PREFERENCE — JUSTIFIED: Use `useExisting` to alias an existing provider rather than `useClass` when you want the same instance; `useExisting` does not create a new instance.
- PREFERENCE — JUSTIFIED: Use `InjectionToken` for any injectable configuration or value that isn't a class (e.g. config object, function), to maintain type safety and allow tree-shaking.
