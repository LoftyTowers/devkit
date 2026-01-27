# architecture checklist

## Purpose
Verify Angular architecture and structure compliance for Blob 1 (Architecture & Project Structure).

## Checklist
- [ ] File names use lowercase letters with dashes. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] File names include a dot-separated type suffix (e.g. `.component.ts`, `.service.ts`, `.guard.ts`). [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Feature folders remain flat until the folder contains 7+ files. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Code is organised by feature (business domain), not by technical type folders at root. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Application TypeScript code is under `src/app/` (not elsewhere in the repo). [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)

- [ ] If the project uses NgModules: CoreModule is imported only once in AppModule. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] If the project uses NgModules: CoreModule includes a re-import guard in its constructor. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] If the project uses NgModules: SharedModule contains commonly reused declarables only. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] If the project uses NgModules: CoreModule and SharedModule are not cross-imported. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Feature modules are organised by business domain. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Feature modules use lazy loading. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)

- [ ] New components are created as standalone components by default. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Components remain single-responsibility and are <= 400 lines, or a justification is documented. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Templates longer than 3 lines are extracted to external `.html` files. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Styles longer than 3 lines are extracted to external `.css`/`.scss` files. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Performance-critical components use `ChangeDetectionStrategy.OnPush`. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Inputs/Outputs are declared explicitly via `@Input`/`@Output` or `input()`/`output()`. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Business logic and presentation logic are not mixed in a single component. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)

- [ ] Singleton services use `providedIn: 'root'`. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Dependencies use constructor injection (or an approved modern equivalent); no ad-hoc injection outside an injection context. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Optional dependencies are marked with `@Optional()`. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] `InjectionToken` is used for non-class dependencies. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] Services are not added to component `providers` unless intentionally scoped and justified. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
- [ ] No circular dependencies are introduced between services. [Contract-backed] (.devkit/contracts/angular/architecture-structure.md)
