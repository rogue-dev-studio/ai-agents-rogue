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

function Ensure-Dir([string]$Path) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# Ensure Copilot directory exists
$githubDir = Join-Path $TargetRoot ".github"
Ensure-Dir $githubDir

# Ensure subdirectories
Ensure-Dir (Join-Path $githubDir "skills")
Ensure-Dir (Join-Path $githubDir "agents")
Ensure-Dir (Join-Path $githubDir "instructions")

# Copy basic instructions
$instrSrc = Join-Path $CatalogRoot "core\instructions\copilot-instructions.md"
if (Test-Path $instrSrc) {
    Copy-Item $instrSrc (Join-Path $githubDir "copilot-instructions.md") -Force
}

# Note: Full skill/agent sync is handled by install.ps1 via Catalog mapping
Write-Host "Copilot setup complete."
Write-Host "  Instructions: .github\copilot-instructions.md"
Write-Host "  Skills: .github\skills\"
Write-Host "  Agents: .github\agents\"
Write-Host "  Instructions: .github\instructions\"
