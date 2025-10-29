Include prelude-general.md, then apply .NET specifics:
- languages/dotnet/style.md
- languages/dotnet/libraries.md
- languages/dotnet/design-recipes.md

### Layer Rules Quick Check
| Layer | Guard rails |
|---|---|
| API | Validate with FluentValidation, open logging scope with correlation, map results via `ToActionResult()`, catch cancellation to return 499. |
| Application | Validate commands, invoke domain factories, call ports, translate port failures to `Result<T>`, log context but no HTTP types. |
| Domain | Pure business rules only, throw `DomainRuleException` on invariant breach, no logging/IO/time lookups. |
| Infrastructure | Implement ports, map external failures to `ErrorCode` before returning, never embed domain rules. |
| Shared | Keep primitives/framework helpers (`Result`, `ErrorCode`, `IClock`, mapping extensions) consistent across layers. |
| Tests | Use NUnit + Moq, cover happy/error/cancellation, assert exact HTTP codes via `ToActionResult()`. |

### Style Rules Quick Check
- Follow the [XML Comments Guidelines](../languages/dotnet/style.md#xml-comments-guidelines); only document public APIs or nuanced behaviour.
- Public async APIs: name ends with Async and accept CancellationToken.
- BeginScope includes CorrelationId and key ids (OrderId/PaymentId).
- All failures use `Result<T>.Failure(code, errors)`.
- Map errors: 400 Validation, 422 Domain, 500 Unexpected at edges.
- Controller edge has try/catch for unexpected and cancellation cases.
- Tests assert exact status codes.
- No new seam unless a trigger applies; add a one-line reason if you add one.

### DI compliance (all classes)
- Use constructor DI for ILogger<T>, IValidator<T>, repositories, gateways, clocks, config.
- No `IServiceProvider.GetService` in domain/application code.
- If a dependency varies per call, introduce a small factory interface (e.g., `IPaymentGatewayFactory`) and inject that.

### Validation (must follow)
- Always call `ValidateAsync(request, cancellationToken)` (no synchronous `Validate`).
- Use injected `IValidator<T>`; never `new` validators in methods.

### HTTP mapping (must follow)
- Never return `Result` types directly to clients.
- Always map via `ResultExtensions.ToActionResult()` so `ErrorCode.Validation` → 400, `ErrorCode.Domain` → 422, `ErrorCode.Cancelled` → 499, and `ErrorCode.Unexpected` → 500.

### ErrorCode Enum Convention

All failures should use `ErrorCode` enum values instead of string literals:

| Enum Name  | HTTP Code | Meaning |
|-------------|------------|----------|
| Validation  | 400        | Input or business rule validation failure |
| Domain      | 422        | Domain or rule violation within business logic |
| Cancelled   | 499        | Request cancelled by client or timeout |
| Unexpected  | 500        | Unhandled or unexpected errors |

Use:
```csharp
Result.Failure(ErrorCode.Validation, "Amount must be greater than zero.")
```

### IDs & scope (must follow)
- Controller must not fabricate IDs (e.g., `PaymentId`). If not present in request, omit it from `BeginScope`.
- Service/domain is responsible for generating business IDs (e.g., PaymentId).

### Cancellation policy
- On `OperationCanceledException`, return **499** (or **400** if org policy requires). Be consistent across controllers and tests.

### Testing compliance (must follow)
- Generate NUnit tests in a separate test project.
- Use Moq + FluentAssertions.
- Assert exact HTTP status codes (400/422/500).
- Mirror structure from: examples/dotnet/design-recipes/api-endpoint/OrdersController_tests.cs.

Before outputting code, run the DevKit self-check and confirm tests meet the policy.

Pinned stack: ILogger<T> with Serilog, NUnit + Moq + FluentAssertions, FluentValidation, Polly (when needed).
Use CancellationToken in public async APIs; suffix Async. Map failures to ProblemDetails.
Where an example is referenced, open the file from /examples/dotnet/... and mirror that pattern.
