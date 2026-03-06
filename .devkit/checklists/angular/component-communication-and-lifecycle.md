# Component communication and lifecycle

## Checklist

- [ ] Verify `@Input` is not used outside the approved allowlist and that inputs use `input()` or `model()` per lint rules.  
- [ ] Verify `@Output` + `EventEmitter` is not used outside the approved allowlist and that outputs use `output()` / `outputFromObservable()` per lint rules.  
- [ ] Ensure `@ViewChild`/`@ContentChild` decorators are not used outside the approved allowlist and that query functions are used per lint rules.  
- [ ] Confirm every class field initialised by `input`, `model`, `output`, or query functions is marked `readonly` and passes lint.  
- [ ] Verify any class that declares a lifecycle hook method also implements the matching lifecycle hook interface and passes lint.  
- [ ] Ensure every `.subscribe()` call in component/directive code includes `takeUntilDestroyed(...)` and passes lint.  
- [ ] Verify output names are camelCase, do not start with `on`, and pass naming lint rules.  
- [ ] Verify input aliases (`alias`) are absent unless the alias is explicitly allowlisted for backwards compatibility or DOM collision avoidance.  
- [ ] Verify output aliases (`alias` / `@Output('...')`) are absent unless the alias is explicitly allowlisted for backwards compatibility or DOM event collision avoidance.  
- [ ] Confirm output names do not collide with standard DOM events and pass lint rules that validate against a DOM event list. 
