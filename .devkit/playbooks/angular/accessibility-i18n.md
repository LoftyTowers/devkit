# Accessibility i18n

## Context
Use WCAG as the acceptance target for accessibility work because it defines testable success criteria and formal conformance levels (A, AA, AAA), and it is designed for conformance testing and contractual use.

Angular provides specific guidance for accessibility work in Angular applications (including ARIA binding patterns, focus management after routing, and use of Angular CDK a11y utilities).

Internationalisation in Angular is about preparing and building versions of your application for different locales, including extracting text for translation and formatting locale-sensitive data.

## Guidance
- Organise accessibility requirements as a WCAG 2.2 Level AA backlog, using the WCAG quick reference to select and track applicable success criteria for your UI and user journeys.
- Prefer native HTML elements and behaviours for controls and navigation, and only add ARIA where semantics are missing or you are implementing a custom widget pattern.
- Avoid ARIA configurations that fight native semantics; follow ARIA-in-HTML conformance requirements to prevent role/attribute conflicts and misleading semantics.
- When you must build custom widgets (menus, listboxes, tabs, toolbars), follow WAI-ARIA Authoring Practices design patterns and keyboard interaction guidance rather than inventing your own pattern.
- Consider Angular Aria directives for common widget patterns when you want a headless implementation that handles keyboard interactions, ARIA attributes, focus management, and screen reader support.
- Use Angular template binding support for ARIA attributes and roles, and prefer bindings that keep relationships up to date as template data changes (for example, structured ARIA relationships via property bindings where supported).
- Treat focus as a first-class navigation feature: decide where focus moves after each route navigation and implement it using Router `NavigationEnd` so keyboard and assistive-technology users do not rely on visual cues alone.
- Use focus containment for modal dialogs and similar UI that blocks background interaction, and ensure the user can exit the contained state via an explicit, keyboard-accessible close path.
- Use Angular CDK a11y utilities when you need framework-aligned solutions for keyboard interactions and focus: `ListKeyManager`, `FocusTrap`/`cdkTrapFocus`, `FocusMonitor`, `InteractivityChecker`, and `LiveAnnouncer` for screen-reader announcements.
- Use Angular's built-in i18n workflow (`@angular/localize`, `ng extract-i18n`, `angular.json` locale configuration, and `--localize` builds) when you can deploy one build variant per locale.
- Use Angular locale-aware pipes for dates, numbers, and currency, and let `LOCALE_ID` drive defaults; override per usage only when a specific formatting requirement demands it.
- Prefer using `ng build --localize` for localised builds because the CLI includes locale data and sets `LOCALE_ID`; only import global locale variants manually when you need locale data outside the localised build flow.

## Trade-offs
- Build-time localisation creates separate distributable "variant" applications per locale, which fits Angular's compile-time i18n flow (AOT-based), but it increases build and deployment complexity because you must deploy multiple locale outputs and handle per-locale base href / subpaths.
- Adding ARIA can improve semantics when native HTML cannot express a needed pattern, but it carries a correctness burden: ARIA does not automatically supply keyboard behaviour or prevent semantic conflicts, so misuse can reduce accessibility.

## Decision criteria
- Choose build-time Angular i18n variants when you can deploy per-locale build outputs (for example, locale subdirectories) and you want the standard compile-time translation flow described in Angular's merge and deploy guidance.
- Choose runtime `$localize` support when your product requirements demand runtime translation behaviour and you can justify `@angular/localize --use-at-runtime` as part of your architecture.

## Preferences
- PREFERENCE — JUSTIFIED: Keep translation files under `src/locale/` and reference them from `angular.json` so locale configuration and translation file paths stay explicit and reviewable.
- PREFERENCE — JUSTIFIED: Use Unicode/CLDR/BCP 47 locale identifiers (for example, `en-GB`) consistently in `angular.json` and i18n tooling configuration to avoid ambiguous locale behaviour.
