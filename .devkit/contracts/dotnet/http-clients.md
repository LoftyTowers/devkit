# HTTP clients

## Timeouts
- Outbound HTTP requests MUST have explicit timeouts using `HttpClient.Timeout` and/or a per-request linked `CancellationTokenSource` with `CancelAfter`.
- `HttpClient.Timeout` MUST be treated as client-wide and MUST NOT be changed per request.
- If per-request timeouts are required, a per-request `CancellationTokenSource.CancelAfter` MUST be used and the shorter timeout (between the token and `HttpClient.Timeout`) MUST be treated as the effective limit.

## Async HTTP usage
- Async `HttpClient` APIs (`SendAsync`, `GetAsync`, etc.) MUST be used for outbound HTTP.
- Synchronous `HttpClient.Send` MUST NOT be used in production request paths where cancellation/scalability matters.
