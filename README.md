# devkit
Private engineering kit (rules, patterns, checklists, examples).

## Use in a project (local-only, no repo trace)

1) From the **project root**, hide local-only folders:
   - Add to `.git/info/exclude` (not committed):
     ```
     .devkit/
     .local/
     ```

2) (Optional) Add a local pre-commit guard:
   - Create `.git/hooks/pre-commit`:
     ```bash
     #!/usr/bin/env bash
     if git diff --cached --name-only | grep -E '^(\.devkit/|\.local/)' >/dev/null; then
       echo "Abort: .devkit/.local are local-only. Unstage and try again." >&2
       exit 1
     fi
     ```
     Then `chmod +x .git/hooks/pre-commit`.

3) Sync this devkit into the project:
   - Windows (PowerShell):
     ```
     pwsh -File G:\Programming\devkit\tools\sync-ai.ps1 .devkit
     ```
   - macOS/Linux/WSL:
     ```
     /mnt/g/Programming/devkit/tools/sync-ai.sh .devkit
     ```

4) In Cursor, start tasks with:
# devkit
Private engineering kit (rules, patterns, checklists, examples).

## Use in a project (local-only, no repo trace)

1) From the **project root**, hide local-only folders:
   - Add to `.git/info/exclude` (not committed):
     ```
     .devkit/
     .local/
     ```

2) (Optional) Add a local pre-commit guard:
   - Create `.git/hooks/pre-commit`:
     ```bash
     #!/usr/bin/env bash
     if git diff --cached --name-only | grep -E '^(\.devkit/|\.local/)' >/dev/null; then
       echo "Abort: .devkit/.local are local-only. Unstage and try again." >&2
       exit 1
     fi
     ```
     Then `chmod +x .git/hooks/pre-commit`.

3) Sync this devkit into the project:
   - Windows (PowerShell):
     ```
     pwsh -File G:\Programming\devkit\tools\sync-ai.ps1 .devkit
     ```
   - macOS/Linux/WSL:
     ```
     /mnt/g/Programming/devkit/tools/sync-ai.sh .devkit
     ```

4) In Cursor, start tasks with:
# devkit
Private engineering kit (rules, patterns, checklists, examples).

## Use in a project (local-only, no repo trace)

1) From the **project root**, hide local-only folders:
   - Add to `.git/info/exclude` (not committed):
     ```
     .devkit/
     .local/
     ```

2) (Optional) Add a local pre-commit guard:
   - Create `.git/hooks/pre-commit`:
     ```bash
     #!/usr/bin/env bash
     if git diff --cached --name-only | grep -E '^(\.devkit/|\.local/)' >/dev/null; then
       echo "Abort: .devkit/.local are local-only. Unstage and try again." >&2
       exit 1
     fi
     ```
     Then `chmod +x .git/hooks/pre-commit`.

3) Sync this devkit into the project:
   - Windows (PowerShell):
     ```
     pwsh -File G:\Programming\devkit\tools\sync-ai.ps1 .devkit
     ```
   - macOS/Linux/WSL:
     ```
     /mnt/g/Programming/devkit/tools/sync-ai.sh .devkit
     ```

4) In Cursor, start tasks with:
    - Apply rules from .devkit/charter.md, .devkit/style.md, .devkit/patterns.md, .devkit/checklists.md.