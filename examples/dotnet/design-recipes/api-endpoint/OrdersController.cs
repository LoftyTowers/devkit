namespace DevKit.Examples.ApiEndpoint;

[ApiController]
[Route("api/orders")]
public sealed class OrdersController : ControllerBase
{
    private readonly ILogger<OrdersController> _logger;
    private readonly IValidator<PayRequest> _validator;

    public OrdersController(ILogger<OrdersController> logger, IValidator<PayRequest> validator)
    {
        _logger = logger;
        _validator = validator;
    }

    [HttpPost("{id:guid}/pay")]
    [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status422UnprocessableEntity)]
    [ProducesResponseType(typeof(ProblemDetails), StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> PayAsync(Guid id, [FromBody] PayRequest request, CancellationToken cancellationToken)
    {
        using var _ = _logger.BeginScope(new Dictionary<string, object?>
        {
            ["CorrelationId"] = HttpContext.TraceIdentifier,
            ["OrderId"]       = id,
            ["PaymentId"]     = request?.PaymentId
        });

        try
        {
            // Validate request at the edge
            var validation = await _validator.ValidateAsync(request, cancellationToken);
            if (!validation.IsValid)
            {
                var errors = validation.Errors.Select(e => e.ErrorMessage);
                return this.ToActionResult(Result<object>.Failure(ErrorCode.Validation, errors.ToArray()));
            }

            _logger.LogInformation("Processing payment for Order {OrderId} with PaymentId {PaymentId} and Amount {Amount}",
                id, request.PaymentId, request.Amount);

            // Simulate the async work (e.g., calling a payment gateway)
            await Task.Delay(10, cancellationToken);

            _logger.LogInformation("Payment processed for Order {OrderId}", id);

            return this.ToActionResult(Result<object>.Success(new { Success = true }));
        }
        catch (OperationCanceledException)
        {
            // Policy choice: 499 ('Client Closed Request') is common; 400 is acceptable if you prefer.
            _logger.LogInformation("Payment cancelled for Order {OrderId}", id);
            return StatusCode(499);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error while paying for Order {OrderId}", id);
            var pd = new ProblemDetails
            {
                Status = StatusCodes.Status500InternalServerError,
                Title  = "Unexpected error",
                Detail = "An unexpected error occurred."
            };
            return new ObjectResult(pd) { StatusCode = pd.Status };
        }
    }
}

public sealed record PayRequest(decimal Amount, string PaymentId);
