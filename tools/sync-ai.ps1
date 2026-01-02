param(
  [string]$Target = ".devkit"
)

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $root "..")).Path
$src = Join-Path $repoRoot ".devkit"

if (-not (Test-Path $src)) {
  throw "Source .devkit folder not found at: $src"
}

if (-not (Test-Path $Target)) {
  New-Item -ItemType Directory -Path $Target | Out-Null
}

# Mirror only the DevKit instruction pack
robocopy $src $Target /MIR

# Robocopy uses exit codes; 0-7 are success (including "files copied")
if ($LASTEXITCODE -gt 7) {
  throw "Robocopy failed with exit code $LASTEXITCODE"
}

Write-Host "Synced DevKit instructions from $src to $Target"
