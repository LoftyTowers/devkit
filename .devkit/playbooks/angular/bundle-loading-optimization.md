# Bundle Loading Optimization

## Scope
This playbook covers Angular bundle loading, preloading strategies, and build configuration for optimized delivery. It focuses on lazy loading, preloading, and compile-time settings that affect bundle size and performance.

## Core guidance

## Rules & patterns
- Feature routes MUST be lazy loaded using loadChildren or loadComponent.
- Standalone components MUST be lazy loaded using loadComponent. — loadComponent: () => import('./feature/feature.component').then(c => c.FeatureComponent)
- Critical routes SHOULD be preloaded using an appropriate preloading strategy.
- Each lazy loading configuration MUST be treated as a separate JavaScript chunk.
- Small applications SHOULD use PreloadAllModules to preload lazy modules after initial render.
- Custom PreloadingStrategy MUST be implemented where selective preloading is required. — data: { preload: true }
- Route preloading SHOULD be driven by user behavior and analytics.
- Network conditions SHOULD be factored into route preloading decisions. — navigator.connection.effectiveType
- Preloading strategies MAY be chosen based on application context.
- Production builds MUST be used for deployment. — ng build
- Services MUST use providedIn to enable tree-shaking. — @Injectable({ providedIn: 'root' })
- Only required symbols SHOULD be imported instead of wildcard imports. — import { map } from 'rxjs/operators'
- Bundle size SHOULD be analyzed regularly. — ng build --source-map
- Size budgets SHOULD be defined in angular.json.
- Differential loading SHOULD be used where applicable.
- Budget thresholds MAY vary depending on application type. — <250KB initial
- AOT MUST be used for production builds. — ng build
- Strict template type checking MUST be enabled. — "strictTemplates": true
- Dynamic templates MUST use JIT compilation. — user-provided templates
- JIT MAY be used for development or specific dynamic scenarios.

## Anti-patterns
- Lazy-loaded components and services MUST NOT be imported into eager modules.
- Lazy-loaded feature components MUST NOT be imported into AppModule.
- Large features MUST NOT be eagerly loaded without code splitting.
- Applications SHOULD NOT be fragmented into too many small lazy-loaded chunks.
- Applications SHOULD NOT disable preloading entirely.
- Large applications MUST NOT use PreloadAllModules indiscriminately.
- Development builds MUST NOT be deployed.
- Entire libraries MUST NOT be imported using wildcard imports. — import * as _ from 'lodash'
- Applications SHOULD NOT omit bundle size budgets.
- Services MUST NOT be registered only in providers arrays when tree-shaking is required.
- Function constructors and eval MUST NOT be used in templates.
- JIT MUST NOT be used in production.
- Applications MUST NOT skip testing with AOT.
- JIT-only features MUST NOT be relied on when using AOT.

## Allowed deviations
- Teams MAY choose between PreloadAllModules and custom preloading based on context.

## Examples

## Cross-references