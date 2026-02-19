# Dependency injection

## Scope

This category covers Angular dependency injection and service provisioning practices. It governs how to configure and provide services and other injectable values in Angular applications, including the `@Injectable` `providedIn` patterns, use of `InjectionToken`, provider configuration (`useClass`, `useValue`, `useFactory`, `useExisting`), multi-provider flags, and module-level provider patterns (`forRoot()`/`forChild()`).

## Rules

- Provider configuration objects MUST specify exactly one of `useClass`, `useValue`, `useFactory`, or `useExisting`. (Verification: Static analysis (custom ESLint/TypeScript AST rule) that flags provider objects missing a useClass/useValue/useFactory/useExisting field or containing more than one of these fields.)
- Dependency-injection tokens MUST be actual classes or `InjectionToken` instances; TypeScript interfaces or type aliases MUST NOT be used directly as tokens. (Verification: The TypeScript/Angular compiler will error on interface tokens.)
- When multiple providers supply values for the same injection token, each provider entry MUST set `multi: true`. (Verification: Static analysis (custom ESLint/TS AST rule) that detects multiple provider entries for the same token and requires each entry to include multi: true.)
- The `providedIn` property of `@Injectable` or `InjectionToken` MUST NOT use the deprecated options `NgModule` (specific module class) or the string `'any'`. (Verification: Static analysis (custom ESLint/TS AST rule) that flags providedIn: 'any' and providedIn: <NgModuleClass> usages in @Injectable and InjectionToken declarations.)


## Prohibited patterns

- Providers defined with both `useFactory` and `useClass`/`useValue`/`useExisting` (multiple useX fields). Verification mechanism: Static analysis (custom ESLint/TS AST rule) that flags provider objects containing more than one of useClass/useValue/useFactory/useExisting.
- Using a TypeScript interface or literal string as a provider token in a providers array. Verification mechanism: Static analysis (TypeScript/ESLint) that bans provider tokens that are not a class identifier or an InjectionToken instance reference.


## Allowed deviations

- MAY use `useExisting` to alias one provider to another (sharing the same instance).
- MAY implement a static `forRoot()` method on a module to expose providers for the application root.
- MAY provide a service with `providedIn: 'platform'` if the service must be shared across multiple Angular apps on the same page (using the platform injector).
- MAY mark a factory dependency as optional in provider `deps` or use the `inject()` function inside a factory.
