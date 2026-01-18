# Observability with OpenTelemetry

## Scope

## Rules

### Context propagation

- Context propagation MUST use the SDK/instrumentation defaults (W3C TraceContext) unless there is an explicit custom requirement.

### Providers and sources

- The service MUST configure one long-lived `TracerProvider` per process/service and MUST NOT create providers per request or per operation.
- Code MUST use a single shared `ActivitySource` instance and MUST NOT create `ActivitySource` instances frequently.
- Code MUST use a single shared `Meter` instance per component/library and MUST NOT create `Meter` instances per call or request.
- `Meter` names MUST follow OpenTelemetry-style naming conventions (stable, component-scoped, no per-request values).

### Activity lifecycle

- Activities MUST be properly ended (Stop/Dispose); unfinished Activities MUST NOT be left open.

### Resource identity

- Resource attributes MUST be set consistently at provider configuration time, including `service.name` and environment metadata.

### Span naming

- Span names MUST follow semantic conventions (e.g., HTTP spans use "<METHOD> <route>", not raw URLs).

### Exporters

- Production telemetry MUST configure at least one exporter pipeline.

## Prohibited patterns

- Creating `TracerProvider` instances per request, per operation, or frequently during runtime MUST NOT occur.
- Creating many `ActivitySource` instances (e.g., inside methods) instead of reusing a shared instance MUST NOT occur.
- Creating `Meter` or instruments per request or per call instead of reusing shared instances MUST NOT occur.
- Starting Activities without guaranteed Stop/Dispose (e.g., missing using/finally patterns) MUST NOT occur.
- Using raw URLs or high-cardinality values as span names (especially for HTTP) MUST NOT occur.
- Emitting high-cardinality attributes/tags (e.g., user email, full URL, unbounded IDs) without deliberate design MUST NOT occur.
- Adding large or unbounded numbers of Activity events in tight loops MUST NOT occur.
- Using baggage as a general-purpose context store or adding large baggage payloads that propagate on every downstream call MUST NOT occur.
- Skipping resource identity (service.name/service.version/environment) causing telemetry to be hard to attribute MUST NOT occur.

## Allowed deviations

- Multiple `TracerProvider` instances MAY be used only for rare, justified isolated pipelines; the justification MUST be documented.
- Exporter choice MAY vary (OTLP/Jaeger/Zipkin/App Insights), but at least one production exporter pipeline MUST be configured.

## Cross-references

- None.
