param(
  [string]$Target = ".devkit",
  [switch]$ForceAgents,
  # Optional override if you want to target a different repo than the current directory
  [string]$ProjectRoot = ""
)

$ErrorActionPreference = "Stop"

# -----------------------------
# Resolve roots correctly
# -----------------------------

# DevKit root = parent of /tools (script location)
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "Script root: $scriptRoot"
$devkitRoot = (Resolve-Path (Join-Path $scriptRoot "..")).Path
Write-Host "DevKit root (source): $devkitRoot"

# Project root = where you ran the script from (unless overridden)
if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
  $projectRootResolved = (Get-Location).Path
} else {
  $projectRootResolved = (Resolve-Path $ProjectRoot).Path
}
Write-Host "Project root (target): $projectRootResolved"

# -----------------------------
# Source pack + target folder
# -----------------------------
$src = Join-Path $devkitRoot ".devkit"
if (-not (Test-Path $src)) {
  throw "Source .devkit folder not found at: $src"
}

# Resolve Target path under project root (supports relative inputs like '.devkit')
$targetPath = $Target
if (-not [System.IO.Path]::IsPathRooted($targetPath)) {
  $targetPath = Join-Path $projectRootResolved $targetPath
}
$targetPath = (Resolve-Path -LiteralPath $targetPath -ErrorAction SilentlyContinue)?.Path ?? $targetPath

if (-not (Test-Path $targetPath)) {
  New-Item -ItemType Directory -Path $targetPath | Out-Null
}

# Mirror only the DevKit instruction pack into the target project
robocopy $src $targetPath /MIR | Out-Null
if ($LASTEXITCODE -gt 7) {
  throw "Robocopy failed with exit code $LASTEXITCODE"
}

Write-Host "Synced DevKit instructions from $src to $targetPath"

# -----------------------------
# Install AGENTS.md into PROJECT root
# -----------------------------
$agentsTemplate = Join-Path $targetPath "ai\AGENTS.md"
if (-not (Test-Path $agentsTemplate)) {
  throw "AGENTS template not found at: $agentsTemplate"
}

$agentsDest = Join-Path $projectRootResolved "AGENTS.md"

$shouldCopy =
  $ForceAgents.IsPresent -or
  (-not (Test-Path $agentsDest)) -or
  ((Get-FileHash $agentsTemplate).Hash -ne (Get-FileHash $agentsDest).Hash)

if ($shouldCopy) {
  Copy-Item -Path $agentsTemplate -Destination $agentsDest -Force
  Write-Host "Installed/Updated AGENTS.md at project root: $agentsDest"
} else {
  Write-Host "AGENTS.md already up to date at project root: $agentsDest"
}

# -----------------------------
# Ensure PROJECT local git exclude contains DevKit exclusions
# -----------------------------
$gitDir = Join-Path $projectRootResolved ".git"
if (-not (Test-Path $gitDir)) {
  throw "No .git directory found at project root: $projectRootResolved"
}

$excludePath = Join-Path $gitDir "info\exclude"
if (-not (Test-Path $excludePath)) {
  New-Item -ItemType File -Path $excludePath -Force | Out-Null
  Write-Host "Created .git/info/exclude in project repo"
}

$requiredEntries = @(
  ".devkit/",
  "AGENTS.md"
)

$existingLines = Get-Content $excludePath -ErrorAction SilentlyContinue
$updated = $false

foreach ($entry in $requiredEntries) {
  if (-not ($existingLines -contains $entry)) {
    Add-Content -Path $excludePath -Value $entry
    Write-Host "Added '$entry' to project .git/info/exclude"
    $updated = $true
  }
}

if (-not $updated) {
  Write-Host "Project .git/info/exclude already contains required entries"
}

Write-Host "Done."