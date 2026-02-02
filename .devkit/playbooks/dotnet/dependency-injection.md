# Dependency injection (dotnet guidance)

## Scope

- Non-enforceable guidance for .NET dependency injection patterns and registrations.

## When to use

## Guidance

- When a registration requires other services, factory overloads that receive `IServiceProvider` SHOULD be used rather than constructing interim providers.
- Method injection MAY be used where the framework supports it for operation-local dependencies, but SHOULD remain exceptional and localised.
- `ActivatorUtilities` MAY be used for dynamic instantiation only when confined to dedicated factory/infrastructure code paths.
- A long-lived service MAY access scoped services only by creating and disposing a scope via `IServiceScopeFactory` per unit of work.
- DI SHOULD be used for services, not as a store for runtime data; per-user/per-request dynamic data SHOULD NOT be modelled as container-registered singletons.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
