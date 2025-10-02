@'
# Patterns

## API endpoint pattern (before/after)
**Before:** validation + business logic inside controller.
**After:** Controller -> Handler; FluentValidation for input; map Result<T> -> ProblemDetails; log around I/O.

### Controller snippet
```csharp
[ApiController]
[Route("api/orders")]
public class OrdersController : ControllerBase
{
    private readonly IMediator _mediator;
    private readonly ILogger<OrdersController> _log;

    public OrdersController(IMediator mediator, ILogger<OrdersController> log)
    {
        _mediator = mediator;
        _log = log;
    }

    [HttpPost("{id:guid}/pay")]
    public async Task<IActionResult> Pay(Guid id, [FromBody] PaymentRequest req, CancellationToken ct)
    {
        using var _ = _log.BeginScope(new Dictionary<string, object?>
        {
            ["OrderId"] = id,
            ["CorrelationId"] = HttpContext.TraceIdentifier
        });

        var result = await _mediator.Send(new PayOrderCommand(id, req.Amount, req.PaymentId), ct);

        return result.Match(
            _ => Ok(),
            err => err.ToProblemDetails()   // map to RFC7807 ProblemDetails
        );
    }
}
