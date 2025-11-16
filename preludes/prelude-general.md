Before generating or editing code, read and follow:

- general/engineering-style.md
- general/coding-patterns.md
- general/house-style-contract.md
- general/charter.md
- general/design-recipes.md
- general/checklists.md

### When designing:

1) Prefer the simplest DevKit-style solution first.

   “Simple” does NOT mean generic tutorial code.

   “Simple” means:
   - follow the DevKit structure (Result/ErrorCode, validation, DI, logging scopes),
   - keep functions small and readable,
   - avoid unnecessary abstractions UNTIL a DevKit trigger applies.

   If the DevKit has an example in a similar area, copy its structure and adapt it.
   Never fall back to global/default coding patterns when the DevKit offers a precedent.

2) Only add patterns (factory/strategy/decorator/etc.) when a trigger in
   `general/coding-patterns.md` applies. Avoid speculative seams (YAGNI).

3) If you introduce a pattern:
   - cite the trigger in a short comment,
   - copy the closest DevKit example and adapt it.


### DI policy (global)
- For ANY class you generate, use **constructor injection** for collaborators.
- Do not construct collaborators with `new` inside methods.
- Use static methods only for pure, stateless helpers.

After generating new code, you must mentally apply the "New Feature Checklist" in `general/checklists.md`.
If any item would fail, you must adjust the code so that all items pass.
