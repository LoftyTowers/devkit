# Testing expectations

## Scope

- None.

## Rules

### General testing rules

- MUST update or add unit tests for all behavioural changes.
- SHOULD add integration tests when changes cross process boundaries (HTTP, persistence, external integrations).
- MUST run relevant tests when changing behaviour, dependencies, or build/run configuration.

### Operational handler testing expectations

For any new operational handler (controller, saga, consumer, worker):

- MUST cover the happy path.
- MUST cover at least one validation failure.
- MUST cover at least one unexpected error path from a collaborator.
- SHOULD cover cancellation where cancellation is supported.
- MUST assert behaviour (outcome/events/status), not internal implementation details.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
