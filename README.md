# DevKit 🧠
*A reusable AI-assisted coding framework for senior-level code generation.*

---

### Start Here
The canonical .NET example is in [examples/dotnet/layered-microservice](examples/dotnet/layered-microservice/), showing the full layered structure (API → Application → Domain → Infrastructure → Shared → Tests). Angular and SQL scaffolds live under `examples/angular` and `examples/SQL`.

## 🚀 Setup Instructions

### 1. Clone or download this DevKit
Open PowerShell or your terminal and run:
```bash
cd G:\Programming
git clone https://github.com/LoftyTowers/devkit.git
```

*(Or your own private fork if you’ve made one.)*

---

### 2. Copy the DevKit into a project (or refresh an existing one)

#### On **Windows (PowerShell)**
From the root of the project you want to seed or update:
```powershell
& "G:\Programming\devkit\tools\sync-ai.ps1" ".devkit"
```

`sync-ai.ps1` mirrors the repo into the target folder (default `.devkit`). Pass a different folder name if you prefer (for example, `.ai`).

#### On **macOS / Linux**
```bash
cd path/to/your/project
bash G:/Programming/devkit/tools/sync-ai.sh .devkit
```

---

### 3. Keep DevKit out of Git
Add a local exclude so `.devkit/` never lands in commits:

```bash
echo ".devkit/" >> .git/info/exclude
```

This keeps the synced guidance private to your machine while letting you update it freely.

---

## ⚙️ What’s Inside

```
devkit/
├── examples/             # Worked examples (layered microservice, patterns, Angular, SQL)
├── general/              # Shared engineering philosophy, checklists, and design recipes
├── languages/            # Language-specific style, recipes, and libraries (dotnet, etc.)
├── preludes/             # AI preload instructions (“what to follow before coding”)
└── tools/                # Helper scripts to sync DevKit into projects
```

The sync scripts copy everything except `.git`, `.github`, and `tools` into your target folder using `robocopy` (Windows) or `rsync` (macOS/Linux).

---

## 🧩 Using DevKit with AI tools

Once synced, tell your AI assistant to preload the appropriate prelude, for example:

> “Load and follow `.devkit/preludes/prelude-dotnet.md` before generating code.”

That prelude acts as a **senior developer’s checklist** — covering architecture boundaries, validation, logging, async/cancellation, testing patterns, and naming conventions.

---

## 🔁 Updating across projects
1. Pull the latest changes in `G:\Programming\devkit`.
2. In each project, rerun the sync command (e.g., `& "G:\Programming\devkit\tools\sync-ai.ps1" ".devkit"`).

---

## 🧭 Key principle
> The DevKit doesn’t write code for you — it teaches your AI *how you* write code.

It’s your architecture, your rules, automated.
