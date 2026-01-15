# Required members and SetsRequiredMembers (C#)

## Goal

Ensure required members are initialized on all creation paths and recognized by the compiler.

## Steps

1) Identify members essential to a valid initial state.
2) Mark those members with `required` and use `init` where mutation is not intended.
3) Provide constructors that fully initialize required members.
4) If a constructor sets all required members, add `[SetsRequiredMembers]` to that constructor.
5) For object initializers, ensure every required member is set in each creation path.
6) Keep validation consistent with required member expectations.

## Common patterns

- Immutable DTO: `public required string Name { get; init; }`
- Constructor path: `[SetsRequiredMembers] public Foo(string name) { Name = name; }`

## Pitfalls

- Missing `SetsRequiredMembers` when a constructor covers all required members.
- Mixing mutable setters with required members when immutability is intended.
- Leaving required members unset in factory methods or test builders.
