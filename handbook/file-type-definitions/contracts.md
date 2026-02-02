# Contract Files — Definition & Construction Guide

## Purpose
Contracts define **hard, enforceable constraints** that determine whether code or artefacts are compliant.

They represent **machine law** within the DevKit.

## Exists to help the reader:
- Know what is allowed and disallowed
- Prevent unsafe or invalid designs
- Enforce consistency across implementations
- Provide unambiguous review criteria

## A Contract answers:
- “Is this allowed?”
- “Is this compliant?”
- “Can this ship?”
- “Is this a violation?”

## A Contract is NOT:
- NOT guidance or advice (playbook)
- NOT procedural steps (how-to)
- NOT a checklist
- NOT a tutorial or rationale document

## What a good Contract achieves:
- Binary evaluation (pass / fail)
- Clear enforcement boundaries
- Minimal ambiguity
- Long-term stability
- Safe automation and review

## Canonical structure

```
# <Contract title>

## Scope
Defines exactly what this contract governs and where it applies.
Must clearly state boundaries and exclusions.

## Rules
Enforceable constraints written using:
- MUST
- MUST NOT
- MAY

Rules must be deterministic and testable.

## Prohibited patterns
Explicit anti-patterns that must never occur.
Often expressed as MUST NOT statements.

## Allowed deviations
Explicit, limited exceptions to the rules.
May be empty, but the section must exist.

## Cross-references
Links to:
- Playbooks for decision guidance
- How-to files for execution
- Related contracts
```

## Writing guidance
- Use precise, declarative language
- Avoid examples inside Rules and Prohibited patterns
- Avoid procedural or advisory wording
- Avoid subjective or aesthetic language
