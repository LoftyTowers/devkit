# Observability with OpenTelemetry (guidance)

## Instrumentation and manual spans
- Prefer official OpenTelemetry instrumentation packages registered at startup for common frameworks.
- Add manual spans only for business-specific operations that are not covered by automatic instrumentation.

## Attribute and span naming guidance
- Use OpenTelemetry semantic attribute keys where applicable.
- Avoid high-cardinality attributes and expensive computations unless `Activity.IsAllDataRequested` is true.
- Span naming MAY be customized for local querying, but it risks losing semantic convention interoperability.

## Event volume
- Avoid adding large numbers of events to a single Activity; recurring/high-volume events should use logs or Links instead.

## Sampling and exporters
- Sampling should be considered and configured for volume/cost; low-volume systems may omit sampling initially but should revisit as throughput grows.
- Production exporters should enable batching and retries where supported; development may use console exporters.
- At least one exporter pipeline is required in production; exporter choice may vary by platform.

## Logging correlation
- When using `ILogger`, enable OpenTelemetry logging integration so logs include trace_id/span_id automatically.

## Examples

### Startup registration posture
```csharp
services.AddOpenTelemetry()
    .WithTracing(builder =>
    {
        builder.AddSource("MyService");
        builder.AddAspNetCoreInstrumentation();
        builder.AddHttpClientInstrumentation();
    });
```

### Manual span boundaries
```csharp
using var activity = MyActivitySource.StartActivity("Order.Process");
// business-specific work
```

### Attribute naming posture
```csharp
activity?.SetTag("http.request.method", request.Method);
activity?.SetTag("user.id", userId);
```

### Overhead gating
```csharp
if (Activity.Current?.IsAllDataRequested == true)
{
    activity?.SetTag("order.items.count", itemCount);
}
```

### Event volume alternatives
```csharp
// Prefer logs or links for high-volume events
logger.LogInformation("Processed item {ItemId}", itemId);
```
