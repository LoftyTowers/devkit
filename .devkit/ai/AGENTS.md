# DevKit Governance — Codex Operating Rules

This repository uses DevKit for deterministic AI governance.

Codex MUST follow this sequence before making any project changes.

------------------------------------------------------------
MANDATORY LOAD SEQUENCE (NON-NEGOTIABLE)
------------------------------------------------------------

1) Read `.devkit/ai/ENTRY-POINT.md`
2) Read `.devkit/ai/PRELUDE.md`
3) Read `.devkit/ai/MANIFEST.md`
4) From MANIFEST:
   - Select the appropriate route(s)
   - Load ONLY the files explicitly listed in those route(s)
   - Do NOT glob directories
   - Do NOT load "related files"
   - Do NOT infer additional routes

After loading the selected route(s), STOP.

Do not begin implementation until the required reporting below is produced.

------------------------------------------------------------
REQUIRED REPORTING (BEFORE ANY CODE CHANGES)
------------------------------------------------------------

You MUST output a section titled:

Loaded Rules Inventory

It MUST contain:

- Selected MANIFEST route(s)
- One-line justification for each selected route
- Ordered list of loaded file paths
  (exactly as listed in the MANIFEST route definition)

If this inventory is missing, incomplete, or vague:
STOP.

------------------------------------------------------------
MANDATORY COMPLIANCE WORKFLOW (IF CHANGING CODE/CONFIG)
------------------------------------------------------------

A) Loaded Rules Inventory (before changes)
   - As defined above.

B) Diff-to-Concern Scan (before completion)
   - Identify files changed
   - Identify technical concerns introduced
   - Confirm each concern is governed by a loaded CONTRACT or CHECKLIST
   - How-to/playbooks do NOT count as coverage for MUST/MUST NOT rules

C) Controlled Dynamic Expansion (only if needed)
   - If a concern is uncovered:
     - Add the minimum route(s) from MANIFEST Expansion allowlist
     - Output:
       trigger -> route(s) added -> newly loaded file paths
   - Do NOT load routes outside the Expansion allowlist

D) Post-change Compliance Sweep
   - Re-check all changes against loaded contracts and applicable checklists
   - If violation found:
       fix once and re-sweep
   - If violations remain:
       STOP and report FAIL with concrete evidence

------------------------------------------------------------
VERIFICATION GATE (REQUIRED BEFORE COMPLETION)
------------------------------------------------------------

Before declaring task completion, you MUST run:

scripts/devkit-verify

If this command fails:
- Do not complete the task
- Fix issues
- Re-run verification

------------------------------------------------------------
STRICT CONSTRAINTS
------------------------------------------------------------

- DevKit files under `.devkit/**` are read-only.
- Do NOT modify DevKit during project work.
- Do NOT compile or reference DevKit content inside the application.
- Do NOT weaken security controls without explicit instruction.
- Do NOT guess missing files.
- If a referenced file is missing: STOP and report.

------------------------------------------------------------
FAILURE CONDITIONS
------------------------------------------------------------

You must STOP immediately if:

- ENTRY-POINT cannot be read
- MANIFEST route cannot be resolved
- A required file is missing
- A concern is uncovered and not permitted for expansion
- Verification fails after one remediation pass

------------------------------------------------------------
PRIORITY ORDER (CONFLICT RESOLUTION)
------------------------------------------------------------

1) Explicit user task instruction
2) Project-specific overrides (if explicitly provided)
3) Language-specific contracts
4) General contracts
5) Checklists
6) How-to / Playbooks
7) General best practices