# Accessibility i18n

## Procedure: Add Angular localisation support

### When to use
Use this when you will mark templates or code for translation and build localised variants.

### Preconditions
- Have an Angular CLI-managed workspace with a buildable application.

### Steps
1. Run `ng add @angular/localize`.
2. Confirm your TypeScript configuration includes `types: ["@angular/localize"]`.
3. Confirm `main.ts` contains `/// <reference types="@angular/localize" />`.
4. Run `ng build --localize` to confirm the localised build path works.

### Validation
- Observe a successful `ng build --localize` exit code and a generated `dist/` output for the build.


## Procedure: Mark templates and code for translation

### When to use
Use this before message extraction, when you need text and attributes translated.

### Preconditions
- Have `@angular/localize` installed and configured.

### Steps
1. Add the `i18n` attribute to each element that contains fixed text you want translated.
2. Add `i18n-<attributeName>` for attribute text that must be translated (for example, `i18n-title`).
3. Use the `$localize` tagged message string to mark translatable strings in component code.

### Validation
- Run `ng extract-i18n` and confirm the produced messages file contains entries for the text you marked.


## Procedure: Extract source messages to a translation file

### When to use
Use this whenever source text changes, to refresh the source message file used by translators.

### Preconditions
- Have at least one `i18n` / `i18n-*` marker or `$localize` message in the codebase.

### Steps
1. Run `ng extract-i18n`.
2. Run `ng extract-i18n --output-path src/locale` if you keep locale files under `src/locale/`.
3. Run `ng extract-i18n --format=xlf` or `ng extract-i18n --format=xlf2` when you need a specific XLIFF version (or another supported format).
4. Run `ng extract-i18n --out-file messages.xlf` when you need a specific output name.

### Validation
- Confirm a source messages file is created at the expected path (by default `messages.xlf` at the project root when no output options are used).


## Procedure: Configure locales and build localised variants

### When to use
Use this when you need one build output per locale and want Angular to merge translations at build time.

### Preconditions
- Have translation files for each target locale.

### Steps
1. Open `angular.json` and set `projects.<project>.i18n.sourceLocale` to your source locale.
2. Add each target locale under `projects.<project>.i18n.locales` and point `translation` to that locale's translation file.
3. Add a `subPath` per locale when you deploy locales under subdirectories and want the CLI to adjust base href accordingly.
4. Run `ng build --localize` to generate build outputs for configured locales.

### Validation
- Confirm the build produces per-locale outputs and the CLI-adjusted base href behaviour matches your `subPath` configuration.


## Procedure: Import locale data for non-default formatting

### When to use
Use this when you need locale data for languages other than the default `en-US` and you are not relying solely on the `--localize` build path to include locale data.

### Preconditions
- Know the locale you must support (for example, `fr` or `en-GB`).

### Steps
1. Import the global locale variant in `main.ts` before bootstrapping, for example `import '@angular/common/locales/global/fr';`.
2. Use locale-aware built-in pipes (`DatePipe`, `CurrencyPipe`, `DecimalPipe`, `PercentPipe`) so formatting follows `LOCALE_ID` rules (or pass an explicit locale parameter when required).

### Validation
- Confirm a unit test that formats a date or currency returns output matching the intended locale rules (by setting `LOCALE_ID` in the test injector or passing the pipe's `locale` parameter).


## Procedure: Implement focus management after route navigation

### When to use
Use this in routed applications to keep keyboard and assistive-technology focus aligned with newly navigated content.

### Preconditions
- Use Angular Router.

### Steps
1. Add a focus target in the main routed content (for example, a main content header with an ID) and make it programmatically focusable.
2. Subscribe to Router events and detect `NavigationEnd`.
3. Focus the target element after navigation completes.

### Validation
- Confirm an E2E test navigates between routes and asserts focus lands on the intended main-content target and does not revert to the `body` element.


## Procedure: Trap focus in modal dialogs with Angular CDK

### When to use
Use this for modal dialogs where focus must remain within the dialog while it is open.

### Preconditions
- Have Angular CDK a11y available (directly or via Angular Material).

### Steps
1. Import the CDK a11y module (`A11yModule`) into the Angular compilation context that renders the dialog.
2. Add the `cdkTrapFocus` directive to the modal dialog container element.
3. Ensure the modal provides a keyboard-accessible close action so the user can exit the constrained focus state.

### Validation
- Confirm an E2E test opens the modal and asserts Tab navigation stays inside the modal container until the modal is closed.


## Procedure: Announce dynamic status messages to screen readers

### When to use
Use this when UI state changes without a full navigation (for example, async load results, validation summaries, save confirmations).

### Preconditions
- Have Angular CDK a11y available and `A11yModule` imported.

### Steps
1. Inject `LiveAnnouncer` from the CDK a11y package in the component or service that owns the status change.
2. Call `liveAnnouncer.announce(...)` at the moment you render the status update.
3. Add a unit test that asserts `announce(...)` is called with the expected message when the status transition occurs.

### Validation
- Confirm unit tests pass and the `announce(...)` call is executed on the status-change code path.
