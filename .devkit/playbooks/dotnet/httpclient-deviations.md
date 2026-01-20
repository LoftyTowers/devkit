# HttpClient deviations (guidance)

## Scope

- Non-enforceable guidance for HttpClient deviations and singleton usage.

## When to use

- None.

## Guidance

### D1: Static/singleton HttpClient

- A static/singleton `HttpClient` MAY be used only with explicitly configured pooled connection lifetime.
- The configured lifetime and rationale MUST be documented.

### D3: Default handler lifetimes

- Default handler lifetimes MAY be used only when endpoint DNS is known to be static.
- The DNS assumptions and evidence MUST be recorded.

## Trade-offs and pitfalls

- None.

## Examples

- None.

## Cross-references

- None.
