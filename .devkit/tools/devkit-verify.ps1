Write-Host "Running DevKit verification..."

# 1) Validate rule inventory
& ".devkit/tools/devkit-validate-inventory.ps1"

if ($LASTEXITCODE -ne 0) {
    throw "Inventory validation failed."
}

# 2) Angular checks (if package.json exists)
if (Test-Path "package.json") {
    Write-Host "Running npm install..."
    npm install

    Write-Host "Running lint..."
    npm run lint

    if ($LASTEXITCODE -ne 0) {
        throw "Lint failed."
    }

    Write-Host "Running tests..."
    npm test

    if ($LASTEXITCODE -ne 0) {
        throw "Tests failed."
    }

    Write-Host "Running build..."
    npm run build

    if ($LASTEXITCODE -ne 0) {
        throw "Build failed."
    }
}

# 3) .NET checks (if solution exists)
$solution = Get-ChildItem -Filter *.sln -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

if ($solution) {
    Write-Host "Running dotnet restore..."
    dotnet restore

    Write-Host "Running dotnet build..."
    dotnet build --no-restore

    if ($LASTEXITCODE -ne 0) {
        throw ".NET build failed."
    }

    Write-Host "Running dotnet test..."
    dotnet test --no-build

    if ($LASTEXITCODE -ne 0) {
        throw ".NET tests failed."
    }
}

Write-Host "DevKit verification passed."