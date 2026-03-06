# Forms and validation

## Procedure: Build a typed reactive form with `FormBuilder.nonNullable`

### When to use
Create a multi-field form where you want typed access to control values and predictable reset behaviour.

### Preconditions
- A component that can import `ReactiveFormsModule`.

### Steps
1. Import `ReactiveFormsModule` and add it to the component `imports` so `[formControl]`, `[formGroup]`, and `formControlName` directives are available.
2. Inject `FormBuilder` (or use `FormBuilder.nonNullable`) in the component.
3. Create a form model using `fb.nonNullable.group(...)` so controls reset to their initial values rather than `null`.
4. Add built-in validator functions from `Validators` directly on controls (for example `Validators.required`).
5. Bind the model to the template using `[formGroup]` and `formControlName` (or `[formControl]` for single controls).
6. Read enabled-control aggregates with `.value` and read including disabled controls with `.getRawValue()` when needed.

### Validation
- Run a TypeScript build and confirm template + component compilation succeeds with typed form access.
- Log or inspect the submitted model using either `.value` (enabled controls) or `.getRawValue()` (including disabled controls) and confirm it matches expectations.


## Procedure: Add a custom synchronous validator to a reactive form control

### When to use
Add validation rules that built-in validators do not cover, while keeping validation logic reusable and testable.

### Preconditions
- A reactive form control created with `FormControl` or `FormBuilder`.

### Steps
1. Create a validator factory function that returns a `ValidatorFn`.
2. Return `null` when valid and a `ValidationErrors` object when invalid, using a stable error key.
3. Attach the validator as a synchronous validator on the control (second argument to `FormControl`, or the second item in a `FormBuilder` control config array).
4. Render the error message only when the control is invalid and the user has interacted (for example `dirty` or `touched`), and check the error via `hasError('yourKey')`.

### Validation
- Set an invalid value and confirm `control.hasError('<yourKey>')` is `true`, and `control.invalid` is `true`.
- Set a valid value and confirm `control.errors` is `null` and `control.valid` is `true`.


## Procedure: Add an async validator with `updateOn` to avoid per-keystroke HTTP validation

### When to use
Validate a value against an API (for example uniqueness checks) without sending a request for every value change.

### Preconditions
- An async validation function or service that can return results as an `Observable` or `Promise`.

### Steps
1. Implement async validation logic that returns `Observable<ValidationErrors | null>` (or `Promise<ValidationErrors | null>`) and conforms to Angular's async validator shape.
2. Configure the validated control with `asyncValidators` and set `updateOn: 'blur'` (or `'submit'`) in the control options.
3. Combine sync and async validators by attaching sync validators as sync validators and async validators separately; rely on Angular's behaviour that async validators run only after sync validators pass.
4. Handle upstream errors in the async validator stream (for example with `catchError`) and decide whether to treat transport failures as valid or invalid based on product needs.

### Validation
- Trigger validation (blur the control or submit the form, depending on `updateOn`) and confirm the control transitions through `PENDING` while async validation runs.
- Run CI tests and confirm there are no NG01101 errors for wrong async validator return types.


## Procedure: Add cross-field validation on a `FormGroup`

### When to use
Validate rules that depend on the relationship between multiple sibling fields (for example comparing two values).

### Preconditions
- A `FormGroup` with the sibling controls you need to compare.

### Steps
1. Create a `ValidatorFn` that reads sibling controls from the group using `group.get('<name>')` and returns an error key (or `null`).
2. Attach the validator to the common ancestor `FormGroup` using the group options object `{ validators: yourValidator }` when constructing the group.
3. Display the group-level error using `formGroup.hasError('<errorKey>')` and gate it on user interaction (for example `formGroup.touched || formGroup.dirty`).

### Validation
- Set values that violate the rule and confirm `formGroup.hasError('<errorKey>')` becomes `true`.
- Set values that satisfy the rule and confirm `formGroup.hasError('<errorKey>')` becomes `false`.


## Procedure: Build a dynamic form section with `FormArray`

### When to use
Model a dynamic list of repeated inputs (add/remove rows) where the number of items is not known upfront.

### Preconditions
- A reactive form that can host an array of controls (either a top-level `FormArray` or a `FormArray` inside a `FormGroup`).

### Steps
1. Define a `FormArray` in the form model and initialise it with zero or more controls.
2. Bind the array in the template using `formArrayName` (or `[formArray]` for top-level arrays) and iterate over its controls by index.
3. Add items by calling `formArray.push(...)` (or `insert(...)` for positional inserts).
4. Remove items by calling `formArray.removeAt(index)` (or clear all items with `clear()`).
5. Avoid direct mutation of the underlying controls array to prevent broken change detection and unexpected behaviour.

### Validation
- Add and remove items and confirm `formArray.length` changes as expected and the form validity recalculates from child controls.
- Run CI and confirm the codebase contains no direct mutation of the `FormArray` controls array (lint/grep gate passes).