# Request timeouts (guidance)

## Server-initiated abort behavior
- `HttpContext.Abort()` drops the connection and triggers `RequestAborted` immediately.

## Request timeout middleware behavior
- Timeout middleware signals via `RequestAborted` and does not automatically call `Abort()`.
- Unhandled timeouts yield 504.

## Timeout enforcement options
- Middleware-based timeouts and manual token handling are both acceptable if applied consistently.
- See `.devkit/contracts/dotnet/async-cancellation.md` for cancellation propagation requirements.
