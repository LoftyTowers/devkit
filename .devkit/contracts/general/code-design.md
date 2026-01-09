# Code design

## Extensibility (pragmatic)

- Prefer **KISS inside the DevKit style** by default. Add seams only where change is **likely**.
- Add an abstraction when at least one is true:
  1) External dependency (HTTP, DB, queue, filesystem) - isolate behind a port/interface.
  2) Clear **variation points** now or in the near roadmap (two or more real variants).
  3) Business rule plug-in / feature flag toggles are requested by product.
- Avoid abstractions when none of the above apply (YAGNI).
- Each new interface/class must pass: "What **concrete variation** or **external boundary** requires this?"
- When adding a seam, write a **one-line note** explaining why the seam exists.
- MUST design boundaries for high cohesion and low coupling.
- SHOULD use explicit interfaces at integration boundaries and where multiple implementations are expected.
- When trade-offs exist, propose 2-3 options briefly, then pick one and implement.
- See `.devkit/contracts/general/coding-patterns.md` for pattern selection rules and tables.

## Separation of concerns

- Operational code orchestrates work; it does **not** own core domain rules.
- Keep:
  - HTTP / messaging / worker concerns in the operational layer,
  - business rules in domain/services,
  - persistence in infrastructure.
- Do not let sagas, controllers, or workers become "god objects" that do validation, business rules, and persistence in one place.

## Performance pragmatics

- MUST avoid known high-cost anti-patterns (e.g., N+1 queries, unnecessary repeated I/O).
- SHOULD measure before optimising and avoid speculative micro-optimisations.

## Immutability

- SHOULD prefer immutability for inputs and DTOs where practical.
- See `.devkit/contracts/dotnet/modern-language-features.md` for enforceable init-only, required member, and immutable surface rules.

## SOLID (pragmatic)

- S: one reason to change per unit.
- O: add behaviour via new types, not giant switches.
- L: keep contracts unsurprising.
- I: small, focused interfaces.
- D: depend on abstractions at seams; keep concrete implementations inside modules if simpler.
