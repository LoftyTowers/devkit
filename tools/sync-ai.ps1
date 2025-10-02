param(
  [string]$Target = ".devkit"
)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$src  = (Resolve-Path (Join-Path $root "..")).Path

if (-not (Test-Path $Target)) { New-Item -ItemType Directory -Path $Target | Out-Null }
robocopy $src $Target /MIR /XD .git .github tools
Write-Host "Synced devkit to $Target"
