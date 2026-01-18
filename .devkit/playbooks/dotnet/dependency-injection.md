# Dependency injection (dotnet guidance)

## Scope

- When a registration requires other services, factory overloads that receive `IServiceProvider` SHOULD be used rather than constructing interim providers.
- Method injection MAY be used where the framework supports it for operation-local dependencies, but SHOULD remain exceptional and localised.
- `ActivatorUtilities` MAY be used for dynamic instantiation only when confined to dedicated factory/infrastructure code paths.
- A long-lived service MAY access scoped services only by creating and disposing a scope via `IServiceScopeFactory` per unit of work.

## When to use

- None.

## Guidance

- None.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
