# DevKit AI Prelude

Purpose:
Define how to apply DevKit rules to a codebase, keep changes safe, and route uncertainty.
Use this before MANIFEST and contracts.
Preserve existing behaviour unless explicitly instructed to change it.
If unsure, leave a review item with a clear reason.

Non-negotiable rules:
- MUST NOT guess; if uncertain, create or keep review items.
- MUST preserve behaviour and prefer minimal diffs.
- MUST NOT add dependencies without recording a rationale.
- MUST NOT weaken security controls without explicit instruction.
- MUST NOT log secrets or PII.
- MUST treat all DevKit content as read-only; do not modify DevKit files.

Instruction precedence:
1. PRELUDE
2. MANIFEST
3. Project-specific instructions (when explicitly provided for this repo or task)
4. Contracts
   - General contracts apply by default.
   - Language-specific contracts override general contracts when working in that language.
5. Coding best practices

Conflict handling:
- If project-specific instructions explicitly conflict with a contract, follow the project-specific instruction for this project.
- Do not assume a conflict. If unclear, route to review and ask for a decision.
- Security-related weakening (e.g. logging secrets, disabling auth or validation) requires explicit instruction and must be recorded.

Output contract for any task:
- what changed
- why (linked to contract file)
- what remains in review (with paths)
- how to verify (tests, build, run)

Content routing:
- Apply DevKit rules to the project’s code and configuration only.
- If required behaviour is missing or unclear, record a review item.
- Do not modify, patch, or extend DevKit content as part of project work.
- Define these concepts locally in the project's own namespaces.
- Do not reference or compile DevKit files directly into the application.
