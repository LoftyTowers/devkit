# Modern language features policy (C#)

## Nullable reference types (R1-R4)

- MUST enable nullable-aware context for new C# projects.
- MUST use nullable annotations to express nullability for reference-type parameters, return values, and members within nullable-aware context.
- When migrating existing code, MUST enable nullable context incrementally (per project or file) and address warnings within the migrated scope.
- Nullable suppression (`!`, `#nullable disable`) MUST be narrowly scoped and MUST NOT be applied solution-wide or broadly at project level.

## Records vs classes (R5-R6)

- MUST follow guidance in `.devkit/playbooks/dotnet/records-vs-classes.md` when choosing between records and classes.

## Pattern matching (R7)

- MUST use pattern matching constructs when they remove redundant casts or branching and improve clarity.
- MUST follow guidance in `.devkit/playbooks/dotnet/pattern-matching-vs-polymorphism.md` when choosing between runtime type checks and polymorphic design.

## Required members and initialization (R9-R10)

- Members essential to a valid initial state MUST be initialized on all creation paths (constructors or required members).
- If required members are fully initialized by a constructor, that constructor MUST be marked with `SetsRequiredMembers`.

## Init-only and immutability surface (R11-R12)

- Properties not intended to change after construction MUST be init-only or otherwise immutable.
- If a type is intended to be immutable, its public surface MUST NOT permit mutation after initialization.
