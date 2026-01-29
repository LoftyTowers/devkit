# Project Organization

## Scope

## Core guidance

## Rules & patterns
- Reusable components, directives, and pipes MUST be placed in SharedModule and imported into feature modules.
- Singleton services MUST be placed in CoreModule. auth, logging
- CoreModule MUST be imported only once and guarded against re-import.
- Feature modules MUST be organised by business domain. HeroesModule, DashboardModule
- Feature modules SHOULD be lazy loaded using loadChildren routing.

## Anti-patterns
- SharedModule and CoreModule MUST NOT import each other.
- Business logic MUST NOT be placed in SharedModule.
- CoreModule re-imports MUST NOT be allowed.

## Allowed deviations
- Standalone applications MAY use direct imports and providedIn: 'root' instead of CoreModule and SharedModule.

## Examples

## Cross-references
