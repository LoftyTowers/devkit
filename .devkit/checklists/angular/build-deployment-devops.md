# Build deployment devops

## Checklist

- [ ] Verify that the production build configuration has `optimization: true`.
- [ ] Verify that the production build configuration has `outputHashing: "all"`.
- [ ] Ensure the production configuration in `angular.json` includes a file replacement for `src/environments/environment.ts`.
- [ ] Confirm that each development environment file (e.g. `environment.development.ts`) has `production: false`.
