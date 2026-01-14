# Libraries

## Libraries (pinned)

These are the approved defaults for .NET projects using this DevKit.

- Logging: `ILogger<T>` with Serilog (structured message templates only).
- Testing: NUnit + Moq + FluentAssertions.
- Validation: FluentValidation (>=12.0.0) for request/DTO validation.
- Resilience: Polly **only** where the operation is idempotent (timeouts, retry/backoff, circuit breaker).
- HTTP: `IHttpClientFactory`; MUST NOT `new HttpClient()`.
- See also: `.devkit/contracts/dotnet/http-clients.md`.
- Config: Options pattern; validate on start; MUST NOT store secrets in code or logs.
