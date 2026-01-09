# Pattern matching vs polymorphism (C#)

Not enforceable: playbook guidance only.

## Prefer pattern matching when

- You are refining a value with simple type/property checks.
- Pattern matching removes redundant casts and nested if/else.
- The decision logic is local and not a core polymorphic behavior.

## Prefer polymorphism when

- Behavior varies by type and is central to the domain model.
- New variants are expected and should be open for extension.
- Runtime type checks would spread across multiple call sites.

## Runtime type checks are a smell when

- They duplicate existing virtual/override behavior.
- They encode business rules that belong on the type itself.

## Runtime type checks are acceptable when

- You are bridging to external APIs or legacy models.
- You are handling DTOs or discriminated-union-like inputs.

## Examples

- Pattern matching: `return input switch { Foo f => f.Value, Bar b => b.Value, _ => default };`
- Polymorphism: `shape.Area()` instead of `switch (shape)`.
