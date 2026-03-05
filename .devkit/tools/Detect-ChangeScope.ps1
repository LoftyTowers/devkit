# File: tools/Detect-ChangeScope.ps1
[CmdletBinding()]
param(
  [Parameter(Mandatory = $false)]
  [string] $RepoRoot = ".",

  [Parameter(Mandatory = $false)]
  [string] $OutputPath = ".devkit/artifacts/changeset.json",

  [Parameter(Mandatory = $false)]
  [switch] $IncludeUntracked,

  [Parameter(Mandatory = $false)]
  [switch] $FailIfDevkitChanged
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Ensure-ParentDirectory {
  [CmdletBinding()]
  param([Parameter(Mandatory = $true)][string] $Path)

  $parent = Split-Path -Parent $Path
  if ([string]::IsNullOrWhiteSpace($parent)) { return }
  if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }
}

function Invoke-Git {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)][string] $RepoRoot,
    [Parameter(Mandatory = $true)][string[]] $Args
  )

  $psi = [System.Diagnostics.ProcessStartInfo]::new()
  $psi.FileName = "git"
  $psi.Arguments = ($Args -join " ")
  $psi.WorkingDirectory = (Resolve-Path -LiteralPath $RepoRoot).Path
  $psi.RedirectStandardOutput = $true
  $psi.RedirectStandardError  = $true
  $psi.UseShellExecute = $false
  $psi.CreateNoWindow = $true

  $p = [System.Diagnostics.Process]::new()
  $p.StartInfo = $psi
  [void]$p.Start()
  $stdout = $p.StandardOutput.ReadToEnd()
  $stderr = $p.StandardError.ReadToEnd()
  $p.WaitForExit()

  return [pscustomobject]@{
    ExitCode = $p.ExitCode
    StdOut   = $stdout
    StdErr   = $stderr
  }
}

function Get-GitTextOrNull {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)][string] $RepoRoot,
    [Parameter(Mandatory = $true)][string[]] $Args
  )

  $res = Invoke-Git -RepoRoot $RepoRoot -Args $Args
  if ($res.ExitCode -ne 0) { return $null }
  return ($res.StdOut ?? "").TrimEnd()
}

function Test-IsDevKitPath {
  [CmdletBinding()]
  param([Parameter(Mandatory = $true)][string] $Path)

  $p = $Path.Replace("\","/").TrimStart("./")
  return ($p -eq ".devkit" -or $p.StartsWith(".devkit/"))
}

function Get-DomainForPath {
  [CmdletBinding()]
  param([Parameter(Mandatory = $true)][string] $Path)

  $p = $Path.Replace("\","/").ToLowerInvariant()

  # Dotnet
  if ($p.EndsWith(".cs") -or $p.EndsWith(".csproj") -or $p.EndsWith(".sln") -or
      $p.EndsWith(".fsproj") -or $p.EndsWith(".vbproj") -or
      $p.EndsWith("directory.build.props") -or $p.EndsWith("directory.build.targets") -or
      ($p -like "*appsettings*.json")) {
    return "DotNet"
  }

  # SQL Server
  if ($p.EndsWith(".sql") -or $p.StartsWith("db/") -or $p -like "*migrations/*") {
    return "SqlServer"
  }

  # Angular
  if ($p -eq "angular.json" -or $p -eq "tsconfig.json" -or
      $p.EndsWith("package.json") -or
      $p.EndsWith(".ts") -or $p.EndsWith(".html") -or $p.EndsWith(".scss")) {
    # tighten Angular detection: only treat TS/HTML/SCSS as Angular if under typical frontend roots
    if ($p -like "src/*" -or $p -like "apps/*" -or $p -like "projects/*" -or
        $p -eq "angular.json" -or $p -eq "tsconfig.json" -or $p.EndsWith("package.json")) {
      return "Angular"
    }
  }

  return "Other"
}

function Parse-NameStatusLines {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [AllowNull()]
    [AllowEmptyString()]
    [string] $Text,

    [Parameter(Mandatory = $true)]
    [string] $Source
  )

  $items = New-Object System.Collections.Generic.List[object]
  if ([string]::IsNullOrWhiteSpace($Text)) { return $items }

  $lines = $Text -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }

  foreach ($line in $lines) {
    # git diff --name-status format: <status>\t<path> or R100\t<old>\t<new>
    $parts = $line -split "`t"
    if ($parts.Count -lt 2) { continue }

    $statusRaw = $parts[0].Trim()
    $status = $statusRaw.Substring(0,1).ToUpperInvariant()

    if ($status -eq "R" -and $parts.Count -ge 3) {
      $oldPath = $parts[1].Trim()
      $newPath = $parts[2].Trim()

      $items.Add([pscustomobject]@{
        path      = $newPath
        oldPath   = $oldPath
        status    = "R"
        source    = $Source
        domain    = (Get-DomainForPath -Path $newPath)
        isDevKit  = (Test-IsDevKitPath -Path $newPath)
      })
      continue
    }

    $path = $parts[1].Trim()
    $items.Add([pscustomobject]@{
      path      = $path
      oldPath   = $null
      status    = $status
      source    = $Source
      domain    = (Get-DomainForPath -Path $path)
      isDevKit  = (Test-IsDevKitPath -Path $path)
    })
  }

  return $items
}

function Get-UntrackedFiles {
  [CmdletBinding()]
  param([Parameter(Mandatory = $true)][string] $RepoRoot)

  # untracked, excluding ignored: git ls-files --others --exclude-standard
  $txt = Get-GitTextOrNull -RepoRoot $RepoRoot -Args @("ls-files","--others","--exclude-standard")
  $items = New-Object System.Collections.Generic.List[object]
  if ([string]::IsNullOrWhiteSpace($txt)) { return $items }

  foreach ($line in ($txt -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })) {
    $path = $line.Trim()
    $items.Add([pscustomobject]@{
      path      = $path
      oldPath   = $null
      status    = "U"
      source    = "untracked"
      domain    = (Get-DomainForPath -Path $path)
      isDevKit  = (Test-IsDevKitPath -Path $path)
    })
  }

  return $items
}

# ---- Main ----

$repoPath = (Resolve-Path -LiteralPath $RepoRoot).Path

# Ensure we're in a git repo (light check)
$gitDir = Get-GitTextOrNull -RepoRoot $repoPath -Args @("rev-parse","--git-dir")
if ([string]::IsNullOrWhiteSpace($gitDir)) {
  throw "Not a Git repository: $repoPath"
}

$unstagedText = Get-GitTextOrNull -RepoRoot $repoPath -Args @("diff","--name-status")
$stagedText   = Get-GitTextOrNull -RepoRoot $repoPath -Args @("diff","--cached","--name-status")

$changes = New-Object System.Collections.Generic.List[object]
$changes.AddRange(@(Parse-NameStatusLines -Text $unstagedText -Source "unstaged"))
$changes.AddRange(@(Parse-NameStatusLines -Text $stagedText   -Source "staged"))

if ($IncludeUntracked) {
  $changes.AddRange(@(Get-UntrackedFiles -RepoRoot $repoPath))
}

# De-dupe by path preferring staged over unstaged, and treating untracked as lowest priority
$priority = @{
  staged    = 3
  unstaged  = 2
  untracked = 1
}

$dedup = $changes |
  Group-Object -Property path |
  ForEach-Object {
    $_.Group | Sort-Object { $priority[$_.source] } -Descending | Select-Object -First 1
  }

# Remove DevKit changes from export (but optionally fail if any exist)
$devkitChanged = @($dedup | Where-Object { $_.isDevKit })
if ($FailIfDevkitChanged -and $devkitChanged.Count -gt 0) {
  $paths = ($devkitChanged | Select-Object -ExpandProperty path) -join ", "
  throw "DevKit files changed (forbidden): $paths"
}

$filtered = @($dedup | Where-Object { -not $_.isDevKit })

# Group by domain
$byDomain = [ordered]@{
  Angular   = @()
  DotNet    = @()
  SqlServer = @()
  Other     = @()
}

foreach ($c in $filtered) {
  switch ($c.domain) {
    "Angular"   { $byDomain.Angular   += $c; break }
    "DotNet"    { $byDomain.DotNet    += $c; break }
    "SqlServer" { $byDomain.SqlServer += $c; break }
    default     { $byDomain.Other     += $c; break }
  }
}

$head = Get-GitTextOrNull -RepoRoot $repoPath -Args @("rev-parse","--short","HEAD")
$branch = Get-GitTextOrNull -RepoRoot $repoPath -Args @("rev-parse","--abbrev-ref","HEAD")

$timestampUtc = [DateTimeOffset]::UtcNow.ToString("o")

$summary = [ordered]@{
  totalFiles = $filtered.Count
  angular    = @($byDomain.Angular).Count
  dotnet     = @($byDomain.DotNet).Count
  sqlserver  = @($byDomain.SqlServer).Count
  other      = @($byDomain.Other).Count
  devkitChangedExcluded = $devkitChanged.Count
}

$outObj = [ordered]@{
  timestamp = $timestampUtc
  repoRoot  = $repoPath
  git       = [ordered]@{
    head   = $head
    branch = $branch
  }
  summary   = $summary
  changes   = [ordered]@{
    Angular   = @($byDomain.Angular   | ForEach-Object { [ordered]@{ path = $_.path; status = $_.status; source = $_.source; oldPath = $_.oldPath } })
    DotNet    = @($byDomain.DotNet    | ForEach-Object { [ordered]@{ path = $_.path; status = $_.status; source = $_.source; oldPath = $_.oldPath } })
    SqlServer = @($byDomain.SqlServer | ForEach-Object { [ordered]@{ path = $_.path; status = $_.status; source = $_.source; oldPath = $_.oldPath } })
    Other     = @($byDomain.Other     | ForEach-Object { [ordered]@{ path = $_.path; status = $_.status; source = $_.source; oldPath = $_.oldPath } })
  }
}

Ensure-ParentDirectory -Path $OutputPath
$json = $outObj | ConvertTo-Json -Depth 20
Set-Content -LiteralPath $OutputPath -Value $json -Encoding UTF8

Write-Host ("Wrote change set: {0} (files: {1}; Angular {2}, DotNet {3}, Sql {4}, Other {5})" -f $OutputPath, $summary.totalFiles, $summary.angular, $summary.dotnet, $summary.sqlserver, $summary.other)