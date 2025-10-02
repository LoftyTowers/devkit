@'
# Style

- Naming: PascalCase for public; _camelCase for private fields; clear, no abbreviations.
- Async: suffix Async; accept CancellationToken in public async APIs.
- Exceptions: use at boundaries; prefer Result<T> for domain/app flow.
- Validation: FluentValidation for DTOs; guard clauses at domain boundaries.
- Controllers: thin; delegate to handlers/services; map Result<T> -> ProblemDetails.

## Libraries & Frameworks (PINNED)
- Logging: **ILogger<T>** with **Serilog** as the sink (structured message templates only).
- Testing: **NUnit** as the test runner; **FluentAssertions** for assertions.
- Mocks: **Moq** for mocking dependencies.
- Validation: **FluentValidation** for request/DTO validation.
- HTTP resilience (when needed): **Polly** policies (timeouts, retries with backoff, circuit breaker).
'@ | Out-File 'G:\Programming\devkit\style.md' -Encoding utf8
