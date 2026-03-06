# Configuration & Options (guidance)

## Scope

- Non-enforceable guidance for configuration binding and options patterns in .NET.

## When to use

## Guidance

### Strongly-typed binding (R2)

- Bind configuration sections to strongly-typed POCO options via `Configure<T>(...)` or the binder.
- Map one configuration section to one options type to keep ownership clear.

### Choosing the options abstraction

- Use `IOptions<T>` for static configuration that does not change at runtime.
- Use `IOptionsSnapshot<T>` for scoped/per-request configuration in request paths.
- Use `IOptionsMonitor<T>` for singleton services and when you need to observe runtime changes.

### Runtime reload

- For file-based providers, enable `reloadOnChange: true` when runtime reload is required.
- Use change tokens and `IOptionsMonitor<T>` to observe updates.
- Environment variables do not auto-reload; treat them as static unless the process is restarted.

### Validation approaches

- Use `ValidateDataAnnotations` for basic attribute validation.
- Use `Validate(...)` or `IValidateOptions<T>` for custom validation.
- Use `ValidateOnStart()` to fail fast when options are required for startup correctness.

### Secrets sources and priority

- Use User Secrets for development only.
- Use a secure store in production (e.g., Azure Key Vault).
- Use environment variables for overrides and fallback when needed.

## Allowed deviations

### D1: Reflection binding
- Reflection-based binding is acceptable when not trimming/AOT; the source generator is recommended.

### D2: Static configuration
- Static configuration is acceptable when settings are intentionally fixed for the process lifetime (no `reloadOnChange`, no `IOptionsMonitor<T>`).

### D3: Environment variables as secret source
- Environment variables may be used for secrets in production only when a secure store is not available.
- Environment variables do not auto-reload; document the limitation.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
