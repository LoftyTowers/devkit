# Dependency Injection

## DI across the codebase
- Register all concrete implementations in the composition root (e.g., `Program.cs` / `Startup`).
- Inject **ILogger<T>**, **IValidator<T>**, gateways, and repositories into **any** class that needs them (not only controllers).
- See `.devkit/contracts/general/dependency-injection.md` for baseline DI rules.

## Lifetime guidance (defaults)
- **Singleton**: stateless, pure services (e.g., mappers, clocks).
- **Scoped**: per request or operation (e.g., units of work, `DbContext`).
- **Transient**: cheap, stateless helpers.

## Lifetime rules
- Each registered service MUST have an intentional lifetime (Transient/Scoped/Singleton) chosen to match its state and usage scope.
- Services registered as Singleton MUST be safe for concurrent use (thread-safe) and MUST NOT rely on unsynchronised mutable shared state.
- A service with a longer lifetime MUST NOT directly depend on a service with a shorter lifetime.

## Disposal and scopes
- Disposable services created by the DI container MUST NOT be manually disposed by consuming code.
- Any `IServiceScope` (or root provider) created manually MUST be disposed (or asynchronously disposed).
- Disposable transient services MUST NOT be repeatedly resolved from the root provider in long-running flows where no shorter scope exists.

## Provider construction
- Service provider construction MUST be single-pass; code MUST NOT build multiple containers/providers for normal application wiring.

## Property injection
- Property injection is NOT supported by Microsoft DI; designs MUST NOT rely on container-driven property injection in Microsoft DI-only environments.

## Long-lived services
- If a long-lived service must use scoped services, it MUST create a scope via `IServiceScopeFactory` for each unit of work and resolve scoped services from that scope.

## Prohibited patterns
- Injecting a scoped service (or any shorter-lived dependency) directly into a singleton service (captive dependency) MUST NOT occur.
- Manually disposing an injected dependency that was created/resolved by the DI container MUST NOT occur.
- Calling `BuildServiceProvider` during service registration to resolve dependencies MUST NOT occur.
