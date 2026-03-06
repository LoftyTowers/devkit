# Forms and validation

## Context
Use this playbook to choose an Angular form approach, structure form models, implement validation rules, and present validation feedback consistently.
Apply it to both reactive and template-driven forms, including custom synchronous and asynchronous validation and dynamic form structures.

## Guidance
- Prefer reactive forms when you need explicit access to the form object model and you expect the form model to be reused, scaled, or tested heavily.
- Use template-driven forms for small, simple forms where the form logic can live in the template and you accept directive-based, template-driven model creation.
- Keep reactive-form validation rules on the form model in the component class (validator functions on controls/groups), rather than relying on template attributes as the primary source of truth.
- Use `FormBuilder` to reduce boilerplate when creating multiple controls/groups/arrays, and mirror logical UI sections with nested `FormGroup`s.
- Use `setValue()` when you want strict shape validation of the value you apply, and use `patchValue()` when you want partial updates and can accept missing keys.
- Use built-in validators from `Validators` for common rules (for example `required`, `minLength`) before writing a custom validator.
- Design custom synchronous validators as small `ValidatorFn` factories that return `ValidationErrors | null` with stable error keys that your UI can check via `hasError(...)`.
- Design async validators to return `Promise`/`Observable` results and avoid backend calls for every keystroke by deciding and setting `updateOn` (`blur` or `submit`) where the validator is applied.
- Attach cross-field validators to the nearest common ancestor `FormGroup` so the validator can read sibling controls via `get(...)` and set a group-level error key.
- Gate error messages on user interaction state (for example `dirty` or `touched`) and use programmatic state setters when needed (for example reveal all errors on submit with `markAllAsTouched()`).
- Use `FormArray` for open-ended, index-addressed control lists and mutate it via `push`/`insert`/`removeAt`/`clear` so Angular can track the hierarchy correctly.
- Use typed reactive forms to make form access type-safe, and treat nullability as a design choice: controls reset to `null` by default, and `nonNullable: true` (or `FormBuilder.nonNullable`) changes reset behaviour to the initial value.
- When reading group values, account for disabled controls: `.value` can omit disabled controls and typed forms model this as `Partial<...>`, while `getRawValue()` reads including disabled controls.

## Trade-offs
- Reactive forms increase component-class code but provide explicit models, synchronous data flow, and improved scalability/testing; template-driven forms reduce setup but rely on directives and asynchronous data flow and scale/test less well.
- `patchValue()` is tolerant but can hide nesting/shape mistakes; `setValue()` is strict and helps catch mismatches earlier.
- `updateOn: 'blur' | 'submit'` reduces async validator load and backend traffic but delays validity updates and error feedback compared to the default `'change'`.
- `nonNullable: true` removes `null` from control value types and changes runtime reset behaviour (reset returns to the initial value), which can clash with flows that rely on `reset()` producing `null`.

## Decision criteria
- Choose reactive forms when the form model needs to be the source of truth in the component class, when you want validator functions on the model, or when you need robust scaling/testing.
- Choose template-driven forms when the form is small and you want directives in the template to create/manipulate the underlying model with minimal component-class form code.
- Choose `FormGroup` when your controls are keyed and known ahead of time; choose `FormArray` when you need an open-ended list of unnamed/indexed controls that can be added/removed at runtime.
- Choose a group-level validator when validation depends on multiple sibling controls (cross-field validation).
- Choose `updateOn: 'blur'` or `'submit'` when async validators call HTTP endpoints and you want to avoid requests after every value change.
- Choose nullable controls when `reset()` should clear values to `null`; choose `nonNullable` controls when `reset()` should restore initial defaults.

## Preferences
- PREFERENCE — JUSTIFIED: Prefer reactive forms for new feature work unless the form is trivially small and the entire form logic stays in a single template.
- PREFERENCE — JUSTIFIED: Prefer typed reactive forms and use `nonNullable` controls for fields that are required and always have a meaningful default, so `reset()` maintains usable defaults.
- PREFERENCE — JUSTIFIED: Prefer setting `updateOn: 'blur'` for controls with async validators that perform HTTP validation, to reduce requests triggered by normal typing.