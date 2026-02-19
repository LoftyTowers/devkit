# Forms and validation

## Scope
This contract governs Angular application code that creates forms and validators using `@angular/forms`.
It covers validator signatures, validator directive registration for template-driven forms, and safe mutation of dynamic control collections.
It applies to production code in applications and shared libraries.

## Rules
- Custom synchronous validator functions MUST conform to `ValidatorFn` and return `ValidationErrors | null`.
  - Verification mechanism: TypeScript compiler / type check (declare exported validators as `ValidatorFn`); CI build.
- Custom async validator functions MUST conform to `AsyncValidatorFn` and return `Promise<ValidationErrors | null>` or `Observable<ValidationErrors | null>`.
  - Verification mechanism: TypeScript compiler / type check (declare exported validators as `AsyncValidatorFn`); CI build.
- Template-driven synchronous validator directives MUST register themselves using `NG_VALIDATORS` with `multi: true`.
  - Verification mechanism: ESLint custom rule over `@Directive({ providers: [...] })` metadata; CI lint.
- Template-driven async validator directives MUST register themselves using `NG_ASYNC_VALIDATORS` with `multi: true` and implement `AsyncValidator`.
  - Verification mechanism: ESLint custom rule over `@Directive({ providers: [...] })` metadata; TypeScript compiler / type check (`implements AsyncValidator`); CI lint/build.
- `FormArray` instances MUST be mutated using `push`, `insert`, `removeAt`, or `clear`.
  - Verification mechanism: ESLint custom AST rule detecting direct mutation of `formArray.controls` or reassignment of `.controls`; CI lint.

## Prohibited patterns
- Custom validator directives MUST NOT be provided with `useClass` when registering `NG_VALIDATORS`/`NG_ASYNC_VALIDATORS`.
  - Verification mechanism: ESLint custom rule over directive `providers` metadata; CI lint.
- `FormArray` instances MUST NOT be modified by directly editing the underlying controls array used to instantiate the `FormArray`.
  - Verification mechanism: ESLint custom AST rule detecting direct mutation of `formArray.controls` or reassignment of `.controls`; CI lint.

## Allowed deviations
(none)