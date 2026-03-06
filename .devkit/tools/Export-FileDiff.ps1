# File: .devkit/tools/Export-FileDiff.ps1
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
  [switch] $IncludeBeforeFromHead
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Ensure-Dir {
  param([Parameter(Mandatory = $true)][string] $Path)
  if (-not (Test-Path -LiteralPath $Path)) {
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
  }
}

function Assert-GitRepo {
  param([Parameter(Mandatory = $true)][string] $RepoRoot)
  $null = git -C $RepoRoot rev-parse --git-dir 2>$null
  if ($LASTEXITCODE -ne 0) { throw "Not a Git repo: $RepoRoot" }
}

function Write-Utf8 {
  param(
    [Parameter(Mandatory = $true)][string] $Path,
    [Parameter(Mandatory = $true)][string] $Content
  )
  $parent = Split-Path -Parent $Path
  if ($parent) { Ensure-Dir -Path $parent }
  Set-Content -LiteralPath $Path -Value $Content -Encoding UTF8
}

function Flatten-Changes {
  param([Parameter(Mandatory = $true)][object] $ChangeSet)

  $all = @()
  foreach ($domain in @("Angular","DotNet","SqlServer","Other")) {
    $items = $ChangeSet.changes.$domain
    foreach ($it in @($items)) {
      if ($null -eq $it) { continue }
      $p = [string]$it.path
      if ([string]::IsNullOrWhiteSpace($p)) { continue }
      if ($p -like ".devkit/*") { continue }

      $all += [pscustomobject]@{
        path    = $p
        status  = [string]$it.status
        source  = [string]$it.source
        oldPath = $it.oldPath
        domain  = $domain
      }
    }
  }

  $prio = @{ staged = 3; unstaged = 2; untracked = 1 }

  $dedup =
    $all |
    Group-Object -Property path |
    ForEach-Object {
      $_.Group |
        Sort-Object { $prio[[string]$_.source] } -Descending |
        Select-Object -First 1
    }

  return @($dedup)
}

function Get-UntrackedFiles {
  param([Parameter(Mandatory = $true)][string] $RepoRoot)
  $untracked = git -C $RepoRoot ls-files --others --exclude-standard 2>$null
  if ($LASTEXITCODE -ne 0) { throw "git ls-files --others failed" }
  return @($untracked | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | ForEach-Object { $_.Trim() })
}

function Git-DiffText {
  param(
    [Parameter(Mandatory = $true)][string] $RepoRoot,
    [Parameter(Mandatory = $true)][string[]] $Args,
    [Parameter(Mandatory = $false)][switch] $AllowExit1,
    [Parameter(Mandatory = $false)][switch] $QuietErrors
  )

  if ($QuietErrors) {
    $out = & git -C $RepoRoot @Args 2>$null
  } else {
    $out = & git -C $RepoRoot @Args
  }

  $code = $LASTEXITCODE

  if ($AllowExit1) {
    # git diff returns:
    # 0 = no differences
    # 1 = differences found (normal for our use)
    # 2 = trouble
    if ($code -eq 0 -or $code -eq 1) {
      return @($out)
    }
    throw ("git {0} failed (exit {1})" -f ($Args -join " "), $code)
  }

  if ($code -ne 0) {
    throw ("git {0} failed (exit {1})" -f ($Args -join " "), $code)
  }

  return @($out)
}

function Invoke-GitQuiet {
  param(
    [Parameter(Mandatory = $true)][string] $RepoRoot,
    [Parameter(Mandatory = $true)][string[]] $Args
  )
  $null = & git -C $RepoRoot @Args 2>$null
  $code = $LASTEXITCODE
  if ($code -ne 0) {
    throw ("git {0} failed (exit {1})" -f ($Args -join " "), $code)
  }
}

function Chunk-Array {
  param(
    [Parameter(Mandatory = $true)][string[]] $Items,
    [Parameter(Mandatory = $true)][int] $ChunkSize
  )
  $chunks = @()
  for ($i = 0; $i -lt $Items.Count; $i += $ChunkSize) {
    $end = [Math]::Min($i + $ChunkSize - 1, $Items.Count - 1)
    $chunks += ,($Items[$i..$end])
  }
  return $chunks
}

# ---- Main ----

$repoPath = (Resolve-Path -LiteralPath $RepoRoot).Path
Assert-GitRepo -RepoRoot $repoPath

$resolvedChangeSetPath = if ([System.IO.Path]::IsPathRooted($ChangeSetPath)) { $ChangeSetPath } else { Join-Path $repoPath $ChangeSetPath }
$resolvedOutputDir     = if ([System.IO.Path]::IsPathRooted($OutputDir))     { $OutputDir }     else { Join-Path $repoPath $OutputDir }

if (-not (Test-Path -LiteralPath $resolvedChangeSetPath)) {
  throw "Change set not found: $resolvedChangeSetPath"
}

Ensure-Dir -Path $resolvedOutputDir
$afterDir      = Join-Path $resolvedOutputDir "after"
$beforeDir     = Join-Path $resolvedOutputDir "before"
$patchPath     = Join-Path $resolvedOutputDir "changes.patch"
$manifestPath  = Join-Path $resolvedOutputDir "filediff-input.json"

if ($Mode -ne "patch") { Ensure-Dir -Path $afterDir }
if ($IncludeBeforeFromHead -and $Mode -ne "patch") { Ensure-Dir -Path $beforeDir }

$changeSet = Get-Content -LiteralPath $resolvedChangeSetPath -Raw | ConvertFrom-Json
$changes   = Flatten-Changes -ChangeSet $changeSet

# --- IMPORTANT ---
# To include untracked/new files in a normal diff WITHOUT staging their contents,
# we use "intent-to-add" (git add -N) temporarily, then revert those paths (git reset -- <paths>).
$intentAdded = @()

try {
  # Patch export
  $patchOut = $null
  if ($Mode -in @("patch","both")) {

    # Find untracked files and temporarily "intent-to-add" them so they appear in git diff.
    $untracked = Get-UntrackedFiles -RepoRoot $repoPath |
      Where-Object { $_ -and ($_ -notlike ".devkit/*") }

    if ($untracked.Count -gt 0) {
      $intentAdded = @($untracked)
      foreach ($chunk in (Chunk-Array -Items $intentAdded -ChunkSize 100)) {
        # -N: intent-to-add; does NOT stage file contents
        Invoke-GitQuiet -RepoRoot $repoPath -Args (@("add","-N","--") + $chunk)
      }
    }

    $stagedLines   = Git-DiffText -RepoRoot $repoPath -Args @("diff","--cached","--no-color") -AllowExit1 -QuietErrors
    $unstagedLines = Git-DiffText -RepoRoot $repoPath -Args @("diff","--no-color")           -AllowExit1 -QuietErrors

    $combined = ""

    $staged = ($stagedLines -join "`n")
    if (-not [string]::IsNullOrWhiteSpace($staged)) { $combined += $staged + "`n" }

    $unstaged = ($unstagedLines -join "`n")
    if (-not [string]::IsNullOrWhiteSpace($unstaged)) { $combined += $unstaged + "`n" }

    Write-Utf8 -Path $patchPath -Content $combined
    $patchOut = (Resolve-Path -LiteralPath $patchPath).Path
  }

  # Bundle export
  # $exported = @()
  # if ($Mode -in @("bundle","both")) {
  #   foreach ($c in @($changes)) {
  #     $rel = $c.path

  #     $after = $null
  #     if ($c.status -ne "D") {
  #       $src = Join-Path $repoPath $rel
  #       if (Test-Path -LiteralPath $src) {
  #         $dst = Join-Path $afterDir $rel
  #         Ensure-Dir -Path (Split-Path -Parent $dst)
  #         Copy-Item -LiteralPath $src -Destination $dst -Force
  #         $after = $dst
  #       }
  #     }

  #     $before = $null
  #     if ($IncludeBeforeFromHead -and ($c.status -in @("M","R","D"))) {
  #       $spec = "HEAD:$rel"
  #       $content = git -C $repoPath show $spec 2>$null
  #       if ($LASTEXITCODE -eq 0 -and $null -ne $content) {
  #         $dst = Join-Path $beforeDir $rel
  #         Ensure-Dir -Path (Split-Path -Parent $dst)
  #         Set-Content -LiteralPath $dst -Value ($content -join "`n") -Encoding UTF8
  #         $before = $dst
  #       }
  #     }

  #     $exported += [pscustomobject]@{
  #       path       = $rel
  #       domain     = $c.domain
  #       status     = $c.status
  #       source     = $c.source
  #       oldPath    = $c.oldPath
  #       afterPath  = $after
  #       beforePath = $before
  #     }
  #   }
  # }

  $out = [ordered]@{
    timestamp = ([DateTimeOffset]::UtcNow.ToString("o"))
    repoRoot  = $repoPath
    changeSet = (Resolve-Path -LiteralPath $resolvedChangeSetPath).Path
    outputDir = (Resolve-Path -LiteralPath $resolvedOutputDir).Path
    mode      = $Mode
    includeBeforeFromHead = [bool]$IncludeBeforeFromHead
    artefacts = [ordered]@{
      patchPath = $patchOut
      afterDir  = if ($Mode -eq "patch") { $null } else { $afterDir }
      beforeDir = if ($IncludeBeforeFromHead -and $Mode -ne "patch") { $beforeDir } else { $null }
    }
    # files = @($exported)
    files = @()
  }

  Write-Utf8 -Path $manifestPath -Content ($out | ConvertTo-Json -Depth 30)

  Write-Host ("FileDiff input exported: {0}" -f $manifestPath)
  $changeCount = @($changes).Count
  Write-Host ("Mode: {0}; Files: {1}; Patch: {2}" -f $Mode, $changeCount, ($(if ($patchOut) { "yes" } else { "no" })))
}
finally {
  # Revert only the "intent-to-add" paths so we don't leave the repo in a modified index state.
  if ($intentAdded.Count -gt 0) {
    foreach ($chunk in (Chunk-Array -Items $intentAdded -ChunkSize 100)) {
      Invoke-GitQuiet -RepoRoot $repoPath -Args (@("reset","-q","--") + $chunk)
    }
  }
}

exit 0