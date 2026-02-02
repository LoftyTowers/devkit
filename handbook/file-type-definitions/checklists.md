# Checklist Files — Definition & Construction Guide

## Purpose
Checklist files act as **completion, review, and regression gates**.  
They ensure that all required considerations have been verified after work has been performed.

They do **not** define new rules — they validate that existing contracts and guidance have been applied correctly.

## Exists to help the reader:
- Prove that work is complete and compliant
- Catch omissions and regressions during review
- Enforce consistency across similar changes
- Prevent drift from established contracts

## A Checklist answers:
- “Have I verified everything I was supposed to?”
- “What must be true before this change is accepted?”
- “What should I double-check given what I just modified?”
- “Which contracts or guidance apply to this situation?”

## A Checklist is NOT:
- NOT a source of new rules (contracts)
- NOT procedural instructions (how-to)
- NOT decision guidance (playbook)
- NOT a substitute for reading contracts

## What a good Checklist achieves:
- High signal, low noise verification
- Clear traceability back to contracts
- Repeatable review outcomes
- Fast identification of missing or unsafe changes
- Safe enforcement without reinterpretation

## Canonical structure

```
# <Checklist title>

## Purpose
Brief description of what this checklist verifies and when it should be used.

## Checklist
- [ ] Verification item phrased as “verify X” or “ensure Y”
      (Contract-backed / Playbook-backed / Convention)
      (Optional reference to governing file)

## Notes (optional)
Context or clarification for reviewers.
```

## Writing guidance
- Use verification language (“Ensure…”, “Verify…”, “Confirm…”)
- Prefer “when X happens, verify Y” framing
- Do not restate full contract rules — reference them
- Do not introduce new thresholds or constraints unless explicitly marked as conventions
- Group items by concern area for readability