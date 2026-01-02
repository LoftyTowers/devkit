# DevKit AI Manifest

Task routing: read the listed files in order, then apply the output expectations.

If you encounter checklist/procedural content:
- Checklists belong in `new/checklists/`.
- Recipes/how-to guidance belongs in `new/playbooks/`.

| Task/Intent | Read (ordered) | Output expectations |
|---|---|---|
| Logging (dotnet) | `new/contracts/dotnet/logging.md` | Use structured logging with message templates and named properties. Use scopes for correlation + key identifiers. Log exceptions once at the operational boundary only. |
| Exceptions & outcome handling (dotnet) | `new/contracts/dotnet/exceptions.md`<br>`new/contracts/dotnet/result-pattern.md` | Apply the canonical boundary try/catch policy. Use the approved Result/ErrorCode model for normal outcomes. Do not use exceptions for expected validation/domain outcomes. |
| Swagger/OpenAPI | `new/contracts/general/swagger-openapi.md`<br>`new/contracts/dotnet/package-management.md` | Apply the standard Swagger/OpenAPI setup. When Swagger requires packages, add `<PackageReference>` and show the edited `.csproj` snippet. |
| Packages/dependencies (dotnet) | `new/contracts/dotnet/package-management.md`<br>`new/contracts/dotnet/libraries.md` | When code relies on a library that may not exist, add `<PackageReference>` entries and show the edited `.csproj` snippet. Keep to the pinned stack unless a deviation is justified. |
| Dependency Injection (general + dotnet) | `new/contracts/general/dependency-injection.md`<br>`new/contracts/dotnet/dependency-injection.md` | Use constructor DI. Do not use service locator patterns. Apply lifetime guidance where relevant. |
| EF Core / data access | `new/contracts/dotnet/efcore.md` | Follow EF Core guidance for data access patterns and correctness/performance guardrails. |
| HTTP clients / integrations | `new/contracts/dotnet/http-clients.md` | Use the approved HTTP client patterns and lifetimes; avoid ad-hoc client construction. |
| Security-related changes | `new/contracts/general/security-baseline.md`<br>`new/contracts/general/config-and-env.md` | Preserve security baselines. Handle configuration safely. Do not introduce secrets into code, config, or logs. |
| Testing changes (general + NUnit) | `new/contracts/general/testing.md`<br>`new/contracts/dotnet/testing-nunit.md` | Meet operational testing expectations. Use the required test framework and conventions. Tests must assert behaviour (outcomes/events/status), not implementation details. |
| Repo/project structure changes | `new/START-HERE.md`<br>`new/contracts/dotnet/project-structure.md` | Keep repository layout and project structure consistent with the DevKit. |
