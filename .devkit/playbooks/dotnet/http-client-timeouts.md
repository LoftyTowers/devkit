# HttpClient timeouts (guidance)

## Choosing a timeout strategy
- Use `HttpClient.Timeout` for a uniform client-wide policy.
- Use per-request `CancellationTokenSource.CancelAfter` when timeouts vary by call.
- Explicit timeouts are required; coordinate per-request tokens with any client-wide timeout.

## Timeout diagnosis
- Catch `OperationCanceledException` only when you intentionally handle cancellation.
- For diagnosing HttpClient timeouts, cancellation may wrap a timeout; inspect `InnerException` for `TimeoutException` where applicable.

## Timeout layering
- Do: configure a single authoritative timeout and ensure dependent layers are longer.
- Do: document which layer owns the effective timeout.
- Avoid: overlapping timeouts that race without intent.
