param(
    [string]$InventoryPath = ".devkit/ai/_last-loaded-rules.json"
)

Write-Host "Validating Loaded Rules Inventory..."

if (-not (Test-Path $InventoryPath)) {
    throw "FAIL: Loaded Rules Inventory not found at $InventoryPath"
}

try {
    $inventory = Get-Content $InventoryPath -Raw | ConvertFrom-Json
}
catch {
    throw "FAIL: Inventory file is not valid JSON."
}

if (-not $inventory.routes -or $inventory.routes.Count -eq 0) {
    throw "FAIL: No routes declared in inventory."
}

if (-not $inventory.loadedFiles -or $inventory.loadedFiles.Count -eq 0) {
    throw "FAIL: No loadedFiles declared in inventory."
}

foreach ($file in $inventory.loadedFiles) {
    if (-not (Test-Path $file)) {
        throw "FAIL: Loaded file does not exist: $file"
    }
}

Write-Host "Loaded Rules Inventory validation passed."
