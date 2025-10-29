@'
# Style

- Naming: PascalCase for public; _camelCase for private fields; clear, no abbreviations.
- Async methods: suffix Async; always accept CancellationToken on public async APIs.
- Catch OperationCanceledException at edges and log with level Information.
- Exceptions: use at boundaries; prefer Result<T> for domain/app flow.
- Validation: FluentValidation for DTOs; guard clauses at domain boundaries.
- Controllers: thin; delegate to handlers/services; map Result<T> -> ProblemDetails.

## Libraries & Frameworks (PINNED)
- Logging: **ILogger<T>** with **Serilog** as the sink (structured message templates only).
- Testing: **NUnit** as the test runner; **FluentAssertions** for assertions.
- Mocks: **Moq** for mocking dependencies.
- Validation: **FluentValidation** for request/DTO validation.
- Test method names: <Method>_<Condition>_<ExpectedOutcome> (e.g., PayAsync_InvalidInput_ReturnsBadRequest)
- HTTP resilience (when needed): **Polly** policies (timeouts, retries with backoff, circuit breaker).
'@ | Out-File 'G:\Programming\devkit\style.md' -Encoding utf8

## Extensibility heuristics
- **Seams at boundaries**: wrap external I/O in interfaces (ports), implement adapters.
- **Strategy over if/else**: when behaviour switches by type or rule, prefer Strategy.
- **Factory for creation** when construction varies by environment/config (not for every object).
- **Decorator** only when you add cross-cuts (logging, caching, metrics) without changing core behaviour.
- Each new interface/class must pass: "What **concrete variation** or **external boundary** requires this?"

## DI across the codebase
- Register all concrete implementations in the composition root (e.g., `Program.cs` / `Startup`).
- Inject **ILogger<T>**, **IValidator<T>**, gateways, and repositories into **any** class that needs them (not only controllers).
- Avoid `new Foo()` for collaborators; prefer `IFoo` injected.
- No `IServiceProvider` plumbing in domain/application code (no service locator).

## Avoid
- `new`ing collaborators in methods/constructors (use DI instead).
- `IServiceProvider` in domain/application layers (no service locator).
- Static mutable state; prefer DI + lifetimes.
