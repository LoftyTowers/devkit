# DevKit 🧠  
*A reusable AI-assisted coding framework for senior-level code generation.*

---

### Start Here
The canonical .NET example is in [examples/dotnet/layered-microservice](examples/dotnet/layered-microservice/).
It demonstrates the full layered structure (API → Application → Domain → Infrastructure → Shared → Tests).

## 🚀 Setup Instructions

### 1. Clone or download this DevKit
Open PowerShell or your terminal and run:
```bash
cd G:\Programming
git clone https://github.com/LoftyTowers/devkit.git
```

*(Or your own private fork if you’ve made one.)*

---

### 2. Copy the DevKit into a project

When you start a new project (or want to update an existing one), run:

#### On **Windows (PowerShell)**
```powershell
cd path\to\your\project
powershell -ExecutionPolicy Bypass -File G:\Programming\devkit\tools\sync-ai.ps1
```

#### On **macOS / Linux**
```bash
cd path/to/your/project
bash G:/Programming/devkit/tools/sync-ai.sh
```

This creates a hidden `.devkit/` folder inside your project containing the latest DevKit rules, style guides, examples, and preludes.

---

### 3. Exclude DevKit from Git

Run this once in each client repo to prevent accidental commits:

```powershell
powershell -ExecutionPolicy Bypass -File G:\Programming\devkit\tools\setup-hooks.ps1
```

This does two things:
1. Adds `.devkit/` to your `.git/info/exclude` (local ignore that never syncs to remote).  
2. Installs a **pre-commit hook** that blocks `.devkit/` or `.local/` files from being committed.

To verify:
```powershell
type .git\info\exclude
```
You should see:
```
.devkit/
```

---

### 4. (Optional) Run a dry sync to preview changes

```powershell
powershell -ExecutionPolicy Bypass -File G:\Programming\devkit\tools\sync-ai.ps1 -DryRun
```

This lists files that *would* be updated without touching your current `.devkit`.

---

## ⚙️ How It Works

### Overview
DevKit provides a **private, personal framework** that guides AI tools (like Cursor, Copilot, or ChatGPT) to write consistent, senior-level code in your preferred style.  
It’s not a dependency — it’s a local, invisible companion that shapes how AI writes and reviews your code.

---

### Folder structure
```
devkit/
├── general/              # Shared engineering philosophy, checklists, and design recipes
├── languages/
│   ├── dotnet/           # .NET-specific style, recipes, and libraries
│   └── python/           # Placeholder for other languages
├── examples/             # Fully-worked code examples (Controllers, Patterns, etc.)
├── preludes/             # AI preload instructions (“what to follow before coding”)
└── tools/                # Helper scripts to sync and protect DevKit
```

---

### Sync process (under the hood)
When you run a sync script:

- `sync-ai.ps1` or `sync-ai.sh` copies all DevKit content (except `.git`, `.github`, and `tools`) into your target project.  
- The target folder defaults to `.devkit/`, but you can choose another name (e.g. `.ai/`).
- A `.last_sync.txt` timestamp records when you last synced.
- If `.devkit/.local/` exists, it’s preserved — so you can safely keep per-project overrides.

---

### Integration with AI tools

Once synced, you can tell any AI assistant:

> “Load and follow the rules in `.devkit/preludes/prelude-dotnet.md` before generating code.”

That prelude acts as a **senior developer’s checklist** — enforcing:
- Clean architecture & SOLID boundaries  
- Logging, validation, and error-handling conventions  
- Proper async + cancellation usage  
- Standard test coverage (NUnit + Moq + FluentAssertions)  
- Consistent extensibility and naming patterns  

---

### Safe isolation
- The `.devkit` folder **never appears in version control** (it’s excluded locally).  
- Clients never see it — but your AI still reads it.  
- You can freely update your DevKit repo without touching client codebases.

---

### Updating across projects
To update all projects that use your DevKit:
1. Pull the latest changes in `G:\Programming\devkit`.
2. In each project:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\tools\sync-ai.ps1
   ```
   or re-run:
   ```bash
   bash G:/Programming/devkit/tools/sync-ai.sh
   ```

---

### Validation (optional)
You can check the integrity of your DevKit setup anytime:
```powershell
powershell -ExecutionPolicy Bypass -File tools\validate-devkit.ps1
```
This confirms that required files, mapping policies, and compliance notes exist.

---

### Key principle
> The DevKit doesn’t write code for you — it teaches your AI *how you* write code.

It’s your architecture, your rules, automated.
