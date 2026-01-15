# DevKit AI Manifest

Purpose:
Router only. This file contains no technical rules.
For a given task, load the listed files in order.

Load order conventions (within a route):
1) Contracts (General baseline first, then Dotnet overrides)
2) Checklists
3) How-to / Playbooks (advisory)

## Route selection (required)

### Baseline selection (defaults)
Use these defaults to avoid under-loading rules:

- Always include **Foundation** for any non-trivial task that changes code or configuration.
- Include the baseline route(s) for each technology area the task touches (e.g., Dotnet, Angular, Sql),
  based on the files/projects being changed.

Do NOT manually enumerate additional concerns (e.g., EFCore, logging, async).
Those are handled by the post-change Diff-to-Concern scan and controlled expansion rules.

### Intent selection
- Choose the single best-matching route by task intent.
- If multiple routes apply, load the union in the order listed (contracts -> checklists -> how-to/playbooks).
- If unsure, start with Foundation, then add the most specific checklist or how-to/playbook.

### Technology detection (for baseline selection)
Treat a technology area as "touched" if the change set includes files in that area’s project/module
or typical extensions. Examples (non-exhaustive):
- Dotnet: `*.cs`, `*.csproj`, `*.sln`, `appsettings*.json`, `Directory.Build.props`, `Directory.Build.targets`
- Angular: `angular.json`, frontend `package.json`, `*.ts`, `*.html`, `*.scss` within the Angular app
- Sql: `*.sql` (migrations / schema / stored procedures)

If unsure, include Foundation and record a review item.


## Controlled dynamic expansion (allowed)

If the task's diff introduces a concern that is not covered by the currently loaded routes,
the AI MAY add additional routes ONLY if:

- The route is listed in the "Expansion allowlist" below, AND
- The expansion is triggered by an observable change in the diff (not reinterpretation of task intent), AND
- The AI records: trigger -> route(s) added -> newly loaded file paths.

When unioning multiple routes:
- Preserve relative order within each route list.
- De-duplicate identical file paths while keeping the first occurrence.
- Apply the existing load-order conventions: contracts -> checklists -> how-to/playbooks.

## Expansion allowlist (routes that may be added post-start)

- Foundation (Cross-cutting foundation)
- Dotnet (Dotnet platform rules)
- Review: HTTP endpoint review (general)
- Operations: Operational readiness (general)
- Review: Package guard (dotnet)
- API: HTTP API change (cross-cutting)
- Platform: Dependency introduction (cross-cutting)
- Data: Data access change (cross-cutting)
- Dotnet: Composition root changes (dotnet)
- Sql (SQL Server rules)

## Empty contracts (required handling)
- If a loaded file contains only `<!-- INTENTIONALLY EMPTY -->`, treat it as "no additional rules defined".
- Continue using the other loaded files and general best practices as allowed by precedence.
- Only record a review item if the current task clearly depends on that missing guidance.

If a listed file does not exist: stop and report the missing path. Do not guess.

---

## Contracts-first routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| Foundation | Cross-cutting foundation (general) | **General (contracts):**<br>`.devkit/contracts/general/contract-format.md`<br>`.devkit/contracts/general/code-design.md`<br>`.devkit/contracts/general/coding-patterns.md`<br>`.devkit/contracts/general/dependency-injection.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br>`.devkit/contracts/general/logging.md`<br>`.devkit/contracts/general/config-and-env.md`<br>`.devkit/contracts/general/docker-and-deploy.md`<br>`.devkit/contracts/general/swagger-openapi.md`<br>`.devkit/contracts/general/api-design.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md`<br>`.devkit/playbooks/general/dependency-injection.md` |
| Dotnet | Dotnet platform rules (dotnet) | **General (contracts):**<br>`.devkit/contracts/general/contract-format.md`<br>`.devkit/contracts/general/code-design.md`<br>`.devkit/contracts/general/coding-patterns.md`<br>`.devkit/contracts/general/dependency-injection.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br>`.devkit/contracts/general/logging.md`<br>`.devkit/contracts/general/config-and-env.md`<br>`.devkit/contracts/general/docker-and-deploy.md`<br>`.devkit/contracts/general/swagger-openapi.md`<br>`.devkit/contracts/general/api-design.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/naming.md`<br>`.devkit/contracts/dotnet/project-structure.md`<br>`.devkit/contracts/dotnet/dependency-injection.md`<br>`.devkit/contracts/dotnet/async-cancellation.md`<br>`.devkit/contracts/dotnet/exceptions.md`<br>`.devkit/contracts/dotnet/result-pattern.md`<br>`.devkit/contracts/dotnet/logging.md`<br>`.devkit/contracts/dotnet/http-clients.md`<br>`.devkit/contracts/dotnet/observability-opentelemetry.md`<br>`.devkit/contracts/dotnet/diagnostics-runtime.md`<br>`.devkit/contracts/dotnet/configuration-options.md`<br>`.devkit/contracts/dotnet/security-aspnetcore.md`<br>`.devkit/contracts/dotnet/api-design-middleware.md`<br>`.devkit/contracts/dotnet/background-work.md`<br>`.devkit/contracts/dotnet/efcore.md`<br>`.devkit/contracts/dotnet/middleware.md`<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br>`.devkit/contracts/dotnet/testing-nunit.md`<br>`.devkit/contracts/dotnet/documentation.md`<br>`.devkit/contracts/dotnet/modern-language-features.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md`<br>`.devkit/playbooks/general/dependency-injection.md`<br><br>**Dotnet (playbooks):**<br>`.devkit/playbooks/dotnet/style-preferences.md`<br>`.devkit/playbooks/dotnet/naming-conventions.md`<br>`.devkit/playbooks/dotnet/records-vs-classes.md`<br>`.devkit/playbooks/dotnet/pattern-matching-vs-polymorphism.md`<br>`.devkit/playbooks/dotnet/dependency-injection.md`<br>`.devkit/playbooks/dotnet/async-concurrency.md`<br>`.devkit/playbooks/dotnet/http-client-timeouts.md`<br>`.devkit/playbooks/dotnet/request-timeouts.md`<br>`.devkit/playbooks/dotnet/httpclient-resilience.md`<br>`.devkit/playbooks/dotnet/httpclient-deviations.md`<br>`.devkit/playbooks/dotnet/observability-opentelemetry.md`<br>`.devkit/playbooks/dotnet/diagnostics-runtime.md`<br>`.devkit/playbooks/dotnet/gc-tuning.md`<br>`.devkit/playbooks/dotnet/configuration-options.md`<br>`.devkit/playbooks/dotnet/security-aspnetcore.md`<br>`.devkit/playbooks/dotnet/api-design-middleware.md`<br>`.devkit/playbooks/dotnet/background-work.md`<br>`.devkit/playbooks/dotnet/efcore-queries.md`<br>`.devkit/playbooks/dotnet/efcore-concurrency.md`<br>`.devkit/playbooks/dotnet/efcore-migrations.md`<br>`.devkit/playbooks/dotnet/efcore-performance.md`<br><br>**Dotnet (how-to):**<br>`.devkit/how-to/dotnet/data-protection-keys.md`<br>`.devkit/how-to/dotnet/diagnostics-in-containers.md`<br>`.devkit/how-to/dotnet/cors-requirecors.md`<br>`.devkit/how-to/dotnet/authz-per-endpoint.md` |
| Sql | SQL Server rules (sql) | **SQL Server (contracts):**<br>`.devkit/contracts/sql/keys.md`<br>`.devkit/contracts/sql/relationships.md`<br>`.devkit/contracts/sql/data-types.md`<br>`.devkit/contracts/sql/constraints.md`<br>`.devkit/contracts/sql/computed-columns.md`<br>`.devkit/contracts/sql/sparse-columns.md`<br>`.devkit/contracts/sql/null-handling.md`<br><br>**SQL Server (checklists):**<br>`.devkit/checklists/sql/sql-server.md`<br><br>**SQL Server (playbooks):**<br>`.devkit/playbooks/sql/index-design.md`<br>`.devkit/playbooks/sql/data-types.md`<br>`.devkit/playbooks/sql/constraints.md`<br>`.devkit/playbooks/sql/schema-evolution.md`<br>`.devkit/playbooks/sql/authority-boundaries.md` |
| Sql | Blob B — Query Design & Correctness (sql) | **SQL Server (contracts):**<br>`.devkit/contracts/sql/query-shape.md`<br>`.devkit/contracts/sql/result-set-sizing.md`<br>`.devkit/contracts/sql/sargability.md`<br>`.devkit/contracts/sql/type-correctness.md`<br>`.devkit/contracts/sql/join-correctness.md`<br>`.devkit/contracts/sql/subquery-semantics.md`<br>`.devkit/contracts/sql/cte.md`<br>`.devkit/contracts/sql/order-determinism.md`<br>`.devkit/contracts/sql/pagination.md`<br>`.devkit/contracts/sql/dynamic-sql.md`<br>`.devkit/contracts/sql/set-operators.md`<br>`.devkit/contracts/sql/aggregation-filtering.md`<br>`.devkit/contracts/sql/isolation-and-nolock.md`<br>`.devkit/contracts/sql/merge.md`<br>`.devkit/contracts/sql/authority-boundaries.md`<br><br>**SQL Server (checklists):**<br>`.devkit/checklists/sql/sql-server.md`<br>`.devkit/checklists/sql/query-design.md`<br><br>**SQL Server (playbooks):**<br>`.devkit/playbooks/sql/query-shape.md`<br>`.devkit/playbooks/sql/result-set-sizing.md`<br>`.devkit/playbooks/sql/sargability.md`<br>`.devkit/playbooks/sql/joins.md`<br>`.devkit/playbooks/sql/window-functions.md`<br>`.devkit/playbooks/sql/pagination-stability.md`<br>`.devkit/playbooks/sql/query-hints.md`<br>`.devkit/playbooks/sql/set-operators.md`<br>`.devkit/playbooks/sql/aggregation.md`<br>`.devkit/playbooks/sql/null-functions.md`<br>`.devkit/playbooks/sql/isolation-levels.md`<br>`.devkit/playbooks/sql/set-based-dml.md`<br>`.devkit/playbooks/sql/schema-evolution.md`<br>`.devkit/playbooks/sql/data-types.md`<br><br>**SQL Server (how-to):**<br>`.devkit/how-to/sql/diagnostic-queries.md`<br>`.devkit/how-to/sql/exports-and-bulk-reads.md`<br>`.devkit/how-to/sql/plan-verification.md`<br>`.devkit/how-to/sql/type-alignment.md`<br>`.devkit/how-to/sql/exists-in-join-selection.md`<br>`.devkit/how-to/sql/cte-recursion-safety.md`<br>`.devkit/how-to/sql/determinism-and-ties.md`<br>`.devkit/how-to/sql/pagination-choice.md`<br>`.devkit/how-to/sql/keyset-pagination.md`<br>`.devkit/how-to/sql/dynamic-sql-safe-forms.md`<br>`.devkit/how-to/sql/measurement-without-thresholds.md`<br>`.devkit/how-to/sql/row-by-row-exceptions.md`<br>`.devkit/how-to/sql/coalesce-vs-isnull.md` |


---

## Checklist-first routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| Delivery | Feature completion (general) | **General (contracts):**<br>`.devkit/contracts/general/testing.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/feature-definition-of-done.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/efcore.md` |
| Review | HTTP endpoint review (general) | **General (contracts):**<br>`.devkit/contracts/general/api-design.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/testing.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/http-endpoint-checklist.md` |
| Operations | Operational readiness (general) | **General (contracts):**<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/operational-checklist.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/efcore.md` |
| Review | PR review (general) | **General (checklists):**<br>`.devkit/checklists/general/pr-review.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/efcore.md` |
| Review | Package guard (dotnet) | **Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/package-guard.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |

---

## How-to routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| Dotnet | Composition root changes (dotnet) | **General (contracts):**<br>`.devkit/contracts/general/dependency-injection.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/dependency-injection.md`<br><br>**Dotnet (how-to):**<br>`.devkit/how-to/dotnet/composition-root.md`<br>`.devkit/how-to/dotnet/di-scopes-and-disposal.md`<br>`.devkit/how-to/dotnet/background-services-scoped-deps.md`<br>`.devkit/how-to/dotnet/nrt-migration-incremental.md`<br>`.devkit/how-to/dotnet/required-members-and-setsrequiredmembers.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |

---

## Composite routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| API | HTTP API change (cross-cutting) | **General (contracts):**<br>`.devkit/contracts/general/api-design.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br>`.devkit/contracts/general/logging.md`<br>`.devkit/contracts/general/swagger-openapi.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/exceptions.md`<br>`.devkit/contracts/dotnet/result-pattern.md`<br>`.devkit/contracts/dotnet/logging.md`<br>`.devkit/contracts/dotnet/async-cancellation.md`<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br>`.devkit/contracts/dotnet/testing-nunit.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/http-endpoint-checklist.md`<br>`.devkit/checklists/general/operational-checklist.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |
| Platform | Dependency introduction (cross-cutting) | **General (contracts):**<br>`.devkit/contracts/general/dependency-injection.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/dependency-injection.md`<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/package-guard.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |
| Data | Data access change (cross-cutting) | **General (contracts):**<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/testing.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/efcore.md`<br>`.devkit/contracts/dotnet/exceptions.md`<br>`.devkit/contracts/dotnet/result-pattern.md`<br>`.devkit/contracts/dotnet/testing-nunit.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md`<br><br>**Dotnet (playbooks):**<br>`.devkit/playbooks/dotnet/efcore-queries.md`<br>`.devkit/playbooks/dotnet/efcore-concurrency.md`<br>`.devkit/playbooks/dotnet/efcore-migrations.md`<br>`.devkit/playbooks/dotnet/efcore-performance.md`<br><br>**Dotnet (how-to):**<br>`.devkit/how-to/dotnet/efcore-transactions.md` |
