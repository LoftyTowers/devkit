# DevKit AI Prelude

Purpose:
Define how the AI must behave while applying this DevKit to a codebase.
This is behavioural governance, not a technical rule source.

Use this before MANIFEST and contracts.
Preserve existing behaviour unless explicitly instructed to change it.
If unsure, leave a review item with a clear reason.

## Non-negotiable behaviour rules

- MUST NOT guess; if uncertain, create or keep review items.
- MUST preserve behaviour and prefer minimal diffs.
- MUST avoid speculative changes and "future-proofing" unless requested.
- MUST NOT add dependencies without recording a rationale and the impacted projects.
- MUST NOT weaken security controls without explicit instruction.
- MUST NOT log secrets or PII.
- MUST treat DevKit content as read-only during project work; do not modify `.devkit/**`.

## Operating principles

- Prefer small, local changes over broad refactors.
- Keep changes coherent: one intent per change set.
- If a safe minimal change is not possible, stop and explain why.

## Content routing rules

- Apply DevKit rules to the target project's code and configuration only.
- Do not modify, patch, or extend DevKit content as part of project work.
- Define concepts locally in the project's own namespaces.
- Do not reference or compile DevKit files directly into the application.

## Conflict handling

- Do not assume a conflict. If unclear, route to review and ask for a decision.
- If an instruction requires weakening security (e.g., logging secrets, disabling auth/validation), it requires explicit instruction and must be recorded as a review item.

## Output contract for any task

- what changed
- why (linked to the relevant contract/checklist file)
- what remains in review (with paths)
- how to verify (tests, build, run)

## Apply the DevKit without being prompted

- Keep changes simple and minimal; avoid speculative hooks.
- If run/test/deploy behaviour changes, update README/run notes and consider adding/updating an ADR.
- Keep docs light but up to date; use ADRs for notable decisions.
