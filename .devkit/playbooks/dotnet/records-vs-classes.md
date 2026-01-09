# Records vs classes (C#)

Not enforceable: playbook guidance only.

## Use records when

- The type is a data carrier with value-based equality semantics.
- With-expressions are useful for non-destructive updates.
- Immutability or init-only semantics are desired by default.

## Use classes when

- The type has identity, mutable lifecycle, or polymorphic behavior.
- Reference equality or stable identity is part of the domain model.
- Subclassing is expected to model behavior variation.

## Examples

- Record: `public record Money(decimal Amount, string Currency);`
- Class: `public class OrderAggregate { /* mutable state, identity */ }`
