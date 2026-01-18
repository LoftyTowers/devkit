# HTTP clients

## Scope

- None.

## Rules

### Reuse and creation

- `HttpClient` instances MUST be reused and MUST NOT be created and disposed per request.

### Handler lifetime and DNS refresh

- Handler/connection lifetimes MUST be configured to support DNS refresh for pooled connections.
- Deviations MUST be documented; see `.devkit/playbooks/dotnet/httpclient-deviations.md`.

### Timeouts

- Outbound HTTP requests MUST have explicit timeouts using `HttpClient.Timeout` and/or a per-request linked `CancellationTokenSource` with `CancelAfter`.
- `HttpClient.Timeout` MUST be treated as client-wide and MUST NOT be changed per request.
- If per-request timeouts are required, a per-request `CancellationTokenSource.CancelAfter` MUST be used and the shorter timeout (between the token and `HttpClient.Timeout`) MUST be treated as the effective limit.

### Resilience

- Transient HTTP failures MUST be handled with bounded retry policies (cap attempts; avoid aggressive loops).
- Resilience policies MUST be attached via the HttpClient pipeline, not ad-hoc per call.
- When overriding/adding resilience handlers, configuration MUST avoid unintentionally stacking defaults and MUST result in a single intentional pipeline that is documented.

### Async HTTP usage

- Async `HttpClient` APIs (`SendAsync`, `GetAsync`, etc.) MUST be used for outbound HTTP.
- Synchronous `HttpClient.Send` MUST NOT be used in production request paths where cancellation/scalability matters.

### Cookies and handler sharing

- When cookies are used, `CookieContainer` MUST be configured to avoid unintended sharing via pooled handlers.
- Cookie usage MUST be explicit: either isolate per client/handler or document why sharing is safe.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
