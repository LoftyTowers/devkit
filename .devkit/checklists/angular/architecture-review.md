
# Architecture review

- [ ] Verify all source files use kebab-case naming with hyphens separating words.
- [ ] Verify file names match the primary TypeScript class they contain.
- [ ] Verify component `.ts`, `.html`, `.css`, and `.spec.ts` files share the same base name and reside in the same directory.
- [ ] Verify all Angular UI code is under `src/` and non-UI configuration is outside `src/`.
- [ ] Verify `main.ts` exists directly inside `src/` and bootstraps the application.
- [ ] Verify the project is organised by feature areas, with no top-level `components/`, `services/`, or `directives/` directories.
- [ ] Verify each source file contains a single primary concept (one component/directive/service per file).
- [ ] Confirm all component and directive selectors use the project-specific prefix defined in `angular.json`.
- [ ] Confirm no custom selector uses the reserved `ng` prefix.
- [ ] Verify all new components are generated as standalone (no `standalone: false` in schematic config or decorator).
- [ ] Verify standalone components declare template dependencies in their own `imports` array.
- [ ] Verify feature routes use `loadComponent` or `loadChildren` for lazy loading.
- [ ] Verify application-wide singleton services use `@Injectable({ providedIn: 'root' })`.
- [ ] Verify dependencies are injected via the `inject()` function, not constructor parameters.
- [ ] Verify route-scoped services are provided in the route `providers` array, not at root level.
- [ ] Verify component template-only members use `protected` access.
- [ ] Verify Angular-initialised properties (`input`, `output`, `model`, queries) are marked `readonly`.
- [ ] Verify Angular-specific properties are grouped at the top of the class, before methods.
- [ ] Verify `[class]`/`[style]` bindings are used instead of `ngClass`/`ngStyle`.
- [ ] Ensure `ApplicationConfig` (`app.config.ts`) uses `provideRouter(routes)` for routing configuration.
- [ ] Ensure unit test files are colocated with the code they test (no centralised `tests/` directory).

