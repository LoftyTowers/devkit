// See examples/dotnet/layered-microservice for the canonical layered structure.
namespace DevKit.Examples.ApiEndpoint.Tests;

[TestFixture]
public sealed class OrdersControllerTests
{
    private OrdersController _controller = default!;
    private Mock<ILogger<OrdersController>> _logger = default!;
    private IValidator<PayRequest> _validator = default!;

    [SetUp]
    public void Setup()
    {
        _logger = new Mock<ILogger<OrdersController>>();
        _validator = new PayRequestValidator();
        _controller = new OrdersController(_logger.Object, _validator);
    }

    [Test]
    public async Task PayAsync_HappyPath_ReturnsOk()
    {
        var req = new PayRequest(100m, "abc123");
        var result = await _controller.PayAsync(Guid.NewGuid(), req, CancellationToken.None);

        result.Should().BeOfType<OkObjectResult>()
              .Which.Value.Should().BeEquivalentTo(new { Success = true });
    }

    [TestCase(0, "abc123")]
    [TestCase(-10, "abc123")]
    [TestCase(100, "")]
    [TestCase(100, null)]
    public async Task PayAsync_InvalidInput_Returns400(decimal amount, string paymentId)
    {
        var req = new PayRequest(amount, paymentId);
        var result = await _controller.PayAsync(Guid.NewGuid(), req, CancellationToken.None);

        result.Should().BeOfType<ObjectResult>()
              .Which.StatusCode.Should().Be(StatusCodes.Status400BadRequest);
    }
}
