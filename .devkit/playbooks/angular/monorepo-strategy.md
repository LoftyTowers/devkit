
# Monorepo strategy

- A monorepo is not required to benefit from modularisation. Nx's `--preset=angular-standalone` creates a single-app workspace with library support. Convert to a monorepo later with `nx g convert-to-monorepo` when multiple applications are needed.
- Consider splitting into multiple applications when different parts have: different scaling requirements, different user audiences (e.g. customer-facing vs. admin), independent deployment cycles, or separate security requirements.
- In a multi-project Angular CLI workspace (without Nx), use `ng new my-workspace --no-create-application` to create a workspace skeleton, then `ng generate application` and `ng generate library` for individual projects.
- PREFERENCE — JUSTIFIED: Use Nx for monorepo management over the built-in Angular CLI multi-project workspace. Nx provides computation caching, affected-command analysis, dependency graph visualisation, and module boundary enforcement.
  - Justified by Nx being the officially referenced monorepo tool in the Angular ecosystem with first-class support and an enterprise-grade architecture guide.
- Nx custom generators can be used to encode organisation-specific standards, ensuring that new libraries, components, and features follow established conventions automatically.

***

# SECTION 3 — HOW-TO PROCEDURES (DETERMINISTIC) + FILE PLACEMENT

