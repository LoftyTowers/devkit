# Dependency injection

## Checklist

- [ ] Verify each provider object in `providers` uses exactly one of `useClass`, `useValue`, `useFactory`, or `useExisting`.
- [ ] Ensure no provider token is a TypeScript interface or literal; tokens must be classes or `InjectionToken` instances.
- [ ] Ensure that if a token has multiple providers, every provider entry sets `multi: true`.
- [ ] Confirm no service or token uses `providedIn: 'any'` or a specific NgModule in its `@Injectable` or `InjectionToken` (both are deprecated).
