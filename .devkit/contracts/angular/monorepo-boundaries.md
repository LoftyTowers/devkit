
# Monorepo boundaries

## Scope
Governs library type classification and inter-project dependency constraints in Nx monorepo workspaces. Enforceable via Nx module boundary lint rules and project tags.

## Rules
- Every library project in an Nx workspace MUST be tagged with a `type:` tag (`feature`, `ui`, `data-access`, or `util`) and a `scope:` tag reflecting its business domain.
  - Evidence: Nx docs define four canonical library types and state tags are used to "enforce project dependency rules based on the types of each project." Enforceable via `@nx/enforce-module-boundaries` ESLint rule.
- Feature libraries MAY depend on any library type (`feature`, `ui`, `data-access`, `util`).
  - Evidence: Nx docs: "A feature library can depend on any type of library."
- UI libraries MUST depend only on `ui` and `util` libraries.
  - Evidence: Nx docs: "A ui library can depend on ui and util libraries." Enforceable via `@nx/enforce-module-boundaries`.
- Data-access libraries MUST depend only on `data-access` and `util` libraries.
  - Evidence: Nx docs: "A data-access library can depend on data-access and util libraries."
- Utility libraries MUST depend only on other `util` libraries.
  - Evidence: Nx docs: "A utility library can depend only on utility libraries."
- Module boundary rules MUST be configured in the workspace ESLint configuration using `@nx/enforce-module-boundaries`.
  - Evidence: Nx architecture guide: "These rules are enforced at build time through ESLint."

## Prohibited patterns
- MUST NOT allow a `ui` library to import from a `feature` or `data-access` library.
- MUST NOT allow a `util` library to import from `feature`, `ui`, or `data-access` libraries.
- MUST NOT allow cross-domain imports unless explicitly permitted in scope rules.

## Allowed deviations
- MAY define additional library types beyond the four canonical types if clearly documented and the number remains small.

