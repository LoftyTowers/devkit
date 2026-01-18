# Coding patterns

## Scope

- Applicability of common coding patterns across languages.

## Rules

### Coding Patterns (language-agnostic)

| Situation | Use | Rationale | Example trigger |
|---|---|---|---|
| Refactor big if/else with data-driven steps | **Template/Policy/Chain** | Stable flow with varying steps | Risk checks, approval chains |

### When to add a seam

| Trigger | Reach for |
|---|---|
| Crossing an IO boundary (HTTP, DB, queue, filesystem) | **Port + Adapter** |
| Two or more real variants needed now or soon | **Strategy** or **Factory** |
| Optional concern toggled by feature flag/plugin | **Decorator** |
| Integration owned by another team/vendor | **Port + Adapter** |

Always cite the trigger in your PR/commit when you introduce a seam; otherwise prefer the simplest DevKit-style implementation.

### Strategy

Use when behaviour varies by type/rule/flag. Avoid if only one variant and no near-term need.

### Factory

Use when creation depends on config/env and is likely to change.

### Decorator

Use for cross-cuts: logging, caching, metrics, auth.

### Ports & Adapters

Wrap external I/O; keep domain ignorant of transport/provider.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
