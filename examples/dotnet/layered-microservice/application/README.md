# Application Layer

**Purpose**
- Orchestrate use-cases by validating commands and calling domain logic.
- Coordinate ports (repositories, gateways) and translate failures into `Result` codes.

**Golden Rules**
- Keep logic thin: validate, call domain, persist via ports.
- Return `Result<T>` with domain entities, never DTOs.
- Convert port failures into `ErrorCode` values before returning.
- Log with context (correlation, entity identifiers) but leave IO to adapters.

**Example**
```csharp
public async Task<Result<Order>> HandleAsync(CreateOrderCommand command, CancellationToken ct)
{
    var validation = await _validator.ValidateAsync(command, ct);
    if (!validation.IsValid)
    {
        return Result<Order>.Failure(ErrorCode.Validation, validation.Errors.Select(e => e.ErrorMessage));
    }

    var order = Order.Create(command.CustomerId, command.Lines, _clock.UtcNow);
    var saveResult = await _repository.SaveAsync(order, ct);
    if (!saveResult.IsSuccess)
    {
        _logger.LogError("Persistence failed for {OrderId}", order.Id);
        return Result<Order>.Failure(saveResult.Code ?? ErrorCode.Unexpected, saveResult.Errors);
    }

    return Result<Order>.Success(order);
}
```

**Use this prompt**
> Generate an application service handler that validates a command, invokes domain creation, calls a port, and returns `Result<T>` codes per the layered microservice rules.
