
# Architecture decisions

- Organise project subdirectories by feature area (e.g. `show-times/`, `reserve-tickets/`) rather than by code type. As the number of files in a directory grows, split further into additional sub-directories.
- The Container–Presenter pattern (also called Smart/Dumb) separates concerns: container components manage state and data fetching; presenter components receive data via inputs and emit events via outputs. This improves testability and reusability of presenter components.
- PREFERENCE — JUSTIFIED: Presenter (dumb) components should use `ChangeDetectionStrategy.OnPush` for improved performance and predictability. OnPush restricts change detection to when inputs change or events fire, which aligns naturally with the presenter model.
  - NO PRIMARY SUPPORT — SECONDARY ONLY (angular.dev does not mandate OnPush for presentational components; this is a widely adopted community pattern documented by Angular Architects and recognised experts).
- When a component's template logic becomes complex, refactor it into the TypeScript class (typically using a `computed` signal). There is no hard rule defining "complex" — use judgement.
- Keep lifecycle hooks simple: extract complex logic into well-named methods and call those methods from the hook. Lifecycle hook names describe *when* they run, not *what* the code does.
- Group Angular-specific properties (injected dependencies, inputs, outputs, queries) near the top of the class, before methods.
- Event handlers should be named for the action they perform (e.g. `saveUserData()`), not for the triggering event (e.g. `handleClick()`).
- The application shell should be kept thin: it primarily contains routing configuration, bootstrap logic, and layout composition. All business logic, UI components, and data access should reside in domain libraries.
- Start with broader library boundaries and refine over time. Signs that boundaries need adjustment include: frequent cross-library changes, circular dependencies, unclear ownership, complex dependency chains, and excessive shared code.
- When deciding whether to create a new library, consider how often various parts change together. Closely-coupled code that always changes together may belong in a single library.
- For attribute selectors on components: consider using them when building on native HTML elements (e.g. `button[yt-upload]`) to preserve access to standard element APIs and ARIA attributes.

