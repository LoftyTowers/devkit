# File: .devkit/tools/Run-DiffCheck.ps1
[CmdletBinding()]
param(
  [Parameter(Mandatory = $false)]
  [string] $RepoRoot = ".",

  [Parameter(Mandatory = $false)]
  [string] $ChangeSetPath = ".devkit/artifacts/changeset.json",

  [Parameter(Mandatory = $false)]
  [string] $OutputDir = ".devkit/artifacts/FileDiffsExport",

  [Parameter(Mandatory = $false)]
  [ValidateSet("patch","bundle","both")]
  [string] $Mode = "both",

  [Parameter(Mandatory = $false)]
  [switch] $FailIfDevkitChanged,

  [Parameter(Mandatory = $false)]
  [switch] $IncludeBeforeFromHead
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-RepoPath {
  param(
    [Parameter(Mandatory = $true)][string] $RepoRoot,
    [Parameter(Mandatory = $true)][string] $Path
  )
  if ([System.IO.Path]::IsPathRooted($Path)) { return $Path }
  return (Join-Path $RepoRoot $Path)
}

$repoPath = (Resolve-Path -LiteralPath $RepoRoot).Path
$ChangeSetPath = Resolve-RepoPath -RepoRoot $repoPath -Path $ChangeSetPath
$OutputDir     = Resolve-RepoPath -RepoRoot $repoPath -Path $OutputDir

$detectScript = Join-Path $repoPath ".devkit\tools\Detect-ChangeScope.ps1"
$exportScript = Join-Path $repoPath ".devkit\tools\Export-FileDiff.ps1"

if (-not (Test-Path -LiteralPath $detectScript)) { throw "Missing script: $detectScript" }
if (-not (Test-Path -LiteralPath $exportScript)) { throw "Missing script: $exportScript" }

# --- 1) Detect change scope ONCE (always include untracked) ---
$detectParams = @{
  RepoRoot         = $repoPath
  OutputPath       = $ChangeSetPath
  IncludeUntracked = $true
}
if ($FailIfDevkitChanged) { $detectParams.FailIfDevkitChanged = $true }

& $detectScript @detectParams
$detectExit = $LASTEXITCODE

# Detect may return non-zero even after writing a valid changeset (e.g. warnings).
# Only treat it as fatal when FailIfDevkitChanged was explicitly requested.
if ($detectExit -ne 0 -and $FailIfDevkitChanged) {
  throw "Detect-ChangeScope failed (exit $detectExit)"
}
elseif ($detectExit -ne 0) {
  Write-Warning ("Detect-ChangeScope returned exit {0}. Continuing because -FailIfDevkitChanged was not set." -f $detectExit)
}

# --- 2) Export file diffs ONCE ---
$exportParams = @{
  RepoRoot      = $repoPath
  ChangeSetPath = $ChangeSetPath
  OutputDir     = $OutputDir
  Mode          = $Mode
}
if ($IncludeBeforeFromHead) { $exportParams.IncludeBeforeFromHead = $true }

& $exportScript @exportParams
$exportExit = $LASTEXITCODE
if ($exportExit -ne 0) { throw "Export-FileDiff failed (exit $exportExit)" }

Write-Host ("Done. ChangeSet: {0} | Output: {1}" -f $ChangeSetPath, $OutputDir)