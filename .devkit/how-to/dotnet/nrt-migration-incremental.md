# Incremental NRT migration (C#)

## Goal

Enable nullable reference types incrementally while keeping warnings contained to the migrated scope.

## Steps

1) Choose the migration unit (project or file) and keep the scope small.
2) Enable nullable context for that unit:
   - Project: set `<Nullable>enable</Nullable>` in the target `.csproj`, or
   - File: add `#nullable enable` at the top of the file.
3) Build the target unit and collect nullable warnings for only the migrated scope.
4) Address warnings by:
   - Adding `?` annotations where null is valid.
   - Removing `?` annotations where null is not valid.
   - Introducing explicit null checks where needed.
5) Use suppression (`!` or `#nullable disable`) only for narrow, justified cases.
6) Repeat for the next unit, keeping migrations isolated and reviewable.

## Safety checks

- Do not enable nullable for the entire solution unless the warnings are addressed.
- Ensure the migrated scope compiles with no new nullable warnings.
- Review public APIs to confirm nullability intent is accurate.
