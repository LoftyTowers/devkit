Apply the general rules:
- general/charter.md
- general/engineering-style.md
- general/coding-patterns.md
- general/design-recipes.md
- general/checklists.md

When designing:
1) Prefer the simplest code first (KISS). Avoid speculative seams (YAGNI).
2) Consult the decision table in coding-patterns.md. Only add a pattern if a trigger applies.
3) If a pattern is chosen, cite the trigger and add a one-line reason in code comments.

Output for any task:
- summary + trade-offs,
- minimal patch,
- tests,
- notes (logging/error/docs/perf).

### DI policy (global)
- For ANY class you generate, use **constructor injection** for collaborators.
- Do not construct collaborators with `new` inside methods.
- Use static methods only for pure, stateless helpers.
