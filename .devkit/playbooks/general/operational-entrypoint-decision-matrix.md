# Operational Entry Point Decision Matrix (Minimalism Bias)

Scope:
Applies to any operational entry point, including:
- HTTP endpoints (controllers/minimal APIs)
- Message consumers (service bus / queue handlers)
- Background jobs / scheduled tasks
- Hosted services
- CLI commands

Goal:
Default to minimal implementations.
Escalate to additional layers (service/handler/DTO/validator) only when there is a clear trigger.

---

## Default rule

Start minimal:
- Keep trivial orchestration close to the entry point.
- Avoid creating new DTOs, validators, interfaces, or services unless a trigger applies.
- Prefer the simplest change that preserves behaviour and fits existing project patterns.

---

## Escalation triggers

Introduce a dedicated service/handler (or equivalent) when ANY of the following is true:

1) External boundary involved
   - Database, HTTP call, queue, filesystem, cache, OS process, crypto, time, randomness

2) Non-trivial business logic
   - More than simple mapping/formatting
   - Multiple branches with domain meaning
   - Policy decisions that must be unit tested independently

3) Reuse is expected
   - The logic will be used by >1 entry point or consumer

4) Transaction / consistency boundary needed
   - Transaction scope, unit-of-work, idempotency, retries, outbox, concurrency

5) Multi-step workflow or orchestration
   - Several operations in sequence with failure paths

6) Multiple meaningful outcomes
   - Distinct domain outcomes that drive response codes/events/side effects

If none of the above apply, keep it minimal.

---

## Input model and validation triggers

Introduce a request DTO and validator when ANY of the following is true:

1) Input is non-trivial
   - Nested structures, collections, multiple fields, conditional requirements

2) Validation is non-trivial
   - Cross-field rules, format rules, range rules, allow-lists, domain constraints

3) Consistency across entry points is required
   - Standardised validation error output or shared rules

If input is trivial and there are no real validation rules:
- Prefer primitives (or a simple query/body shape) and avoid a validator.

---

## Interface triggers (avoid speculative seams)

Introduce a new interface only when at least one is true:

1) It abstracts an external boundary (port/adapter)
2) There are >= 2 real variants now or planned with evidence
3) The construction varies by environment and must be encapsulated
4) A cross-cutting concern requires decoration

Otherwise:
- Prefer a concrete type.

---

## Practical examples

Minimal is correct:
- A health-check/ping endpoint returning a constant
- A simple consumer that forwards a message to one existing service
- A job that invokes one existing domain operation

Escalation is correct:
- Any new DB query or write
- Any new external HTTP integration
- Any new workflow with compensation/retry/idempotency
- Any logic with multiple domain outcomes

---

## Output expectation for AI assistants

When creating new types (DTO/service/interface/validator), state which trigger(s) justified it.
When staying minimal, state why triggers did not apply.
