namespace DevKit.Examples.ClassService.Tests;

[TestFixture]
public sealed class PaymentServiceTests
{
    private Mock<ILogger<PaymentService>> _log = default!;
    private Mock<IPaymentGateway> _gateway = default!;
    private IValidator<ProcessPaymentCommand> _validator = default!;
    private IClock _clock = default!;
    private PaymentService _sut = default!;

    private sealed class StubClock : IClock { public DateTime UtcNow { get; init; } = DateTime.UtcNow; }

    [SetUp]
    public void SetUp()
    {
        _log = new Mock<ILogger<PaymentService>>();
        _gateway = new Mock<IPaymentGateway>();
        _validator = new ProcessPaymentValidator();
        _clock = new StubClock();
        _sut = new PaymentService(_log.Object, _gateway.Object, _validator, _clock);
    }

    [Test]
    public async Task ProcessAsync_ReturnsValidationFailure_WhenInvalid()
    {
        var cmd = new ProcessPaymentCommand(Guid.Empty, Guid.Empty, 0);
        var result = await _sut.ProcessAsync(cmd, CancellationToken.None);

        result.IsSuccess.Should().BeFalse();
        result.Code.Should().Be("Validation");
    }

    [Test]
    public async Task ProcessAsync_ReturnsDomainFailure_WhenGatewayFails()
    {
        _gateway.Setup(g => g.PayAsync(It.IsAny<Guid>(), It.IsAny<Guid>(), It.IsAny<decimal>(), It.IsAny<CancellationToken>()))
                .ReturnsAsync(Result<PaymentReceipt>.Failure("Domain", "Declined"));

        var cmd = new ProcessPaymentCommand(Guid.NewGuid(), Guid.NewGuid(), 10m);
        var result = await _sut.ProcessAsync(cmd, CancellationToken.None);

        result.IsSuccess.Should().BeFalse();
        result.Code.Should().Be("Domain");
    }

    [Test]
    public async Task ProcessAsync_ReturnsReceipt_WhenSuccess()
    {
        _gateway.Setup(g => g.PayAsync(It.IsAny<Guid>(), It.IsAny<Guid>(), It.IsAny<decimal>(), It.IsAny<CancellationToken>()))
                .ReturnsAsync(Result<PaymentReceipt>.Success(default!));

        var cmd = new ProcessPaymentCommand(Guid.NewGuid(), Guid.NewGuid(), 10m);
        var result = await _sut.ProcessAsync(cmd, CancellationToken.None);

        result.IsSuccess.Should().BeTrue();
        result.Value.Should().NotBeNull();
    }
}
