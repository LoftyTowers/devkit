# Configuration & Options

## Options class requirements
- Options classes MUST be non-abstract, MUST have a public parameterless constructor, and binding MUST target public read/write properties (not fields).

## Options lifetimes
- Code MUST choose the correct options abstraction:
  - `IOptions<T>` for singleton/static snapshot use where reload is not required.
  - `IOptionsSnapshot<T>` only for scoped usage.
  - `IOptionsMonitor<T>` for singleton usage and/or when reacting to runtime changes.

## Reload behaviour
- If runtime reload is required, file-based providers MUST enable `reloadOnChange` and options consumption MUST use `IOptionsMonitor<T>`.

## Options validation
- Options validation SHOULD be implemented and SHOULD be enforced at startup via `ValidateOnStart()` for fail-fast behaviour.

## Prohibited patterns
- Production secrets MUST NOT be stored in appsettings.json or code, and secrets MUST NOT be committed to source control.
- `IOptionsSnapshot<T>` MUST NOT be injected into singleton services.
- Environment variable changes MUST NOT be assumed to hot-reload into a running process.
- `IOptionsMonitor<T>` updates MUST NOT be expected without a provider that supports change tokens and, where applicable, `reloadOnChange`.
- Options validation MUST NOT be assumed to run at startup unless `ValidateOnStart()` is configured (default is first access).

## Notes / Cross-references
- See `.devkit/playbooks/dotnet/configuration-options.md` for examples, allowed deviations (D1–D3), and operational details.
