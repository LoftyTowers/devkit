# DevKit AI Entry Point

Purpose:
This file is the canonical entry point for AI-assisted work using this DevKit.
It defines the minimum, deterministic load sequence.

This file contains no technical rules.
Do not infer rules from this file.

## Load sequence (always)

1) Read `.devkit/ai/PRELUDE.md`
2) Read `.devkit/ai/MANIFEST.md`
3) From MANIFEST, load only the files explicitly listed in the selected route(s).
   - Do NOT glob folders.
   - Do NOT load "relevant files under" any directory unless the route explicitly lists them.

Then stop and wait for the task instruction, unless the task instruction is already present.

## If a referenced file is missing

- Do not guess.
- Stop and report:
  - the missing path
  - what you were trying to do
  - the minimum information needed to proceed

## How to resolve conflicts (precedence)

When instructions conflict, use this order (highest to lowest):

1) User-specific task instructions (explicit instructions for this task)
2) Project-specific overrides (only if explicitly provided)
3) Language-specific contracts (e.g. `.devkit/contracts/dotnet/*`)
4) General contracts (e.g. `.devkit/contracts/general/*`)
5) Checklists (procedural completion gates)
6) How-to / Playbooks (advisory guidance)
7) General best practices

If you follow a higher-priority item that overrides a lower-priority one, record the override as a review item.

## Constraints

- Do not reference or compile DevKit files into the application.
- Apply DevKit rules to the project code and configuration only.

## Required reporting (for any task with code changes)

Before making any changes, you MUST output a "Loaded Rules Inventory" that includes:
- The selected MANIFEST route(s)
- The ordered list of loaded file paths (exactly as listed by the route(s))

Do not begin project work until this inventory has been produced.
