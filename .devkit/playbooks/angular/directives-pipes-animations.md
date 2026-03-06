# Directives pipes animations

## Context
Directives extend the behaviour of DOM elements and Angular components: attribute directives change appearance/behaviour, while structural directives change layout by adding/removing rendered content.

Pipes transform values for display inside template expressions. Angular treats pipes as pure by default, so their execution depends on input value/reference changes.

For animations, Angular's current direction is native CSS plus `animate.enter` / `animate.leave`, and route-level transitions via the browser's View Transitions API (with Router integration as a progressive enhancement and currently developer preview).

## Guidance

### Attribute directives
- Prefer an attribute directive when you need behaviour that attaches to an existing element/component without changing its template structure (for example, highlight, tooltip, interaction handlers).
- Prefer `host` bindings for host events so the directive's interactions with the host element are visible at the decorator level.
- Prefer a single, well-named input for the primary behaviour (for example, a colour or behaviour mode), and bind it using the directive selector in templates.
- Prefer the `input()` API for directive inputs when you want a clear, function-based directive API and straightforward binding behaviour.

### Structural directives
- Prefer a structural directive when you need to stamp out a template conditionally or repeatedly and optionally provide a template context.
- Prefer supporting the shorthand (`*yourDir="..."`) usage pattern for consumers, while keeping a correct long-form mental model (`<ng-template yourDir ...>`) for design and debugging.
- Prefer inputs that follow the microsyntax mapping rules (input names prefixed by the directive selector) so the shorthand syntax expands predictably.
- Prefer providing a typed template context using `$implicit` when you want `let x` ergonomics in templates.
- Prefer adding template guards (`ngTemplateGuard_<input>` and/or `ngTemplateContextGuard`) when your directive narrows types or provides a context, so template type checking catches mistakes at build time.

### Pure vs impure pipes
- Prefer pure pipes (the default) and treat in-place mutation of objects/arrays as "not observable" to the pipe unless you replace the reference.
- Avoid impure pipes in templates because they can create a performance trap (they run much more often than pure pipes); redesign around reference replacement or move the transformation out of the template.

### Custom pipes for data transformation
- Prefer using custom pipes for deterministic, display-focused transformations that are easy to test and re-use across templates.
- Prefer implementing `PipeTransform` and keeping `transform(...)` side-effect free, so the pipe behaves like a function and remains safe to call from templates.
- Prefer `camelCase` pipe names without hyphens, and keep the class name as PascalCase with `Pipe` suffix for discovery and consistency.

### Animation triggers and transitions
- Prefer `animate.enter` / `animate.leave` with CSS classes, transitions, or keyframe animations for new UI animations; treat them as compiler-supported template attributes rather than directive APIs.
- Prefer putting the `animate.leave` attribute on the element that is actually removed; do not rely on a child element to animate if its parent is removed first.
- Prefer CSS transitions plus `@starting-style` when you need a clear "from" state for a transition-driven enter/leave effect.
- Avoid legacy `@angular/animations` triggers/transitions for new work because they are deprecated and Angular recommends native CSS with `animate.enter` / `animate.leave` for new code.
- Prefer reusable CSS animations (`@keyframes` in shared CSS) when you need the same motion pattern across multiple components.

### Route animations
- Prefer Router view transitions for route-to-route motion so navigation lifecycle and rendering are coordinated with the browser's View Transitions API.
- Treat Router view transitions as progressive enhancement: the app must still behave correctly when the browser does not support View Transitions.

### View transition API integration
- Prefer global CSS for view transition pseudo-elements because Angular's component style scoping prevents these selectors from applying when placed in component styles.
- Prefer designing view transitions as "visual enhancement only"; do not couple correctness to the animation, because the underlying state change must still occur even if the transition cannot run.

## Trade-offs
- Pure pipes give better performance characteristics, but they only re-run on primitive changes or object reference changes, so they will not react to in-place mutations unless you replace the reference.
- Impure pipes can observe changes within arrays/objects, but they carry a significant performance risk and require careful use.
- `animate.enter` / `animate.leave` are element-level primitives (enter/leave the DOM), while Router view transitions are navigation-level primitives (animate between route states) and depend on browser support and a developer-preview Router integration.
- Migrating away from `@angular/animations` can reduce JS bundle size and relies on native CSS animations (often with better performance characteristics), but it requires refactoring component animation definitions into CSS and template-driven triggers.

## Decision criteria
- Choose an attribute directive when the behaviour is tied to a host element (styles, event reactions, host-side effects); choose a pipe when the behaviour is a value transformation for display in a template expression.
- Choose a structural directive when you need to control template instantiation and/or provide a template context; use the shorthand microsyntax when you want consumer ergonomics.
- Choose `animate.leave` when you need a reliable leave animation that coordinates DOM removal; choose plain CSS class toggling when the element remains in the DOM and you only need state transitions.
- Choose Router view transitions when you want route-level transitions that integrate with navigation; choose element-level view transitions (`document.startViewTransition`) only when you are intentionally animating a same-document DOM state update outside routing.

## Preferences
- PREFERENCE — JUSTIFIED: Centralise all view transition pseudo-element CSS in a single global stylesheet (for example `src/styles/view-transitions.css`) and keep component styles free of `::view-transition-*` selectors.
- PREFERENCE — JUSTIFIED: Prefer pure pipes plus reference replacement (immutable updates) over impure pipes to avoid template-level performance traps.
- PREFERENCE — JUSTIFIED: Prefer `animate.enter` / `animate.leave` plus CSS over new legacy animation trigger authoring, and treat legacy triggers as migration-only.
