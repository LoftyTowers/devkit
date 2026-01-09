# DevKit AI Manifest

Purpose:
Router only. This file contains no technical rules.
For a given task, load the listed files in order.

Load order conventions (within a route):
1) Contracts (General baseline first, then Dotnet overrides)
2) Checklists
3) How-to / Playbooks (advisory)

## Route selection (required)
- Choose the single best-matching route by task intent.
- If multiple routes apply, load the union in the order listed (contracts -> checklists -> how-to/playbooks).
- If unsure, start with Foundation, then add the most specific checklist or how-to/playbook.

## Empty contracts (required handling)
- If a loaded file contains only `<!-- INTENTIONALLY EMPTY -->`, treat it as "no additional rules defined".
- Continue using the other loaded files and general best practices as allowed by precedence.
- Only record a review item if the current task clearly depends on that missing guidance.

If a listed file does not exist: stop and report the missing path. Do not guess.

---

## Contracts-first routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| Foundation | Cross-cutting foundation (general) | **General (contracts):**<br>`.devkit/contracts/general/contract-format.md`<br>`.devkit/contracts/general/code-design.md`<br>`.devkit/contracts/general/coding-patterns.md`<br>`.devkit/contracts/general/dependency-injection.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br>`.devkit/contracts/general/logging.md`<br>`.devkit/contracts/general/config-and-env.md`<br>`.devkit/contracts/general/docker-and-deploy.md`<br>`.devkit/contracts/general/swagger-openapi.md`<br>`.devkit/contracts/general/api-design.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |
| Dotnet | Dotnet platform rules (dotnet) | **General (contracts):**<br>`.devkit/contracts/general/contract-format.md`<br>`.devkit/contracts/general/code-design.md`<br>`.devkit/contracts/general/coding-patterns.md`<br>`.devkit/contracts/general/dependency-injection.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br>`.devkit/contracts/general/logging.md`<br>`.devkit/contracts/general/config-and-env.md`<br>`.devkit/contracts/general/docker-and-deploy.md`<br>`.devkit/contracts/general/swagger-openapi.md`<br>`.devkit/contracts/general/api-design.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/naming.md`<br>`.devkit/contracts/dotnet/project-structure.md`<br>`.devkit/contracts/dotnet/dependency-injection.md`<br>`.devkit/contracts/dotnet/async-cancellation.md`<br>`.devkit/contracts/dotnet/exceptions.md`<br>`.devkit/contracts/dotnet/result-pattern.md`<br>`.devkit/contracts/dotnet/logging.md`<br>`.devkit/contracts/dotnet/http-clients.md`<br>`.devkit/contracts/dotnet/efcore.md`<br>`.devkit/contracts/dotnet/middleware.md`<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br>`.devkit/contracts/dotnet/testing-nunit.md`<br>`.devkit/contracts/dotnet/documentation.md`<br>`.devkit/contracts/dotnet/modern-language-features.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md`<br><br>**Dotnet (playbooks):**<br>`.devkit/playbooks/dotnet/style-preferences.md`<br>`.devkit/playbooks/dotnet/naming-conventions.md`<br>`.devkit/playbooks/dotnet/records-vs-classes.md`<br>`.devkit/playbooks/dotnet/pattern-matching-vs-polymorphism.md` |

---

## Checklist-first routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| Delivery | Feature completion (general) | **General (contracts):**<br>`.devkit/contracts/general/testing.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/feature-definition-of-done.md` |
| Review | HTTP endpoint review (general) | **General (contracts):**<br>`.devkit/contracts/general/api-design.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/testing.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/http-endpoint-checklist.md` |
| Operations | Operational readiness (general) | **General (contracts):**<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/operational-checklist.md` |
| Review | PR review (general) | **General (checklists):**<br>`.devkit/checklists/general/pr-review.md` |
| Review | Package guard (dotnet) | **Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/package-guard.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |

---

## How-to routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| Dotnet | Composition root changes (dotnet) | **General (contracts):**<br>`.devkit/contracts/general/dependency-injection.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/dependency-injection.md`<br><br>**Dotnet (how-to):**<br>`.devkit/how-to/dotnet/composition-root.md`<br>`.devkit/how-to/dotnet/nrt-migration-incremental.md`<br>`.devkit/how-to/dotnet/required-members-and-setsrequiredmembers.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |

---

## Composite routes

| Task Area | Intent | Files to load (in order) |
|---|---|---|
| API | HTTP API change (cross-cutting) | **General (contracts):**<br>`.devkit/contracts/general/api-design.md`<br>`.devkit/contracts/general/validation.md`<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/testing.md`<br>`.devkit/contracts/general/security-baseline.md`<br>`.devkit/contracts/general/logging.md`<br>`.devkit/contracts/general/swagger-openapi.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/exceptions.md`<br>`.devkit/contracts/dotnet/result-pattern.md`<br>`.devkit/contracts/dotnet/logging.md`<br>`.devkit/contracts/dotnet/async-cancellation.md`<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br>`.devkit/contracts/dotnet/testing-nunit.md`<br><br>**General (checklists):**<br>`.devkit/checklists/general/http-endpoint-checklist.md`<br>`.devkit/checklists/general/operational-checklist.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |
| Platform | Dependency introduction (cross-cutting) | **General (contracts):**<br>`.devkit/contracts/general/dependency-injection.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/dependency-injection.md`<br>`.devkit/contracts/dotnet/package-management.md`<br>`.devkit/contracts/dotnet/libraries.md`<br><br>**Dotnet (checklists):**<br>`.devkit/checklists/dotnet/package-guard.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |
| Data | Data access change (cross-cutting) | **General (contracts):**<br>`.devkit/contracts/general/exceptions.md`<br>`.devkit/contracts/general/testing.md`<br><br>**Dotnet override (contracts):**<br>`.devkit/contracts/dotnet/efcore.md`<br>`.devkit/contracts/dotnet/exceptions.md`<br>`.devkit/contracts/dotnet/result-pattern.md`<br>`.devkit/contracts/dotnet/testing-nunit.md`<br><br>**General (playbooks):**<br>`.devkit/playbooks/general/operational-entrypoint-decision-matrix.md` |
