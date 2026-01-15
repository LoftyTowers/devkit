# DevKit 🧠
*A reusable AI-assisted coding framework for senior-level code generation.*

---

## 🚀 Setup Instructions

### 1. Clone or download this DevKit
Open PowerShell or your terminal and run:
```bash
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

This creates a hidden `.devkit/` folder inside your project containing the latest DevKit rules, style guides, examples, and preludes.

---

### 3. Keep DevKit out of Git
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

## ⚙️ What’s Inside

```
.devkit/
├── ai/
├── contracts/
│   ├── general/
│   └── dotnet/
├── checklists/
│   ├── general/
│   └── dotnet/
├── how-to/
│   └── dotnet/
└── playbooks/
```
The sync scripts copy `.devkit/` into your target project and exclude `.git`, `.github`, and `tools`.

---

## 🧩 Using DevKit with AI tools

Before starting any coding task, provide your AI assistant (Cursor, Copilot, ChatGPT, etc.) with the following DevKit Prep Prompt.

This forces the model to preload your architecture, coding style, error handling rules, DI usage, Result<T>/ErrorCode approach, structured logging, NUnit tests, and csproj management rules.

## DevKit Prep Prompt

```
READ THESE FILES BEFORE DOING ANYTHING:

DEVKIT SESSION INITIALISATION

You are working in this repository using the DevKit.

Start at `.devkit/ENTRY-POINT.md` and follow its instructions exactly.

This is a long-running task.
Load the full DevKit as instructed by the entry point.
Do not cherry-pick or partially load rules.

After loading, confirm (max 6 bullets):
- Which language scope(s) you have loaded (e.g. .NET)
- That the DevKit has been fully loaded from the entry point
- Any known areas explicitly marked to ignore for now (if instructed)
- The key non-negotiables you will enforce
- That you are ready to receive the task

Then STOP.
Do not write any code until I give you the task.
```

## Why this matters

This prompt ensures your AI-generated code:

- obeys your architectural boundaries  
- enforces strict method-wrapped try/catch  
- uses structured logging  
- adopts Result<T> + ErrorCode  
- implements DI properly  
- uses asynchronous patterns consistently  
- writes NUnit tests, not xUnit  
- updates .csproj files when new libraries are needed  
- follows DevKit naming, style, and validation rules  
- only introduces new patterns when explicitly permitted  

This creates a predictable, professional, senior-quality codebase across projects.

---

## 🧭 Key principle
> The DevKit doesn’t write code for you - it teaches your AI *how you* write code.

It’s your architecture, your rules, automated.
