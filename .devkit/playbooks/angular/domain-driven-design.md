
# Domain driven design

- Organise the codebase around business domains rather than by technical types (components, services, directives). Good candidates for domains are areas with distinct business capabilities, areas that mirror team structure (Conway's Law), areas that can evolve independently, and areas with clear responsibilities.
- Use a vertical architecture approach: functional segments aligned with business capabilities. This contrasts with horizontal/layered approaches that divide by technical responsibility.
- Within each domain, further split into library types as the domain grows: feature libraries (`feat-*`) for business use cases, UI libraries (`ui-*`) for presentational components, data-access libraries for API and state management.
- PREFERENCE — JUSTIFIED: Use a dual-tagging strategy (`scope:<domain>` + `type:<library-type>`) for Nx projects to enforce both domain boundaries and architectural layer rules simultaneously.
  - Justified by Nx official architecture guide recommending this approach for encoding both vertical and horizontal constraints.
- Domain scope rules should encode which domains can depend on each other. For example, an `orders` domain may depend on `products`, but `products` should not depend on `orders`. Every domain may depend on `shared`.
- PREFERENCE — JUSTIFIED: Use TypeScript path mappings (e.g. `@myshop/products-data-access`) to make domain and library-type immediately visible at the import site.
  - Justified by Nx architecture guide demonstrating `tsconfig.base.json` path mappings for clarity.

