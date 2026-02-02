# How-to Files — Definition & Construction Guide

## Purpose
How-to files provide **deterministic, step-by-step procedural instructions** for performing a specific task correctly within the DevKit.

They exist to tell an implementer *exactly how to do something*, not to decide *whether* or *when* to do it.

## Exists to help the reader:
- Execute a known task safely and correctly
- Follow an approved sequence of steps without improvisation
- Avoid missing required actions or evidence
- Apply contracts consistently during execution

## A How-to answers:
- “How do I do X correctly?”
- “What are the exact steps?”
- “What evidence or artefacts must I produce?”
- “What does correct execution look like?”

## A How-to is NOT:
- NOT a set of enforceable rules (contract)
- NOT judgement or decision guidance (playbook)
- NOT a checklist or completion gate
- NOT a tutorial or explanation of theory

## What a good How-to achieves:
- Is executable without interpretation
- Is safe to follow linearly
- Produces predictable results
- Makes required evidence explicit
- References the relevant contracts without restating them

## Canonical structure

```
# <file name>

## When to use this
- One short statement describing when this procedure applies.

## Steps
1) Write each step as a concrete action.
2) Steps must be ordered and complete.
3) If a decision is required, make it explicit:
   - “If X, do A. Otherwise, do B.”

Rules for steps:
Ordered, numbered steps written in imperative form.
Each step must be:
- Concrete
- Actionable
- Unambiguous

## Evidence to capture (what to record in PR / review)
- Explicit list of artefacts, decisions, or proofs required.

## Examples
- Minimal, focused examples illustrating correct and incorrect execution.

## Cross-references
- Link to the governing contract(s)
- Link to relevant playbooks or checklists if applicable
- Use DevKit-relative paths only
```

## Writing guidance
- Use imperative language (“Do X”, “Verify Y”)
- Avoid MUST / SHOULD language (that belongs in contracts)
- Avoid judgement language (“consider”, “prefer”) unless unavoidable
- Keep scope narrow: one task per how-to