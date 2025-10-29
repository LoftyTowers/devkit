using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using FluentValidation;
using LayeredMicroservice.Application;
using LayeredMicroservice.Shared;
using Microsoft.AspNetCore.Mvc;

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
        using var scope = _logger.BeginScope(new Dictionary<string, object>
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
            var result = await _handler.HandleAsync(request.ToCommand(), cancellationToken);
            return result.ToActionResult(order => new { order.Id, order.Total });
        }
        catch (OperationCanceledException)
        {
            return Result.Failure(ErrorCode.Cancelled, Array.Empty<string>()).ToActionResult();
        }
    }
}

public sealed record CreateOrderRequest(Guid CustomerId, IReadOnlyCollection<OrderLineRequest> Lines)
{
    public CreateOrderCommand ToCommand() => new(CustomerId, Lines.Select(l => new CreateOrderLine(l.Sku, l.Quantity)).ToArray());
}

public sealed record OrderLineRequest(string Sku, int Quantity);
