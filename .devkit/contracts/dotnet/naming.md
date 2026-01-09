# Naming

## Enforceable rules

- MUST use a consistent naming convention for the same identifier category within the same scope/codebase.
- MUST NOT mix casing styles for the same identifier category within the same scope.

### Casing and categories

- Namespaces: **PascalCase**.
- Classes, methods, properties, and events: **PascalCase**.
- Public/protected constants and static readonly fields: **PascalCase**.
- Parameters and local variables: **camelCase**.
- Interfaces: **IPascalCase**.
- Enums and enum members: **PascalCase**.

### Interfaces

- Interface names SHOULD align with the primary implementation name except for the leading `I`.

### Enums

- Enum type names MUST be singular.
- Enum type names MUST be plural when the enum is intended for `[Flags]` combinations.

### Type suffixes

- Attribute types MUST use the `Attribute` suffix.
- Exception types MUST use the `Exception` suffix.
- Event args types MUST use the `EventArgs` suffix.
- Custom event-handler delegate types MUST use the `EventHandler` suffix.

### Events

- Event names MUST be PascalCase and describe the occurrence.
- Event names MUST use present tense for pre-action events (e.g., `Closing`) and past tense for post-action events (e.g., `Closed`).
- MUST NOT use Before/After prefixes for event names when tense-based naming conveys timing.

### Async naming

- Public async methods returning `Task`/`Task<T>` (or awaitables used by convention) MUST end with the `Async` suffix.
- Allowed exceptions are documented in `.devkit/playbooks/dotnet/style-preferences.md` (Async suffix omissions).

### Prohibitions and separators

- MUST NOT use Hungarian notation or encode type/scope metadata in names (beyond established .NET patterns explicitly listed in this file).
- MUST NOT require keyword escaping in identifiers (e.g., `@class`) when an unambiguous alternative exists.
- Identifiers MUST NOT include non-alphanumeric separators (e.g., underscores) in production code.
- Test naming may use underscores as defined in `.devkit/contracts/dotnet/testing-nunit.md`.

### Abbreviations

- MAY use common, conventional abbreviations (e.g., `Dto`, `Api`, `Id`) when they improve clarity and are widely conventional in this codebase.

### Private fields

- Private field naming MUST follow a single chosen convention within a project. Default is **_camelCase**, but other conventions are allowed if documented and applied consistently.
