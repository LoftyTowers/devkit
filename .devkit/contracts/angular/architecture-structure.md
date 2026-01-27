# architecture structure

## Scope
- This contract governs Angular application architecture and structure for:
  - File and folder naming conventions
  - Folder organisation patterns
  - NgModule patterns (Core/Shared/Feature) where NgModules are used
  - Standalone component defaults and component structuring rules
  - Dependency Injection (DI) architecture rules
- Explicitly in-scope:
  - All Angular application code under `src/app/`
  - Components, directives, pipes, services, guards, interceptors, resolvers, models/interfaces/types under `src/app/`
  - NgModule usage only when present in the project
- Explicitly out-of-scope:
  - Domain-Driven Design and bounded-context methodology (explicitly unsupported in the research sample)
  - Monorepo vs multi-repo strategies (explicitly unsupported in the research sample)
  - Build/bundling optimisations (covered by performance contract)
  - Security requirements (covered by security contract; not in this blob?s scope)

## Rules
- All file names MUST use lowercase letters with dashes separating words.
- File names MUST separate symbol name from file name with a dot followed by a type suffix.
  - Components MUST use `*.component.ts`
  - Services MUST use `*.service.ts`
  - Directives MUST use `*.directive.ts`
  - Pipes MUST use `*.pipe.ts`
  - Guards MUST use `*.guard.ts`
  - Interceptors MUST use `*.interceptor.ts`
  - Resolvers MUST use `*.resolver.ts`
  - Models MUST use `*.model.ts` OR `*.interface.ts`
- Folders MUST remain flat (no subfolders) until containing 7 or more files.
- Folder structure MUST organise code by feature (business domain), NOT by technical type.
- All application TypeScript code MUST reside within the `src/app/` directory structure.
- In NgModule-based projects, CoreModule MUST be imported only once, in AppModule.
- In NgModule-based projects, CoreModule MUST include a constructor guard that prevents re-import.
- In NgModule-based projects, SharedModule MUST be used for commonly reused declarables.
- Feature modules MUST be organised by business domain.
- Feature modules MUST use lazy loading.
- New components MUST be created as standalone components by default.
- Components SHOULD implement a single responsibility and remain under 400 lines of code.
- Component templates exceeding 3 lines MUST be extracted to separate `.html` files.
- Component styles exceeding 3 lines MUST be extracted to separate `.css`/`.scss` files.
- Performance-critical components MUST use `ChangeDetectionStrategy.OnPush`.
- Component input and output properties MUST be declared explicitly using `@Input`/`@Output` or `input()`/`output()`.
- Application-wide singleton services MUST use `providedIn: 'root'`.
- Dependencies SHOULD be injected via constructor injection.
- Optional dependencies MUST use the `@Optional()` decorator.
- `@Self()` and `@SkipSelf()` MAY be used to control injector hierarchy.
- Non-class dependencies MUST be injected using `InjectionToken`.

## Prohibited patterns
- Type-based folder organisation at application root (e.g. `components/`, `services/`, `models/` at root) MUST NOT be used.
- Deep nesting before the 7-file threshold MUST NOT be used.
- Mixing naming conventions for file names (camelCase, PascalCase, kebab-case) MUST NOT be used.
- In NgModule-based projects, SharedModule MUST NOT be imported into CoreModule and CoreModule MUST NOT be imported into SharedModule.
- In NgModule-based projects, business logic MUST NOT be placed in SharedModule.
- In NgModule-based projects, CoreModule without a re-import guard MUST NOT be used.
- Components exceeding 400 lines without documented justification MUST NOT be committed.
- Business logic and presentation logic MUST NOT be mixed in a single component.
- Inline templates longer than 3 lines MUST NOT be used.
- Default change detection MUST NOT be used everywhere without consideration for performance-critical components.
- Services MUST NOT be provided in component metadata unnecessarily when singleton behaviour is intended.
- Tree-shakeable services for new code MUST NOT be registered without `providedIn`.
- Circular dependencies between services MUST NOT be introduced.

## Allowed deviations
- Standalone components supersede NgModule patterns for new projects. CoreModule/SharedModule patterns MAY be used only in NgModule-based applications.
- The 400-line limit is a guideline; cohesive, single-responsibility components MAY exceed 400 lines with documented justification.
- The 3-line threshold for templates/styles is subjective; teams MAY adopt an ?always external templates/styles? convention.
- Module providers MAY be used for lazy-loaded module scopes; `providedIn` is preferred for tree-shaking.

## Cross-references
- .devkit/checklists/angular/architecture-checklist.md
- .devkit/contracts/angular/performance-optimization.contract.md
