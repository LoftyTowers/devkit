# Dependency Injection

## DI across the codebase
- Register all concrete implementations in the composition root (e.g., `Program.cs` / `Startup`).
- Inject **ILogger<T>**, **IValidator<T>**, gateways, and repositories into **any** class that needs them (not only controllers).
- See `new/contracts/general/dependency-injection.md` for baseline DI rules.

## Lifetime guidance (defaults)
- **Singleton**: stateless, pure services (e.g., mappers, clocks).
- **Scoped**: per request or operation (e.g., units of work, `DbContext`).
- **Transient**: cheap, stateless helpers.
