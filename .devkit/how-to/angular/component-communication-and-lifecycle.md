# Component communication and lifecycle

## Procedure: Add a required input

### When to use
Use this when a component or directive cannot function without a value provided by its parent.

### Preconditions
- Ensure the component/directive is used in at least one template so build-time enforcement can validate it.

### Steps
1. Add a required signal-based input with `input.required<T>()`.  
2. Update each template usage of the component/directive to bind the required input.  
3. Run the build and fix every missing-required-input diagnostic until the build succeeds.  

### Validation
- Confirm the build fails if the required input is omitted from a template usage.  
- Confirm the build succeeds after all usages provide the required input.  

## Procedure: Declare a typed output with output()

### When to use
Use this when a child component/directive needs to notify its parent about an interaction or state transition.

### Preconditions
- Ensure the parent listens via template event binding (for example, `(valueChanged)="..."`).

### Steps
1. Import `output` from `@angular/core` and initialise a class field with `output<T>()`.  
2. Emit values by calling `.emit(value)` on the output member.  
3. Update the parent template to bind the output event and read the payload via `$event`.  
4. Rename the output if needed to follow camelCase, avoid `on` prefixes, and avoid DOM event name collisions.  

### Validation
- Confirm TypeScript rejects `.emit(...)` with the wrong payload type.  
- Confirm the parent handler receives the emitted value via `$event` at runtime.  

## Procedure: Enable two-way binding between components with model()

### When to use
Use this when a child component needs to both accept a value and propagate updates back to the parent via `[(...)]`.

### Preconditions
- Ensure the parent has a writable state value (a plain property or a writable signal) to bind.

### Steps
1. Declare the child value as a `model<T>(initialValue)` (or `model.required<T>()` when it must be provided).  
2. Update the value inside the child by calling `set(...)` or `update(...)` on the model.  
3. Bind from the parent using `[(value)]="parentState"` in the parent template.  
4. Pass a signal instance (not a signal value) when binding from a signal-based parent state.  

### Validation
- Confirm updates in the child propagate back to the parent through the `[(...)]` binding.  
- Confirm the model creates the corresponding `"Change"` output automatically for event bindings (for example, `(valueChange)="..."`).  

## Procedure: Create a shared service for sibling communication

### When to use
Use this when components are siblings (or distant in the tree) and need shared state or cross-component event dispatch.

### Preconditions
- Ensure consumers can inject a shared service instance via Angular dependency injection.

### Steps
1. Create a service and configure it with `@Injectable({ providedIn: 'root' })` to make one shared instance available application-wide.  
2. Add a state or event API to the service that represents the shared concern (state management and event dispatch are service use cases in Angular).  
3. Inject the service into each participating component and use it as the single source of truth for that shared state/event flow.  

### Validation
- Confirm both components observe the same shared state / events through the service instance.  

## Procedure: Use queries safely and enforce presence when needed

### When to use
Use this when a component must reference a child component/directive/DOM element or projected content.

### Preconditions
- Ensure the queried target exists either in the component's own template (view query) or in projected content (content query).

### Steps
1. Declare a view query with `viewChild(...)` (or a content query with `contentChild(...)`) as a class field, and treat the result as potentially `undefined`.  
2. Switch to `.required(...)` when the target must always be present and the absence should be a hard error.  
3. Read decorator-based view query results in `ngAfterViewInit` and decorator-based content query results in `ngAfterContentInit`.  
4. Set `{ static: true }` for decorator-based `@ViewChild`/`@ContentChild` only when the target is always present and must be available in `ngOnInit`.  

### Validation
- Confirm required query failures surface as errors when the target is missing.  
- Confirm decorator-based view/content queries are not read before their documented lifecycle availability.  

## Procedure: Prevent subscription leaks with takeUntilDestroyed

### When to use
Use this when component/directive code subscribes to an RxJS stream (especially for side effects).

### Preconditions
- Ensure the subscription code runs in an injection context (for example, component/directive construction) or you can inject and pass `DestroyRef`.

### Steps
1. Import `takeUntilDestroyed` from `@angular/core/rxjs-interop`.  
2. Pipe `takeUntilDestroyed()` into the observable chain before calling `.subscribe(...)`.  
3. Inject `DestroyRef` and pass it to `takeUntilDestroyed(destroyRef)` when calling `takeUntilDestroyed` outside an injection context.  

### Validation
- Confirm the subscription is automatically unsubscribed when the component/directive is destroyed.
