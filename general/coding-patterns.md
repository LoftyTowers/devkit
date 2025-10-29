# Coding Patterns (language-agnostic)

## When to add a seam (decision table)
| Situation                         | Use                     | Why                                      |
|-----------------------------------|-------------------------|------------------------------------------|
| External I/O (HTTP/DB/Queue/FS)   | **Port + Adapter**      | Testable boundary; swap provider         |
| >= 2 real variants now/soon       | **Strategy**            | Replace big if/else with swappable code  |
| Construction varies by env/config | **Factory**             | Centralise creation; hide wiring         |
| Cross-cut around behaviour        | **Decorator**           | Add logging/caching/metrics without touching core |
| Data-driven steps                 | **Chain/Policy/Template** | Stable flow with pluggable steps       |

> Default to no pattern. Cite the trigger when you do use one.

## Strategy
Use when behaviour varies by type/rule/flag. Avoid if only one variant and no near-term need.
See: examples/dotnet/patterns/strategy/PricingStrategies.cs

## Factory
Use when creation depends on config/env and is likely to change.
See: examples/dotnet/patterns/factory/PaymentGatewayFactory.cs

## Decorator
Use for cross-cuts: logging, caching, metrics, auth.
See: examples/dotnet/patterns/decorator/CachingCatalog.cs

## Ports & Adapters
Wrap external I/O; keep domain ignorant of transport/provider.

## DI vs Static vs Factory
- **Default**: constructor DI for collaborators (gateways, repos, clocks, loggers, validators).
- **Static**: only for **pure functions** (no IO, no state). Prefer modules with static methods or extension methods.
- **Factory**: use when selection varies per call (strategy keyed by type/tenant/feature flag).

