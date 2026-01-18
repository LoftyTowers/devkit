# Dependency injection

## Scope

- **All collaborators** (repositories, gateways, clients, clocks, validators, loggers, etc.) MUST be injected via the constructor.
- MUST NOT resolve services manually or use service locator patterns inside methods.
- MUST NOT instantiate collaborators with `new` inside classes or operational methods.
- Static members are allowed **only** for pure, stateless helpers (no I/O, no shared state).
- MAY instantiate pure values/DTOs and short-lived in-method data structures (e.g., `List<T>`) within a method.

## Rules

### DI vs static vs factory

- **Default**: constructor DI for collaborators (gateways, repos, clocks, loggers, validators).
- **Static**: only for **pure functions** (no I/O, no state). Prefer modules with static methods or extension methods.
- **Factory**: use when selection varies per call (strategy keyed by type/tenant/feature flag).

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
