$ErrorActionPreference = "Stop"

Write-Host "Running DevKit verification..."

# 1) Validate rule inventory (PowerShell script => use try/catch, not $LASTEXITCODE)
try {
    & ".devkit/tools/devkit-validate-inventory.ps1"
}
catch {
    throw "Inventory validation failed. $($_.Exception.Message)"
}

# 2) Angular checks (if package.json exists)
if (Test-Path "package.json") {
    Write-Host "Running npm install..."
    npm install
    if ($LASTEXITCODE -ne 0) { throw "npm install failed." }

    Write-Host "Running lint..."
    npm run lint
    if ($LASTEXITCODE -ne 0) { throw "Lint failed." }

    Write-Host "Running tests..."
    npm test
    if ($LASTEXITCODE -ne 0) { throw "Tests failed." }

    Write-Host "Running build..."
    npm run build
    if ($LASTEXITCODE -ne 0) { throw "Build failed." }
}

# 3) .NET checks (if solution exists)
$excludeDirs = @(
    "\node_modules\",
    "\.git\",
    "\dist\",
    "\build\",
    "\.angular\",
    "\.devkit\",
    "\bin\",
    "\obj\"
)

$solution = Get-ChildItem -Recurse -File -Filter *.sln -ErrorAction SilentlyContinue |
    Where-Object {
        $path = $_.FullName.ToLowerInvariant()
        foreach ($dir in $excludeDirs) {
            if ($path -like "*$($dir.ToLowerInvariant())*") {
                return $false
            }
        }
        return $true
    } |
    Select-Object -First 1
    
if ($solution) {
    Write-Host "Running dotnet restore..."
    dotnet restore
    if ($LASTEXITCODE -ne 0) { throw "dotnet restore failed." }

    Write-Host "Running dotnet build..."
    dotnet build --no-restore
    if ($LASTEXITCODE -ne 0) { throw ".NET build failed." }

    Write-Host "Running dotnet test..."
    dotnet test --no-build
    if ($LASTEXITCODE -ne 0) { throw ".NET tests failed." }
}

Write-Host "DevKit verification passed."