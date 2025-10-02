// AFTER (pattern)
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
        using var scope = _log.BeginScope(new Dictionary<string, object?>
        {
            ["OrderId"] = id,
            ["CorrelationId"] = HttpContext.TraceIdentifier
        });

        var cmd = new PayOrderCommand(id, req.Amount, req.PaymentId);
        var result = await _mediator.Send(cmd, ct);

        return result.Match(
            _ => Ok(),
            err => err.ToProblemDetails()
        );
    }
}
