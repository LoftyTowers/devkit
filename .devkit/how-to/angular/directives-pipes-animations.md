# Directives pipes animations

## Procedure: Build an attribute directive with an input and host event bindings

### When to use
Use when you need to add behaviour to an existing element/component by attaching an attribute and optionally responding to host events.

### Preconditions
- Angular CLI is installed and you can run `ng` commands.

### Steps
1. Run `ng generate directive <name>` to scaffold the directive files.
2. Set the directive selector to an attribute selector (for example `selector: '[appHighlight]'`).
3. Inject `ElementRef` and update the directive to read/write the host element via `nativeElement`.
4. Add host event bindings in the directive decorator using the `host` property (for example `(mouseenter)` and `(mouseleave)`).
5. Add an input using `input()` (for example `appHighlight = input('')`) to accept values from the template.
6. Apply the directive in a template using the attribute (for example `<p [appHighlight]="color">...</p>`).

### Validation
- Confirm the generated files exist and match the scaffolded names/locations produced by the CLI.
- Confirm the directive responds to the configured host events and updates the host element's style/behaviour.


## Procedure: Build a structural directive with microsyntax and typed template context

### When to use
Use when you need to conditionally or repeatedly render a template and optionally expose values into that template (for example `let data`).

### Preconditions
- You have a clear long-form template goal (`<ng-template yourDir ...>`) and a shorthand goal (`*yourDir="..."`).

### Steps
1. Run `ng generate directive <name>` to scaffold the directive.
2. Inject `TemplateRef` and `ViewContainerRef` into the directive so it can stamp out the template into a view container.
3. Add a required input (for example `yourDirFrom = input.required<SomeSource>()`) and implement the directive logic that calls `viewContainerRef.createEmbeddedView(templateRef, { $implicit: value })`.
4. Use the directive in long form first (directly on `<ng-template>`) to confirm the directive instantiates the template and the context is passed.
5. Add shorthand usage in a consumer template (for example `<p *yourDir="let data; from: source">...</p>`) and ensure your input naming supports microsyntax key mapping (prefix + PascalCase mapping).
6. Add template type-checking guards:
   - Add `static ngTemplateGuard_<input> ...` when you need input-driven narrowing.
   - Add `static ngTemplateContextGuard(...) ...` when you provide a context and want it typed in the template.

### Validation
- Confirm the shorthand form expands equivalently to the long-form `<ng-template>` shape for the directive and bindings.
- Confirm template type checking recognises the narrowed types/context when the guard(s) are present (compile-time feedback).


## Procedure: Create a pure custom pipe and use it in templates

### When to use
Use when you need a re-usable, display-focused transformation to be used inside template expressions.

### Preconditions
- You have a deterministic transformation that can be expressed as `transform(value, ...args) => result`.

### Steps
1. Run `ng generate pipe <name>` to scaffold a new pipe.
2. Set the pipe `name` in `@Pipe({ name: 'yourPipeName' })` using `camelCase` and no hyphens.
3. Implement the `PipeTransform` interface and add the `transform(...)` method.
4. Add parameters by extending the `transform` method signature (for example `transform(value: string, format: string)`), and pass those parameters in the template using colon syntax.
5. Make the pipe available to the template by importing it into the component (standalone) or declaring it in the relevant NgModule, matching how the app composes template dependencies.
6. Use the pipe in a template expression (for example `{{ value | yourPipeName }}`), and chain pipes when needed.

### Validation
- Confirm the template output reflects the transformation and parameters as expected.
- Confirm the pipe remains pure by default and only re-runs when primitives change or object references change.


## Procedure: Animate element removal with animate.leave using CSS classes

### When to use
Use when an element is removed from the DOM and you want a leave animation without legacy animation triggers.

### Preconditions
- The element you want to animate is the element that is removed (not only a descendant).

### Steps
1. Add `animate.leave="leaving"` to the element that will be removed, and remove it via a conditional template block (for example `@if (...) { ... }`).
2. Define base CSS for the element (the "rest" state) and a `.leaving` class that applies the end-state styles for the leave transition/animation.
3. If you use CSS transitions for the effect, add `@starting-style` to define a clear "from" state for the transition.
4. If you need JS-controlled timing or a third-party library, attach an event handler using `(animate.leave)="handler($event)"`.
5. If you use the `(animate.leave)` event callback approach, call `$event.animationComplete()` to notify Angular when the leave animation is finished.
6. If you need a different timeout for the auto-complete fallback, configure `MAX_ANIMATION_TIMEOUT` in providers.

### Validation
- Confirm the element remains in the DOM until the leave animation completes, then is removed.
- Confirm that your "descendant-only" placement does not silently skip the animation when a parent node is removed first.


## Procedure: Enable Router view transitions and customise them with global CSS

### When to use
Use when you want smooth, route-to-route transitions using the browser View Transitions API where supported.

### Preconditions
- Your app uses Angular Router and has a single place where the root router configuration is created.

### Steps
1. Enable view transitions in Router:
   - Standalone bootstrap: add `withViewTransitions()` to `provideRouter(routes, withViewTransitions())`.
   - NgModule bootstrap: set `{ enableViewTransitions: true }` in `RouterModule.forRoot(...)`.
2. Keep the app correct without additional animation logic, relying on progressive enhancement when the browser does not support View Transitions.
3. Define view transition pseudo-element CSS in a global stylesheet (not component styles).
4. Target the relevant pseudo-elements (for example old/new snapshots) and define the desired animation (fade, slide, etc.).

### Validation
- Confirm the app navigates normally in browsers without View Transitions support (no broken navigation).
- Confirm the CSS resides in a global stylesheet and actually affects the transition pseudo-elements in supported browsers.
