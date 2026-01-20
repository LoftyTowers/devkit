# Records vs classes (C#)

## Scope

Not enforceable: playbook guidance only.

## When to use

- None.

## Guidance

### Use records when

- The type is a data carrier with value-based equality semantics.
- With-expressions are useful for non-destructive updates.
- Immutability or init-only semantics are desired by default.

### Use classes when

- The type has identity, mutable lifecycle, or polymorphic behavior.
- Reference equality or stable identity is part of the domain model.
- Subclassing is expected to model behavior variation.

## Trade-offs and pitfalls

- None.

## Examples

- Record: `public record Money(decimal Amount, string Currency);`
- Class: `public class OrderAggregate { /* mutable state, identity */ }`

## Cross-references

- None.
