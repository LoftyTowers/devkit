# Forms and validation

## Checklist

- [ ] Verify `ValidatorFn`-based custom sync validators compile and return `ValidationErrors | null` (TypeScript build passes).
- [ ] Ensure `AsyncValidatorFn`-based custom async validators compile and return `Promise<ValidationErrors | null>` or `Observable<ValidationErrors | null>` (TypeScript build passes).
- [ ] Verify template-driven sync validator directives provide `NG_VALIDATORS` with `multi: true` and `useExisting` (ESLint custom rule passes).
- [ ] Ensure template-driven async validator directives provide `NG_ASYNC_VALIDATORS` with `multi: true`, `useExisting`, and implement `AsyncValidator` (ESLint custom rule and TypeScript build pass).
- [ ] Confirm `FormArray` mutations use `push`/`insert`/`removeAt`/`clear` and there is no direct editing of the underlying controls array (ESLint custom AST rule passes). 