# Build deployment devops

## Scope

This contract specifies required settings for production builds and deployments of Angular applications. It covers build optimizations, environment file configurations, and containerization requirements. Compliance is verified by inspecting the Angular workspace configuration and deployment artifacts.

## Rules

- The production build configuration MUST have `optimization` set to `true`.
- The production build configuration MUST have `outputHashing` set to `"all"`.
- The production build configuration MUST include a `fileReplacements` entry that replaces `src/environments/environment.ts` with a production environment file.
- Each non-production environment file (e.g. `environment.development.ts`) MUST set `production: false`.


## Prohibited patterns

- (none)


## Allowed deviations

(none)

### Verification mechanism

- Inspect `angular.json` and environment files to verify the above settings:
    - Check `angular.json` under `projects.[project].architect.build.configurations.production` for `optimization: true` and `outputHashing: "all"`.
    - Check `angular.json` for a file replacement entry replacing `src/environments/environment.ts` for production.
    - Check `src/environments/environment.ts` and other environment files for correct `production` boolean.
