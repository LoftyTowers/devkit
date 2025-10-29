using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using FluentValidation;
using LayeredMicroservice.Application;
using LayeredMicroservice.Shared;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace LayeredMicroservice.Api;

[ApiController]
[Route("api/orders")]
public sealed class OrdersController : ControllerBase
{
    private readonly IValidator<CreateOrderRequest> _validator;
    private readonly ICreateOrderHandler _handler;
    private readonly ILogger<OrdersController> _logger;

    public OrdersController(
        IValidator<CreateOrderRequest> validator,
        ICreateOrderHandler handler,
        ILogger<OrdersController> logger)
    {
        _validator = validator;
        _handler = handler;
        _logger = logger;
    }

    [HttpPost]
    public async Task<IActionResult> CreateAsync(CreateOrderRequest request, CancellationToken cancellationToken)
    {
        using var scope = _logger.BeginScope(new Dictionary<string, object?>
        {
            ["CorrelationId"] = HttpContext.TraceIdentifier,
            ["CustomerId"] = request.CustomerId
        });

        var validation = await _validator.ValidateAsync(request, cancellationToken);
        if (!validation.IsValid)
        {
            return Result.Failure(ErrorCode.Validation, validation.Errors.Select(e => e.ErrorMessage))
                .ToActionResult();
        }

        try
        {
            var command = request.ToCommand(HttpContext.TraceIdentifier);
            var result = await _handler.HandleAsync(command, cancellationToken);
            return result.ToActionResult(order => new { order.Id, order.Total });
        }
        catch (OperationCanceledException)
        {
            return Result.Failure(ErrorCode.Cancelled, Array.Empty<string>()).ToActionResult();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected failure when creating order for {CustomerId}", request.CustomerId);
            return Result.Failure(ErrorCode.Unexpected, new[] { "Unexpected failure" }).ToActionResult();
        }
    }
}

public sealed record CreateOrderRequest(Guid CustomerId, IReadOnlyCollection<OrderLineRequest> Lines)
{
    public CreateOrderCommand ToCommand(string correlationId) =>
        new(CustomerId, Lines.Select(l => new CreateOrderLine(l.Sku, l.Quantity)).ToArray(), correlationId);
}

public sealed record OrderLineRequest(string Sku, int Quantity);
