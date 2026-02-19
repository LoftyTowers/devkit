# Dependency injection

## Procedure: Provide a configuration value with `InjectionToken`

### When to use

When you need to inject a configuration object, primitive, or function (non-class value) globally via DI.

### Preconditions

- You have an Angular application bootstrapped (with a root or platform injector).
- You have a value (config object, API URL, etc.) to inject across the app.


### Steps

1. **Define an InjectionToken:** In a TypeScript file, import `InjectionToken` from `@angular/core` and create a new token for your value. For example:
```ts
export const API_URL = new InjectionToken<string>('api.url');
```

(This token serves as the key for DI.)
2. **Provide the value or factory:** Add the token to an Angular `providers` array or via `providedIn`. For a root-level value, you can either:
- Use `useValue`: In `main.ts` or a root module, provide the value:

```ts
{ provide: API_URL, useValue: 'https://api.example.com' }
```

    - Use `useFactory`: If the value requires computation, define a factory function and provide it:
    ```ts
function apiUrlFactory(): string {
  return environment.production ? 'https://api.prod' : 'https://api.dev';
}
// In providers:
{ provide: API_URL, useFactory: apiUrlFactory }
```

    - Or with `providedIn`: Create the token with a factory and `providedIn: 'root'`, making it global and tree-shakable:
    ```ts
export const APP_CONFIG = new InjectionToken<AppConfig>('app.config', {
  providedIn: 'root',
  factory: () => ({ apiUrl: 'https://api.example.com', version: '1.0.0' }),
});
```

(Angular will automatically provide this value in the root injector.)
3. **Inject the value:** In any component or service, inject the value using `@Inject` or the `inject()` function. For example:

```ts
constructor(@Inject(API_URL) private apiUrl: string) { }
```

or using the new `inject()` syntax inside a class field:

```ts
private apiUrl = inject(API_URL);
```


### Validation

- **Injected value available:** In the component/service using it, confirm that the injected value matches the expected configuration (e.g. log or use the value).
- **No compile errors:** TypeScript compilation should succeed without errors about missing providers or invalid tokens.
- **Provider array:** Verify that you only used `InjectionToken` for the token (not an interface or literal).


## Procedure: Implement the `forRoot()` pattern in a module

### When to use

When building an NgModule that provides services (via `providers`) which must be singletons even if the module is imported by multiple feature modules.

### Preconditions

- You have an NgModule (e.g. `SharedModule`) that lists providers (services, tokens) in its `@NgModule.providers`.
- You plan to import this module in both the root module and one or more feature modules.


### Steps

1. **Create a static `forRoot()` method:** In your module class, add a static method `forRoot()` that returns `ModuleWithProviders<YourModule>`. Move the providers into this method's return value. For example:
```ts
@NgModule({ /* declarations, etc. */ })
export class SharedModule {
  static forRoot(): ModuleWithProviders<SharedModule> {
    return {
      ngModule: SharedModule,
      providers: [
        MyService,      // providers moved here
        { provide: APP_CONFIG, useValue: config },
      ],
    };
  }
}
```

(Step-by-step: create `forRoot`, put `providers` array inside, and return it with `ngModule`.)
2. **Import the module with `forRoot()` in the root:** In your `AppModule`, import `SharedModule.forRoot()` instead of `SharedModule`. Example:

```ts
@NgModule({
  imports: [
    BrowserModule,
    SharedModule.forRoot(),
    /* ... */
  ],
})
export class AppModule {}
```

3. **Import the module normally in feature modules:** In all other modules (lazy-loaded or feature modules), import `SharedModule` without calling `forRoot()`. Example:
```ts
@NgModule({
  imports: [
    SharedModule,
    /* ... */
  ],
})
export class FeatureModule {}
```

This ensures the providers are registered only once (in the root injector).

### Validation

- **Singleton instance:** Inject one of the provided services in components from both the root and a lazy module. Confirm the same instance is used (e.g. by checking shared state or comparing `===`).
- **Provider count:** Ensure there is only one provider entry for each service (e.g. search the compiled code or injector diagnostics).
- **Module imports:** Check that the root module imports `SharedModule.forRoot()` and other modules import `SharedModule` only.
