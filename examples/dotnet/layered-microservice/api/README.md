# API Layer

**Purpose**
- Expose application workflows via HTTP without leaking domain or infrastructure concerns.
- Validate requests, maintain logging scopes, and translate `Result` outcomes to HTTP responses.

**Golden Rules**
- Validate input with `IValidator<T>` and `ValidateAsync(..., CancellationToken)`.
- Open a logging scope with correlation and entity identifiers.
- Do not craft ProblemDetails manually; call `ToActionResult()` on `Result`/`Result<T>`.
- Map `OperationCanceledException` to `ErrorCode.Cancelled (499)`.

**Example**
```csharp
[HttpPost]
public async Task<IActionResult> CreateAsync(CreateOrderRequest request, CancellationToken ct)
{
    using var scope = _logger.BeginScope(new { CorrelationId = HttpContext.TraceIdentifier });

    var validation = await _validator.ValidateAsync(request, ct);
    if (!validation.IsValid)
    {
        return Result.Failure(ErrorCode.Validation, validation.Errors.Select(e => e.ErrorMessage))
            .ToActionResult();
    }

    try
    {
        var outcome = await _handler.HandleAsync(request.ToCommand(), ct);
        return outcome.ToActionResult(order => new { order.Id, order.Total });
    }
    catch (OperationCanceledException)
    {
        return Result.Failure(ErrorCode.Cancelled, Array.Empty<string>()).ToActionResult();
    }
}
```

**Use this prompt**
> Generate an ASP.NET Core controller action that validates with FluentValidation, uses `ToActionResult`, and respects the layered microservice API rules.
