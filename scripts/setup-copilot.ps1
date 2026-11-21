# setup-copilot.ps1
# Setup script to configure Copilot with AI Agents Rogue

param(
    [string]$Target = ".",
    [string]$CatalogRoot = ""
)

$ErrorActionPreference = "Stop"

if (-not $CatalogRoot) {
    $CatalogRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
} else {
    $CatalogRoot = (Resolve-Path $CatalogRoot).Path
}

$TargetRoot = (Resolve-Path $Target).Path

# Ensure Copilot directory exists
$copilotDir = Join-Path $TargetRoot ".copilot"
Ensure-Dir $copilotDir

# Ensure subdirectories
Ensure-Dir (Join-Path $copilotDir "skills")
Ensure-Dir (Join-Path $copilotDir "commands")
Ensure-Dir (Join-Path $copilotDir "agents\roles")

# Copy skills from catalog
Copy-Skills (Join-Path $TargetRoot ".copilot\skills")
Copy-Commands (Join-Path $TargetRoot ".copilot\commands")
Copy-Roles (Join-Path $TargetRoot ".copilot\agents\roles")

Write-Host "Copilot setup complete."
Write-Host "  Skills: .copilot\skills\"
Write-Host "  Commands: .copilot\commands\"
Write-Host "  Roles: .copilot\agents\roles\"
