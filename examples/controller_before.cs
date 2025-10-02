// BEFORE (anti-pattern demo)
[ApiController]
[Route("api/orders")]
public class OrdersController : ControllerBase
{
    [HttpPost("{id}/pay")]
    public async Task<IActionResult> Pay(Guid id, [FromBody] PaymentRequest req)
    {
        // validation and business logic jammed in controller
        if (req.Amount <= 0) return BadRequest("Invalid amount");
        try
        {
            var gateway = new Gateway();
            var ok = await gateway.Pay(id, req.Amount);
            if (!ok) return StatusCode(502, "Gateway failed");
            return Ok();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex); // no structured logging
            return StatusCode(500);
        }
    }
}
