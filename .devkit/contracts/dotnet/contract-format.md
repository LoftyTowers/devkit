# Contract format

## Scope

### Definitions

### Operational handlers

Operational handlers are **code entrypoints** that react to external input and **orchestrate work**, including:

- HTTP controllers / endpoints
- NServiceBus handlers and sagas
- Message consumers
- Background workers / scheduled jobs
- CLI commands that perform operations

Operational handlers **do not** include:
- Domain entities or value objects
- Pure domain or application services
- Repositories or infrastructure adapters
- Configuration, options, or mapping types

## Rules

- None.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

- None.
