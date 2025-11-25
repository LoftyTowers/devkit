## Feature DoD
- Tests updated/added (unit; integration if boundary touched)
- Structured logs at meaningful points
- Errors mapped (Result<T>/ProblemDetails)
- Docs updated (README/ADR)
- Perf/security considered briefly
- Migrations safe (if data changed)
- Async public APIs include CancellationToken and are suffixed Async.
- Error mapping covers Validation(400), Domain(422), Unexpected(500).
- Structured logging includes CorrelationId + key identifiers in scope.
- Tests cover happy path + invalid input; assert exact HTTP status codes.
- DevKit self-check passed (Async+CT, scope keys, Result code, 400/422/500 mapping, edge try/catch, tests assert status, no unjustified seams).
- All classes use **constructor DI** for collaborators (logger, validator, repos, gateways, clock).
- No service locator, no static singletons for shared state.
- Only pure helpers are static.
- If a new seam added, a one-line reason is present in code.

- Extensibility considered using the decision table:
  - [ ] External boundary behind a port (if applicable)
  - [ ] Real variation → Strategy (only if ≥2 variants now/soon)
  - [ ] Construction differs → Factory (config/env)
  - [ ] Cross-cut → Decorator (logging/caching/metrics)
  - [ ] Otherwise: no pattern (keep it simple)
- One-line note explaining any new seam’s purpose.

## PR Review
Correctness • Boundaries • Tests • Logging • Security • Performance • Docs

- Over-engineering guard: Did we add an interface/class without a real boundary or variation?
- Patterns used match the triggers; else recommend simpler code.

## Package guard (dotnet)
- [ ] Does any file reference types from packages not in the `.csproj`?
- [ ] If yes, either add the PackageReference or output `dotnet add package ...` commands.
- [ ] Confirm `Directory.Build.props` has `<ImplicitUsings>enable</ImplicitUsings>`.

## New Feature Checklist (AI must apply all)

For any new endpoint / feature:

- [ ] Uses Result / Result<T> and ErrorCode enum for ALL errors.
- [ ] Uses CancellationToken on async methods and passes it through the stack.
- [ ] Validates input with FluentValidation and returns ErrorCode.Validation on failure.
- [ ] Uses logging scope with CorrelationId / TraceIdentifier.
- [ ] No `new` of dependencies inside controllers / endpoints (DI only).
- [ ] Tests cover: success, validation failure, domain failure, cancelled, unexpected.

If any item is not met, change the code to comply BEFORE considering the feature complete.
