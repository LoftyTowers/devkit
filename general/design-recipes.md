# Design Recipes (technology-neutral)

## When to add a seam
| Trigger | Add a seam via |
|---|---|
| Crossing an IO boundary (HTTP, DB, queue, filesystem) | Port + Adapter |
| Two or more real variants need swapping at runtime | Strategy or Factory |
| Optional behaviour toggled by feature flag or policy | Decorator |
| Integration owned by another team/vendor | Port + Adapter |

See also: examples under `examples/dotnet/patterns/` and the layered microservice walkthrough.
Always import the shared primitives from `examples/dotnet/layered-microservice/shared/`; never duplicate `Result`, `ErrorCode`, or related helpers in new samples.

## Endpoint recipe
- Keep controllers/edges thin; delegate to a handler/service.
- Validate input at the boundary.
- Domain returns Result values; map to transport errors at the edge.
- Add scoped, structured logs (correlation id + key identifiers).
See: examples/dotnet/design-recipes/api-endpoint/OrdersController.cs

## Validation flow
- Declarative rules near DTO.
- Fail fast; aggregate errors for 400 responses; don't throw for control flow.
See: examples/dotnet/design-recipes/validation/PayRequestValidator.cs

## Result -> ProblemDetails mapping
- Map Validation -> 400, domain failure -> 422, unexpected -> 500.
- Include an error code so mapping is deterministic.
See: `examples/dotnet/layered-microservice/shared/ResultExtensions.cs`

## Observability
- Log meaningful events (start/end, external I/O).
- Use scopes to attach correlation id and entity ids.
- (Optional) metrics/tracing if the platform supports it.
